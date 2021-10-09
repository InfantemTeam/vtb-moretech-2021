#!/usr/bin/env python3

import quart.flask_patch  # must be first import
import aiohttp
from quart import *
from quart_auth import *
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import *

app = Quart(__name__)
app.config.from_object('config')
am = AuthManager(app)
db = SQLAlchemy(app)


class User(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	email = db.Column(db.String(255), unique=True)
	password = db.Column(db.String(255))
	vk_id = db.Column(db.Integer, unique=True)

class Profile(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	age = db.Column(db.Integer)
	education = db.Column(db.Integer)
	wage = db.Column(db.Integer)

db.create_all()
db.session.commit()


@app.route('/api/login', methods=('POST',))
async def api_login():
	form = await request.form
	try: email, password = form['email'], form['password']
	except Exception as ex: return abort(400, ex)

	user = User.query.filter_by(email=email).first()
	if (not user or not check_password_hash(user.password, password)): return abort(403)

	login_user(AuthUser(user.id))

	return 'OK'

@app.route('/api/logout')
async def api_logout():
	logout_user()

	return 'OK'

@app.route('/api/register', methods=('POST',))
async def api_register():
	form = await request.form
	try: email, password = form['email'], form['password']
	except Exception as ex: return abort(400, ex)

	if (User.query.filter_by(email=email).first()): return abort(409)

	user = User(email=email, password=generate_password_hash(password))

	db.session.add(user)
	db.session.commit()

	return 'OK'

@app.route('/oauth/vk')
async def oauth_vk():
	return Response("<script>let xhr = new XMLHttpRequest(); xhr.open('POST', '/api/oauth/vk'); xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); xhr.send(location.hash.substr(1))</script>", mimetype='text/html')

@app.route('/api/oauth/vk', methods=('POST',))
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

	return 'OK'

@app.route('/api/profile', methods=('GET', 'POST'))
@login_required
async def api_profile():
	user = User.query.filter_by(id=current_user.auth_id).first()
	assert (user)

	profile = Profile.query.filter_by(id=user.id).first()

	if (request.method == 'GET'): return ({'age': profile.age, 'education': profile.education, 'wage': profile.wage} if (profile) else {})

	if (not profile): profile = Profile()

	form = await request.form
	try: age, education, wage = int(form['age']), int(form['education']), int(form['wage'])
	except Exception as ex: return abort(400, ex)

	profile.age, profile.education, profile.wage = age, education, wage

	db.session.add(profile)
	db.session.commit()

	return 'OK'


def main():
	app.env = 'development'
	app.run('unix', '///tmp/vtb.sock', debug=True)

if (__name__ == '__main__'): exit(main())

# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
