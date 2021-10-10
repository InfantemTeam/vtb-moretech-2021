#!/usr/bin/env python3

from . import *

games = Blueprint('games', __name__, template_folder='games/templates')


@games.route('/games/<game>/')
async def games_game_html(game):
	try: return await render_template(game+'.html')
	except jinja2.TemplateNotFound: abort(404)

@games.route('/games/<path:file>')
async def games_file(file):
	return await send_from_directory('games/static', file)


# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
