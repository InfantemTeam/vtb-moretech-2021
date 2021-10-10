#!/usr/bin/env python3

import quart.flask_patch  # must be first import
import jinja2, aiohttp
from quart import *
from quart_auth import *
from werkzeug.security import *

# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
