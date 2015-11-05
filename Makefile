.PHONY: all clean freeze dev_run pip python dev_install

venv: venv/bin/activate

pip: venv/bin/pip

python: venv/bin/python

freeze: pip
	venv/bin/pip install -Ur requirements.txt --log ./freeze_log.txt
	venv/bin/pip freeze > requirements.txt --log ./freeze_log.txt
	scripts/pip_requirements_commit.bash

dev_install:
	sudo aptitude update && sudo aptitude upgrade
	echo "\nStart install with apt installs:\n"
	sudo aptitude install python-dev python-virtualenv libmysqlclient-dev python-openssl rabbitmq-server
	echo "\nInstalling pip packages:\n"
	test -d venv || virtualenv venv
	$(MAKE) freeze

### To be corrected/fixed
## Development run of app //Make sure .*_env files are present
dev_run: python freeze
	echo "\nStarting up without gunicorn in debug mode:\n"
	scripts/init_flask_app_dev.bash

clean:
	rm -rf *.pyc
