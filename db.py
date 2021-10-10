#!/usr/bin/env python3

from flask_sqlalchemy import SQLAlchemy
from .app import *

db = SQLAlchemy(app)


class User(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	email = db.Column(db.String(255), unique=True)
	password = db.Column(db.String(255))
	vk_id = db.Column(db.Integer, unique=True)
	telegram_id = db.Column(db.Integer, unique=True)

class Profile(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	age = db.Column(db.Integer)
	education = db.Column(db.Integer)
	wage = db.Column(db.Integer)
	level = db.Column(db.Integer)
	progress = db.Column(db.Float)


db.create_all()
db.session.commit()

# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
