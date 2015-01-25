import os
import sys
reload(sys)
sys.setdefaultencoding("utf8")
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'site-packages.zip'))

import sae
from xp import wsgi

application = sae.create_wsgi_app(wsgi.application)
