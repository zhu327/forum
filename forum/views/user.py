# coding: utf-8

from django.shortcuts import render_to_response, redirect, \
    get_object_or_404, get_list_or_404
from django.http import Http404
from django.contrib import auth
from django.template import RequestContext


def get_register(request):
    auth.logout(request)
    return render_to_response('user/register.html',
        context_instance=RequestContext(request))
