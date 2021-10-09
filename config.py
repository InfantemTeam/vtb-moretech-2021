import os.path

SQLALCHEMY_DATABASE_URI = 'sqlite:///'+os.path.join(os.path.dirname(__file__), 'db.sqlite')
SQLALCHEMY_TRACK_MODIFICATIONS = False

SECRET_KEY = 'v76_d3v_53cr37'
