import json
import requests
from db import db, User, Meme
from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy


db_filename = 'memeapp.db'
app = Flask(__name__)
imgflipUsername = "annabel48lin"
imgflipPassword = "helloworld"

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = False

db.init_app(app)

template_list = {
    'Distracted Boyfriend': 112126428,
    'Batman Slapping Robin': 438680,
    'One Does Not Simply': 61579,
    'Two Buttons': 87743020,
    'Mocking Spongebob': 102156234,
    'Ancient Aliens': 101470,
    'Woman Yelling At Cat': 188390779,
    'Drake Hotline Bling': 181913649,
    'Expanding Brain': 93895088,
    'Futurama Fry': 61520,
    'Left Exit 12 Off Ramp': 124822590,
    'Change My Mind': 129242436,
    'Roll Safe Think About It': 89370399,
    'Waiting Skeleton': 4087833,
    'X, X Everywhere': 91538330,
    'Boardroom Meeting Suggestion': 1035805,
    'The Most Interesting Man In The World': 61532,
    'Bad Luck Brian': 61585,
    'Blank Nut Button': 119139145,
    'Leonardo Dicaprio Cheers': 5496396,
    'First World Problems': 61539,
    'Surprised Pikachu': 155067746,
    'Doge': 8072285,
    'Y U No': 61527,
    'Disaster Girl': 97984,
    'Y\'all Got Any More Of That': 124055727,
    'Brace Yourselves X is Coming': 61546,
    'Creepy Condescending Wonka': 61582,
    'The Rock Driving': 21735,
    'Oprah You Get A': 28251713,
    'That Would Be Great': 563423,
    'Grumpy Cat': 405658,
    'X All The Y': 61533,
    'Captain Picard Facepalm': 1509839,
    'Third World Skeptical Kid': 101288,
    'But Thats None Of My Business': 16464531,
    'Is This A Pigeon': 100777631,
    'Inhaling Seagull': 114585149,
    'The Scroll Of Truth': 123999232,
    'Finding Neverland': 6235864,
    'Matrix Morpheus': 100947,
    'Black Girl Wat': 14230520,
    'Picard Wtf': 245898,
    'Hide the Pain Harold': 27813981,
    'Dont You Squidward': 101511,
    'American Chopper Argument': 134797956,
    'Success Kid': 61544,
    'Philosoraptor': 61516,
    'Grandma Finds The Internet': 61556,
    'Evil Toddler': 235589,
    '10 Guy': 101440,
    'Star Wars Yoda': 14371066,
    'Running Away Balloon': 131087935,
    'Evil Kermit': 84341851,
    'Trump Bill Signing': 91545132,
    'Dr Evil Laser': 40945639,
    'Third World Success Kid': 101287,
    'Am I The Only One Around Here': 259680,
    'Laughing Men In Suits': 922147,
    'Too Damn High': 61580,
    'Face You Make Robert Downey Jr': 9440985,
    'Tuxedo Winnie The Pooh': 178591752,
    'Yo Dawg Heard You': 101716,
    'Spongebob Ight Imma Head Out': 196652226,
    'Put It Somewhere Else Patrick': 61581,
    'Ill Just Wait Here': 109765,
    'Who Would Win?': 101910402,
    'Marked Safe From': 161865971,
    'Unsettled Tom': 175540452,
    'Bad Pun Dog': 12403754,
    'Confession Bear': 100955,
    'Be Like Bill': 56225174,
    'Back In My Day': 718432,
    'Sparta Leonidas': 195389,
    'Aaaaand Its Gone': 766986,
    'Steve Harvey': 143601,
    'Hard To Swallow Pills': 132769734,
    'Awkward Moment Sealion': 13757816,
    'Maury Lie Detector': 444501,
    'Mugatu So Hot Right Now': 21604248,
    'Conspiracy Keanu': 61583,
    'Say That Again I Dare You': 124212,
    'Who Killed Hannibal': 135678846,
    'Aint Nobody Got Time For That': 442575,
    'And everybody loses their minds': 1790995,
    'This Is Where I\'d Put My Trophy If I Had One': 3218037,
    'Imagination Spongebob': 163573,
    'Skeptical Baby': 101711,
    'Archer': 10628640,
    'Jack Sparrow Being Chased': 460541,
    'See Nobody Cares': 6531067,
    'Scumbag Steve': 61522,
    'I Should Buy A Boat Cat': 1367068,
    'Pepperidge Farm Remembers': 1232104,
    'Me And The Boys': 184801100,
    'Marvel Civil War 1': 28034788,
    'Simba Shadowy Place': 371382,
    'Uncle Sam': 89655,
    'Buddy Christ': 17699,
    'Look At Me': 29617627
}


with app.app_context():
    db.create_all()

@app.route('/api/templates/')
def get_templates():
    return json.dumps({'success':True, 'data': template_list})

@app.route('/')
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

@app.route('/api/users/signin/', methods = ['POST'])
def signin():
    post_body = json.loads(request.data)
    username = post_body.get('username')
    password = post_body.get('password')

    user = User.query.filter_by(username = username).first()
    if not user:
        return json.dumps({'success': False, 'error': 'User does not exist!'}), 404
    
    if (user.password) == password:
        return json.dumps({'success': True, 'data': user.serialize()}), 200
    return json.dumps({'success': False, 'error': 'Password is incorrect!'}), 401


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
    print(name)

    toSend = 'http://api.imgflip.com/caption_image?'
    toSend += 'template_id=' + str(template_id) + '&'
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


@app.route('/api/user/<int:user_id>/')
def get_user(user_id):
    user = User.query.filter_by(id = user_id).first()
    if not user:
        return json.dumps({'success': False, 'error': 'User not found!'}), 404
    return json.dumps({'success': True, 'data': user.serialize()}), 200



@app.route('/api/user/<int:user_id>/memes/<int:meme_id>/', methods = ['DELETE'])
def delete_meme(meme_id, user_id):
    meme = Meme.query.filter_by(id = meme_id).first()
    if not meme:
        return json.dumps({'success': False, 'error': 'Meme does not exist!'}), 404

    if (meme.creator_id == user_id):
        db.session.delete(meme)
        db.session.commit()
        return json.dumps({'success': True}), 201
    return json.dumps({'success': False, 'error': 'You did not create this meme!'}), 401



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
