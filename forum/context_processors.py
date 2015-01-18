# coding: utf-8

def custom_proc(request):
    return dict(
        navigation_bar = [
            ('/', 'topic', u'社区'),
            ('/members/', 'members', u'成员'),
            ('/hots/', 'hots', u'热门'),
            ('/nodes/', 'nodes', u'节点'),
            ('/info/', 'info', u'信息'),
        ],
    )
