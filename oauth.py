#!/usr/bin/env python3

from . import *

oauth = Blueprint('oauth', __name__, template_folder='oauth/templates')


@oauth.route('/oauth/<site>')
async def oauth_site(site):
	try: return render_template(site+'.html')
	except jinja2.TemplateNotFound: abort(404)


# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
