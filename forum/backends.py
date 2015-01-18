# coding: utf-8

from forum.models import ForumUser

class EmailAuthBackend(object):

    def authenticate(self, username=None, password=None):
        try:
            user = ForumUser.objects.get(email=username)
            if user.check_password(password) and user.is_staff:
                return user
            return None
        except ForumUser.DoesNotExist:
            return None

    def get_user(self, user_id):
        try:
            return ForumUser.objects.get(pk=user_id)
        except ForumUser.DoesNotExist:
            return None
