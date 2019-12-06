import json
import requests
from db import db, User, Meme
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy


db_filename = 'cms_sim.db'
app = Flask(__name__)
imgflipUsername = "annabel48lin"
imgflipPassword = "helloworld"

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = False

db.init_app(app)

with app.app_context():
    db.create_all()

@app.route('/api/users/')
def get_users():
    users = User.query.all()
    res = {'success': True, 'data': [u.serialize() for u in users]}
    return json.dumps(res), 200

@app.route('/api/users/signup/', methods = ['POST'])
def signup():
    post_body = json.loads(request.data)
    username = post_body.get('username')
    password = post_body.get('password')

    usernameExists = User.query.filter_by(username = username).first()
    if not usernameExists:
        user = User(
            username = username,
            password = password
        )
        db.session.add(user)
        db.session.commit()
        return json.dumps({'success': True, 'data': user.serialize()}), 201

    return json.dumps({'success': False, 'error': 'Username taken!'}), 404

@app.route('/api/user/<int:user_id>/create/', methods = ['POST'])
def create_meme(user_id):

    usernameExists = User.query.filter_by(id = user_id).first()
    if not usernameExists:
        return json.dumps({'success': False, 'error': 'User does not exist!'}), 404
    
    post_body = json.loads(request.data)
    template_id = post_body.get('template_id')
    text0 = post_body.get('text0')
    text1 = post_body.get('text1')
    font = post_body.get('font')
    name = post_body.get('name')

    #http://api.imgflip.com/caption_image?template_id=16464531&text0=when you're bad at everything&text1=hello&font="impact"&username=annabel48lin&password=helloworld

    toSend = 'http://api.imgflip.com/caption_image?'
    toSend += 'template_id=' + template_id + '&'
    toSend += 'text0=' + text0 + '&'
    toSend += 'text1=' + text1 + '&'
    toSend += 'font=' + font + '&'
    toSend += 'username=' + imgflipUsername + '&'
    toSend += 'password=' + imgflipPassword

    res = requests.post(toSend)

    if (res.json()['success'] == True):
        
        meme = Meme(
            name = name,
            url = res.json()['data']['url'],
            creator_id = user_id
        )

        db.session.add(meme)
        db.session.commit()

        return json.dumps({'success': True, 'data': meme.serialize()}), 201

    else:
        return json.dumps({'success': False, 'error': "@ios you did something wrong"}), 400



@app.route('/api/user/memes/<int:meme_id>/', methods = ['POST'])
def delete_meme(meme_id):
    meme = Meme.query.filter_by(id = meme_id).first()
    if not meme:
        return json.dumps({'success': False, 'error': 'Meme does not exist!'}), 404

    db.session.delete(meme)
    db.session.commit()


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
