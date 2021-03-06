SHELL = bash

init:
	pip install -r requirements.txt
	pip install -e .

test: dev
	py.test tests/unittest --runslow --cov=glyph --cov-config tox.ini

integration: dev
	py.test tests --runslow -n8

dev:
	pip install -r requirements.txt
	pip install -r requirements-dev.txt
	pip install -e .

freeze:
	pip install pip-tools
	pip-compile --output-file requirements.txt requirements-to-freeze.txt

doc: dev
	make -C doc clean
	make -C doc html

pypi: dev
	rm -rf dist/*
	python setup.py sdist bdist_wheel
	twine upload dist/*

environment:
	python doc/make_envyml.py
