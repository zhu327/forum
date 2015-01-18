# coding: utf-8

import json, math
from django.http import HttpResponse
from django.shortcuts import render_to_response, redirect
from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.template import RequestContext
from django.utils import timezone
from django.conf import settings
from forum.models import ForumUser, Topic, Favorite, Vote


def get_vote(request):
    user = request.user
    if not user.is_authenticated():
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'user_not_login'
        }), content_type='application/json')

    try:
        topic_id = int(request.GET.get('topic_id'))
    except TypeError:
        topic_id = None
    topic = None
    if topic_id:
        try:
            topic = Topic.objects.get_topic_by_topic_id(topic_id)
        except Topic.DoesNotExist:
            pass

    if not (topic_id and topic):
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'topic_not_exist'
        }), content_type='application/json')

    if user.id == topic.author.id:
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'can_not_vote_your_topic'
        }), content_type='application/json')

    try:
        vote = Vote.objects.get(trigger_user=user, involved_topic=topic)
    except Vote.DoesNotExist:
        vote = None

    if vote:
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'already_voted'
        }), content_type='application/json')

    vote = Vote(trigger_user=user, involved_type=0, involved_topic=topic, \
        involved_user=topic.author, status=0, occurrence_time=timezone.now())
    vote.save()

    # 更新话题作者声誉
    topic_time_diff = timezone.now() - topic.created
    reputation = topic.author.reputation or 0
    reputation = reputation + 2 * math.log((user.reputation or 0) + topic_time_diff.days + 10, 10)
    topic.author.update(reputation=reputation)

    return HttpResponse(json.dumps({
        'success': 1,
        'message': 'thanks_for_your_vote'
    }), content_type='application/json')


def get_favorite(request):
    user = request.user
    if not user.is_authenticated():
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'user_not_login'
        }), content_type='application/json')

    try:
        topic_id = int(request.GET.get('topic_id'))
    except TypeError:
        topic_id = None
    topic = None
    if topic_id:
        try:
            topic = Topic.objects.get_topic_by_topic_id(topic_id)
        except Topic.DoesNotExist:
            pass

    if not (topic_id and topic):
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'topic_not_exist'
        }), content_type='application/json')

    if user.id == topic.author.id:
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'can_not_favorite_your_topic'
        }), content_type='application/json')

    try:
        favorite = Favorite.objects.get(owner_user=user, involved_topic=topic)
    except Favorite.DoesNotExist:
        favorite = None

    if favorite:
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'already_favorited'
        }), content_type='application/json')

    favorite = Favorite(owner_user=user, involved_type=0, involved_topic=topic, created=timezone.now())
    favorite.save()

    # 更新话题作者声誉
    topic_time_diff = timezone.now() - topic.created
    reputation = topic.author.reputation or 0
    reputation = reputation + 2 * math.log((user.reputation or 0) + topic_time_diff.days + 10, 10)
    topic.author.update(reputation=reputation)

    return HttpResponse(json.dumps({
        'success': 1,
        'message': 'cancel_favorite_success'
    }), content_type='application/json')


def get_cancel_favorite(request):
    user = request.user
    if not user.is_authenticated():
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'user_not_login'
        }), content_type='application/json')

    try:
        topic_id = int(request.GET.get('topic_id'))
    except TypeError:
        topic_id = None
    topic = None
    if topic_id:
        try:
            topic = Topic.objects.get_topic_by_topic_id(topic_id)
        except Topic.DoesNotExist:
            pass

    if not (topic_id and topic):
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'topic_not_exist'
        }), content_type='application/json')

    try:
        favorite = Favorite.objects.get(owner_user=user, involved_topic=topic)
    except Favorite.DoesNotExist:
        favorite = None

    if not favorite:
        return HttpResponse(json.dumps({
            'success': 0,
            'message': 'not_been_favorited'
        }), content_type='application/json')

    favorite.delete()

    # 更新话题作者声誉
    topic_time_diff = timezone.now() - topic.created
    reputation = topic.author.reputation or 0
    reputation = reputation + 2 * math.log(user.reputation or 0 + topic_time_diff.days + 10, 10)
    topic.author.update(reputation=reputation)

    return HttpResponse(json.dumps({
        'success': 1,
        'message': 'cancel_favorite_success'
    }), content_type='application/json')


def get_members(request):
    user = request.user
    if user.is_authenticated():
        counter = {
            'topics': user.topic_author.all().count(),
            'replies': user.reply_author.all().count(),
            'favorites': user.fav_user.all().count()
        }
        notifications_count = user.notify_user.filter(status=0).count()

    members = ForumUser.objects.all().order_by('-id')[:49]
    active_members = ForumUser.objects.all().order_by('-last_login')[:49]
    active_page = 'members'
    return render_to_response('topic/members.html', locals(),
        context_instance=RequestContext(request))
