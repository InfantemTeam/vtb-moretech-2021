#!/usr/bin/env python3

from . import *

app = Quart(__name__)
app.config.from_object('config')
am = AuthManager(app)


from .api import api
app.register_blueprint(api)

from .oauth import oauth
app.register_blueprint(oauth)

from .games import games
app.register_blueprint(games)


# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
