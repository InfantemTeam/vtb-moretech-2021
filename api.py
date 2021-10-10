#!/usr/bin/env python3

from . import *
from .db import *

api = Blueprint('api', __name__)


def get_user(user): return {k: v for k in ('id', 'email', 'vk_id') if (v := getattr(user, k, None))}

def with_user(f):
	@login_required
	async def decorated(*args, **kwargs):
		user = User.query.filter_by(id=current_user.auth_id).first()
		assert (user)
		return f(user, *args, **kwargs)
	decorated.__name__ = f.__name__  # endpoint name
	return decorated


@api.route('/api/login', methods=('POST',))
async def api_login():
	form = await request.form
	try: email, password = form['email'], form['password']
	except Exception as ex: return abort(400, ex)

	user = User.query.filter_by(email=email).first()
	if (not user): return abort(418)
	if (not check_password_hash(user.password, password)): return abort(403)

	login_user(AuthUser(user.id))

	return get_user(user)

@api.route('/api/logout')
async def api_logout():
	logout_user()

	return {}

@api.route('/api/register', methods=('POST',))
async def api_register():
	form = await request.form
	try: email, password = form['email'], form['password']
	except Exception as ex: return abort(400, ex)

	if (User.query.filter_by(email=email).first()): return abort(409)

	user = User(email=email, password=generate_password_hash(password))

	db.session.add(user)
	db.session.commit()

	login_user(AuthUser(user.id))

	return get_user(user)

@api.route('/api/oauth/vk', methods=('POST',))
async def api_oauth_vk():
	form = await request.form
	try: access_token, user_id = form['access_token'], int(form['user_id'])
	except Exception as ex: return abort(400, ex)

	async with aiohttp.ClientSession() as session:
		async with session.get(f"https://api.vk.com/method/users.get?access_token={access_token}&v=5.131") as resp:
			r = await resp.json()
	if ('error' in r): return abort(403, r['error'])
	vk_id = r['response'][0]['id']

	if (vk_id != user_id): return abort(406)

	user = User.query.filter_by(vk_id=vk_id).first()
	if (not user):
		user = User(vk_id=vk_id)
		db.session.add(user)
		db.session.commit()

	login_user(AuthUser(user.id))

	return get_user(user)

@api.route('/api/user')
@with_user
async def api_user(user):
	return get_user(user)

@api.route('/api/profile', methods=('GET', 'POST'))
@with_user
async def api_profile(user):
	profile = Profile.query.filter_by(id=user.id).first()

	if (request.method == 'GET'): return ({k: v for k in ('age', 'education', 'wage') if (v := getattr(profile, k, None))} if (profile) else {})

	if (not profile): profile = Profile()

	form = await request.form
	try: age, education, wage = int(form['age']), int(form['education']), int(form['wage'])
	except Exception as ex: return abort(400, ex)

	profile.age, profile.education, profile.wage = age, education, wage

	db.session.add(profile)
	db.session.commit()

	return {}

@api.route('/api/level', methods=('GET', 'POST'))
@with_user
async def api_level(user):
	profile = Profile.query.filter_by(id=user.id).first()

	if (request.method == 'GET'): return str(profile.level)

	if (not profile): profile = Profile()

	try: level = int(await request.get_data())
	except Exception as ex: return abort(400, ex)

	profile.level = level

	db.session.add(profile)
	db.session.commit()

	return ''

@api.route('/api/progress', methods=('GET', 'POST'))
@with_user
async def api_progress(user):
	profile = Profile.query.filter_by(id=user.id).first()

	if (request.method == 'GET'): return str(profile.progress)

	if (not profile): profile = Profile()

	try: progress = int(await request.get_data())
	except Exception as ex: return abort(400, ex)

	profile.progress = progress

	db.session.add(profile)
	db.session.commit()

	return ''


# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
