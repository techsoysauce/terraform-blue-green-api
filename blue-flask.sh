#!/bin/bash
set -e


sudo su
yum update -y
yum install -y python-virtualenv
pip3 install virtualenv
mkdir flaskapp
cd flaskapp
virtualenv venv
. venv/bin/activate
pip install --upgrade pip
pip install Flask
cat > app.py << EOF
import flask
from flask import render_template

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "<p style='font-size:50px;color:blue;'>This is the BLUE environment.</p>"


@app.route('/version', methods=['GET'])
def api_version():
    return render_template('version.html')


app.run()




EOF

set FLASK_APP=app.py
set FLASK_DEBUG=true

mkdir templates
touch templates/version.html
echo "${api_version}" > templates/version.html
echo "Load Balanced Server Number: ${file_content}" >> templates/version.html

flask run --host=0.0.0.0  --port=80




