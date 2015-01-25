# coding: utf-8

import re
from django.http import Http404
from django.conf import settings
from sae.mail import EmailMessage


def method_splitter(request, *args, **kwargs):
    get_view = kwargs.pop('GET', None)
    post_view = kwargs.pop('POST', None)
    if request.method == 'GET' and get_view is not None:
        return get_view(request, *args, **kwargs)
    elif request.method == 'POST' and post_view is not None:
        return post_view(request, *args, **kwargs)
    raise Http404

def sendmail(title, content, to):
    m = EmailMessage()
    m.to = to
    m.subject = title
    m.html = content
    m.smtp = (settings.EMAIL_HOST, settings.EMAIL_PORT,
        settings.DEFAULT_FROM_EMAIL, settings.EMAIL_HOST_PASSWORD, False)
    m.send()


def find_mentions(content):
    regex = re.compile(ur'@(?P<username>\w+)(\s|$)', re.I)
    return set([m.group('username') for m in regex.finditer(content)])
