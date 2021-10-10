#!/usr/bin/env python3

from .app import app


def main():
	app.env = 'development'
	app.run('unix', '///tmp/vtb.sock', debug=True)

if (__name__ == '__main__'): exit(main())


# by InfantemTeam <hackathon+moretech@sdore.me>, 2021
# www.sdore.me
