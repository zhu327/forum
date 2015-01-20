# coding: utf-8

import json, math
from django.http import HttpResponse, Http404
from django.shortcuts import render_to_response, redirect, get_object_or_404
from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.template import RequestContext
from django.utils import timezone
from django.conf import settings
from forum.models import ForumUser, Topic, Favorite, Vote, Reply, Node
from forum.forms.topic import ReplyEditForm, CreateForm


@login_required
def get_create(request, slug=None, errors=None):
    pass


@login_required
def post_create(request, slug=None):
    pass


@login_required
def get_edit(request, topic_id, errors=None):
    topic = get_object_or_404(Topic, pk=topic_id)

    user = request.user
    counter = {
        'topics': user.topic_author.all().count(),
        'replies': user.reply_author.all().count(),
        'favorites': user.fav_user.all().count()
    }
    notifications_count = user.notify_user.filter(status=0).count()

    active_page = 'topic'
    return render_to_response('topic/edit.html', locals(),
        context_instance=RequestContext(request))


@login_required
def post_edit(request, topic_id):
    topic = get_object_or_404(Topic, pk=topic_id)

    form = CreateForm(request.POST)
    if not form.is_valid():
        return get_edit(request, topic_id, errors=form.errors)

    user = request.user
    if topic.author.id != user.id:
        errors = {'invalid_permission': u'没有权限修改该主题'}
        return get_edit(request, topic_id, errors=errors)

    topic.title = form.cleaned_data.get('title')
    topic.content = form.cleaned_data.get('content')
    topic.updated = timezone.now()
    topic.last_touched = timezone.now()
    topic.save()

    reputation = user.reputation
    reputation = (reputation or 0) - 2 # 每次修改回复扣除用户威望2点
    reputation = 0 if reputation < 0 else reputation
    user.reputation = reputation
    user.save()

    return redirect('/t/%s/' % topic.id)


@login_required
def get_reply_edit(request, reply_id, errors=None):
    reply = get_object_or_404(Reply, pk=reply_id)
    user = request.user
    counter = {
        'topics': user.topic_author.all().count(),
        'replies': user.reply_author.all().count(),
        'favorites': user.fav_user.all().count()
    }
    notifications_count = user.notify_user.filter(status=0).count()
    active_page = 'topic'
    return render_to_response('topic/reply_edit.html', locals(),
        context_instance=RequestContext(request))


@login_required
def post_reply_edit(request, reply_id):
    reply = get_object_or_404(Reply, pk=reply_id)

    form = ReplyEditForm(request.POST)
    if not form.is_valid():
        return get_reply_edit(request, reply_id, errors=form.errors)

    user = request.user
    if reply.author.id != user.id:
        errors = {'invalid_permission': u'没有权限修改该回复'}
        return get_reply_edit(request, reply_id, errors=errors)

    reply.content = form.cleaned_data.get('content')
    reply.updated = timezone.now()
    reply.save()

    reputation = user.reputation
    reputation = (reputation or 0) - 2 # 每次修改回复扣除用户威望2点
    reputation = 0 if reputation < 0 else reputation
    user.reputation = reputation
    user.save()

    return redirect('/t/%s/' % reply.topic.id)


def get_node_topics(request, slug):
    node = get_object_or_404(Node, slug=slug)

    user = request.user
    if user.is_authenticated():
        counter = {
            'topics': user.topic_author.all().count(),
            'replies': user.reply_author.all().count(),
            'favorites': user.fav_user.all().count()
        }
        notifications_count = user.notify_user.filter(status=0).count()

    current_page = int(request.GET.get('p', '1'))

    topics, topic_page = Topic.objects.get_all_topics_by_node_slug(node_slug=slug, current_page=current_page)
    active_page = 'topic'
    return render_to_response('topic/node_topics.html', locals(),
        context_instance=RequestContext(request))


def get_user_topics(request, uid):
    try:
        if uid.isdigit():
            user_info = ForumUser.objects.get(pk=uid)
        else:
            user_info = ForumUser.objects.get(username=uid)
    except ForumUser.DoesNotExist:
        raise Http404

    current_page = int(request.GET.get('p', '1'))
    counter = {
        'topics': user_info.topic_author.all().count(),
        'replies': user_info.reply_author.all().count(),
        'favorites': user_info.fav_user.all().count()
    }

    user = request.user
    if user.is_authenticated():
        notifications_count = user.notify_user.filter(status=0).count()

    topics, topic_page = Topic.objects.get_user_all_topics(user_info.id, current_page=current_page)
    active_page = 'topic'
    return render_to_response('topic/user_topics.html', locals(),
        context_instance=RequestContext(request))


def get_user_replies(request, uid):
    try:
        if uid.isdigit():
            user_info = ForumUser.objects.get(pk=uid)
        else:
            user_info = ForumUser.objects.get(username=uid)
    except ForumUser.DoesNotExist:
        raise Http404

    current_page = int(request.GET.get('p', '1'))
    counter = {
        'topics': user_info.topic_author.all().count(),
        'replies': user_info.reply_author.all().count(),
        'favorites': user_info.fav_user.all().count()
    }

    user = request.user
    if user.is_authenticated():
        notifications_count = user.notify_user.filter(status=0).count()

    replies, reply_page = Reply.objects.get_user_all_replies(user_info.id, current_page=current_page)
    active_page = 'topic'
    return render_to_response('topic/user_replies.html', locals(),
        context_instance=RequestContext(request))


def get_user_favorites(request, uid):
    try:
        if uid.isdigit():
            user_info = ForumUser.objects.get(pk=uid)
        else:
            user_info = ForumUser.objects.get(username=uid)
    except ForumUser.DoesNotExist:
        raise Http404

    current_page = int(request.GET.get('p', '1'))
    counter = {
        'topics': user_info.topic_author.all().count(),
        'replies': user_info.reply_author.all().count(),
        'favorites': user_info.fav_user.all().count()
    }

    user = request.user
    if user.is_authenticated():
        notifications_count = user.notify_user.filter(status=0).count()

    favorites, favorite_page = Favorite.objects.get_user_all_favorites(user_info.id, current_page=current_page)
    active_page = 'topic'
    return render_to_response('topic/user_favorites.html', locals(),
        context_instance=RequestContext(request))


def get_profile(request, uid):
    try:
        if uid.isdigit():
            user_info = ForumUser.objects.get(pk=uid)
        else:
            user_info = ForumUser.objects.get(username=uid)
    except ForumUser.DoesNotExist:
        raise Http404

    current_page = int(request.GET.get('p', '1'))
    counter = {
        'topics': user_info.topic_author.all().count(),
        'replies': user_info.reply_author.all().count(),
        'favorites': user_info.fav_user.all().count()
    }

    user = request.user
    if user.is_authenticated():
        notifications_count = user.notify_user.filter(status=0).count()

    topics, topic_page = Topic.objects.get_user_all_topics(user_info.id, current_page=current_page)
    replies, reply_page = Reply.objects.get_user_all_replies(user_info.id, current_page=current_page)
    active_page = '_blank'
    return render_to_response('topic/profile.html', locals(),
        context_instance=RequestContext(request))


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
