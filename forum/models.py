#coding: utf-8

from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class NormalTextField(models.TextField):
    '''
    models.TextField 默认在MySQL上的数据类型是longtext，用不到那
    么大，所以派生NormalTextField，只修改生成SQL时的数据类型text
    '''
    def db_type(self, connection):
        return 'text'

class Pages(object):
    '''
    分页查询类
    '''
    def __init__(self, count, current_page=1, list_rows=40):
        self.total = count
        self._current = current_page
        self.size = list_rows

    @property
    def pages(self):
        return self.total // self.size + \
            (1 if self.total % self.size else 0)

    def _first(self):
        pages = self.pages
        return (pages == 0) or (self._current < 1) or (self._current > pages)

    @property
    def offset(self):
        if self._first():
            return 0
        return (self.current - 1) * self.size

    @property
    def limit(self):
        if self._first():
            return 0
        return self.size

    @property
    def index(self):
        if self._first():
            return 1
        return self._current

    @property
    def has_prev(self):
        return self.index > 1

    @property
    def has_next(self):
        return self.index < self.pages

class TopicManager(models.Manager):
    '''
    Topic objects
    '''
    def get_all_topic(self, num=36, current_page=1):
        '''
        分页获取所有的话题，并且返回话题作者信息，最后回复信息
        '''
        count = self.get_query_set().count()
        page = Pages(count, current_page, num)
        query = """SELECT topic.*, 
author_user.username as author_username, 
author_user.avatar as author_avatar, 
author_user.id as author_id, 
author_user.reputation as author_reputation, 
node.name as node_name, 
node.slug as node_slug, 
last_replied_user.username as last_replied_username, 
last_replied_user.nickname as last_replied_nickname 
FROM %s AS topic 
LEFT JOIN %s AS author_user ON topic.author_id = author_user.id 
LEFT JOIN %s AS node ON topic.node_id = node.id 
LEFT JOIN %s AS last_replied_user ON topic.last_replied_by = last_replied_user.id 
ORDER BY last_touched DESC, created DESC, last_replied_time DESC, id DESC LIMIT ?, ?"""
        query = (query % (Topic._meta.db_table, ForumUser._meta.db_table, \
            Node._meta.db_table, ForumUser._meta.db_table)).replace('?', '%s')
        args = [page.offset, page.limit]
        return self.raw(query, args), page
       

class ForumUser(AbstractUser):
    '''
    django.contrib.auth.models.User 默认User类字段太少，用AbstractUser
    自定义一个User类，增加字段
    '''
    nickname = models.CharField(max_length=200, null=True, blank=True)
    avatar = models.CharField(max_length=200, null=True, blank=True)
    signature = NormalTextField(null=True)
    location = models.CharField(max_length=200, null=True, blank=True)
    website = models.URLField(null=True, blank=True)
    company = models.CharField(max_length=200, null=True, blank=True)
    role = models.IntegerField(null=True, blank=True)
    balance = models.IntegerField(null=True, blank=True)
    reputation = models.IntegerField(null=True, blank=True)
    self_intro = NormalTextField(null=True)
    updated = models.DateTimeField(null=True, blank=True)
    twitter = models.CharField(max_length=200, null=True, blank=True)
    github = models.CharField(max_length=200, null=True, blank=True)
    douban = models.CharField(max_length=200, null=True, blank=True)

class Topic(models.Model):
    '''
    话题表，定义了论坛帖子的基本单位
    '''
    title = NormalTextField(null=True)
    content = NormalTextField(null=True)
    status = models.IntegerField(null=True, blank=True)
    hits = models.IntegerField(null=True, blank=True)
    created = models.DateTimeField(null=True, blank=True)
    updated = models.DateTimeField(null=True, blank=True)
    node_id = models.IntegerField(null=True, blank=True)
    author_id = models.IntegerField(null=True, blank=True)
    reply_count = models.IntegerField(null=True, blank=True)
    last_replied_by = NormalTextField(null=True)
    last_replied_time = models.DateTimeField(null=True, blank=True)
    up_vote = models.IntegerField(null=True, blank=True)
    down_vote = models.IntegerField(null=True, blank=True)
    last_touched = models.DateTimeField(null=True, blank=True)


    objects = TopicManager()

    def __unicode__(self):
        return self.title

class Node(models.Model):
    '''
    论坛板块单位，节点
    '''
    name = models.CharField(max_length=200, null=True)
    slug = NormalTextField(null=True)
    thumb = NormalTextField(null=True)
    introduction = NormalTextField(null=True)
    created = models.CharField(max_length=200, null=True)
    updated = models.CharField(max_length=200, null=True)
    plane_id = models.IntegerField(null=True, blank=True)
    topic_count = models.IntegerField(null=True, blank=True)
    custom_style = NormalTextField(null=True)
    limit_reputation = models.IntegerField(null=True, blank=True)

    def __unicode__(self):
        return self.name
    
