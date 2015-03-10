# coding: utf-8

"SAE kvdb cache backend"

import time
from threading import local

from django.core.cache.backends.base import BaseCache
from django.utils.encoding import force_str
from django.conf import settings

import sae.kvdb


class SaekvdbCache(BaseCache):
    "An implementation of a cache binding using sae kvdb"
    def __init__(self, server, params):
        super(SaekvdbCache, self).__init__(params)

        # The exception type to catch from the underlying library for a key
        # that was not found. This is a ValueError for python-memcache,
        # pylibmc.NotFound for pylibmc, and cmemcache will return None without
        # raising an exception.
        self._lib = sae.kvdb
        self._local = local()

    @property
    def _cache(self):
        # SAE kvdb应该也是C写的所以这里仿照PylibMC用线程局部名称空间
        # PylibMC uses cache options as the 'behaviors' attribute.
        # It also needs to use threadlocals, because some versions of
        # PylibMC don't play well with the GIL.
        client = getattr(self._local, 'client', None)
        if client:
            return client

        client = self._lib.KVClient(debug=settings.DEBUG)
        self._local.client = client

        return client

    def _get_timeout(self, timeout):
        """
        过期时间
        """
        timeout = timeout or self.default_timeout
        timeout += time.time()
        return timeout

    def make_key(self, key, version=None):
        # Python 2 memcache requires the key to be a byte string.
        return force_str(super(SaekvdbCache, self).make_key(key, version))

    def add(self, key, value, timeout=0, version=None):
        '''
        SAE kvdb不能自动过期，所以这里存储的时候多加一个时间戳
        '''
        key = self.make_key(key, version=version)
        obj = {
            'v': value,
            't': self._get_timeout(timeout)
        }
        return self._cache.add(key, obj)

    def get(self, key, default=None, version=None):
        key = self.make_key(key, version=version)
        val = self._cache.get(key)
        now = time.time()
        if val is None:
            return default
        elif val.get('t') < now: # 判断数据是否过期
            self._cache.delete(key)
            return default
        return val.get('v')

    def set(self, key, value, timeout=0, version=None):
        key = self.make_key(key, version=version)
        obj = {
            'v': value,
            't': self._get_timeout(timeout)
        }
        self._cache.set(key, obj)

    def delete(self, key, version=None):
        key = self.make_key(key, version=version)
        self._cache.delete(key)

    def get_many(self, keys, version=None):
        new_keys = [self.make_key(x, version=version) for x in keys]
        ret = self._cache.get_multi(new_keys)
        if ret:
            _ = {}
            m = dict(zip(new_keys, keys))
            now = time.time()
            for k, v in ret.items():
                if v.get('t') < now:
                    self._cache.delete(k)
                    continue
                _[m[k]] = v.get('v')
            ret = _
        return ret

    def close(self, **kwargs):
        self._cache.disconnect_all()

    def incr(self, key, delta=1, version=None):
        key = self.make_key(key, version=version)
        val = self._cache.get(key)
        now = time.time()
        if val is None:
            raise ValueError("Key '%s' not found" % key)
        elif val.get('t') < now:
            self._cache.delete(key)
            raise ValueError("Key '%s' not found" % key)
        new_value = val.get('v') + delta
        obj = {
            't': val.get('t'),
            'v': new_value
        }
        self._cache.set(key, obj)
        return new_value

    def clear(self):
        for k in self._cache.getkeys_by_prefix(''):
            self._cache.delete(k)
