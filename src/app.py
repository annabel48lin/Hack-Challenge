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

def get_blank_meme(template_id):
    
    text0 = " "
    text1 = " "
    font = "impact"
    name = str(template_id)

    toSend = 'http://api.imgflip.com/caption_image?'
    toSend += 'template_id=' + str(template_id) + '&'
    toSend += 'text0=' + text0 + '&'
    toSend += 'text1=' + text1 + '&'
    toSend += 'font=' + font + '&'
    toSend += 'username=' + imgflipUsername + '&'
    toSend += 'password=' + imgflipPassword

    res = requests.post(toSend)

    if (res.json()['success'] == True):
        print(res.json())
        return res.json()['data']['url']
        

template_list = {
    'Distracted Boyfriend': {'id': '112126428', 'url': get_blank_meme(112126428)},
    'Batman Slapping Robin': {'id': '438680', 'url': get_blank_meme(438680)},
    'One Does Not Simply': {'id': '61579', 'url': get_blank_meme(61579)},
    'Two Buttons': {'id': '87743020', 'url': get_blank_meme(87743020)},
    'Mocking Spongebob': {'id': '102156234', 'url': get_blank_meme(102156234)},
    'Ancient Aliens': {'id': '101470', 'url': get_blank_meme(101470)},
    'Woman Yelling At Cat': {'id': '188390779', 'url': get_blank_meme(188390779)},
    'Drake Hotline Bling': {'id': '181913649', 'url': get_blank_meme(181913649)},
    'Expanding Brain': {'id': '93895088', 'url': get_blank_meme(93895088)},
    'Futurama Fry': {'id': '61520', 'url': get_blank_meme(61520)},
    'Left Exit 12 Off Ramp': {'id': '124822590', 'url': get_blank_meme(124822590)},
    'Change My Mind': {'id': '129242436', 'url': get_blank_meme(129242436)},
    'Roll Safe Think About It': {'id': '89370399', 'url': get_blank_meme(89370399)},
    'Waiting Skeleton': {'id': '4087833', 'url': get_blank_meme(4087833)},
    'X, X Everywhere': {'id': '91538330', 'url': get_blank_meme(91538330)},
    'Boardroom Meeting Suggestion': {'id': '1035805', 'url': get_blank_meme(1035805)},
    'The Most Interesting Man In The World': {'id': '61532', 'url': get_blank_meme(61532)},
    'Bad Luck Brian': {'id': '61585', 'url': get_blank_meme(61585)},
    'Blank Nut Button': {'id': '119139145', 'url': get_blank_meme(119139145)},
    'Leonardo Dicaprio Cheers': {'id': '5496396', 'url': get_blank_meme(5496396)},
    'First World Problems': {'id': '61539', 'url': get_blank_meme(61539)},
    'Surprised Pikachu': {'id': '155067746', 'url': get_blank_meme(155067746)},
    'Doge': {'id': '8072285', 'url': get_blank_meme(8072285)},
    'Y U No': {'id': '61527', 'url': get_blank_meme(61527)},
    'Disaster Girl': {'id': '97984', 'url': get_blank_meme(97984)},
    'Y\'all Got Any More Of That': {'id': '124055727', 'url': get_blank_meme(124055727)},
    'Brace Yourselves X is Coming': {'id': '61546', 'url': get_blank_meme(61546)},
    'Creepy Condescending Wonka': {'id': '61582', 'url': get_blank_meme(61582)},
    'The Rock Driving': {'id': '21735', 'url': get_blank_meme(21735)},
    'Oprah You Get A': {'id': '28251713', 'url': get_blank_meme(28251713)},
    'That Would Be Great': {'id': '563423', 'url': get_blank_meme(563423)},
    'Grumpy Cat': {'id': '405658', 'url': get_blank_meme(405658)},
    'X All The Y': {'id': '61533', 'url': get_blank_meme(61533)},
    'Captain Picard Facepalm': {'id': '1509839', 'url': get_blank_meme(1509839)},
    'Third World Skeptical Kid': {'id': '101288', 'url': get_blank_meme(101288)},
    'But Thats None Of My Business': {'id': '16464531', 'url': get_blank_meme(16464531)},
    'Is This A Pigeon': {'id': '100777631', 'url': get_blank_meme(100777631)},
    'Inhaling Seagull': {'id': '114585149', 'url': get_blank_meme(114585149)},
    'The Scroll Of Truth': {'id': '123999232', 'url': get_blank_meme(123999232)},
    'Finding Neverland': {'id': '6235864', 'url': get_blank_meme(6235864)},
    'Matrix Morpheus': {'id': '100947', 'url': get_blank_meme(100947)},
    'Black Girl Wat': {'id': '14230520', 'url': get_blank_meme(14230520)},
    'Picard Wtf': {'id': '245898', 'url': get_blank_meme(245898)},
    'Hide the Pain Harold': {'id': '27813981', 'url': get_blank_meme(27813981)},
    'Dont You Squidward': {'id': '101511', 'url': get_blank_meme(101511)},
    'American Chopper Argument': {'id': '134797956', 'url': get_blank_meme(134797956)},
    'Success Kid': {'id': '61544', 'url': get_blank_meme(61544)},
    'Philosoraptor': {'id': '61516', 'url': get_blank_meme(61516)},
    'Grandma Finds The Internet': {'id': '61556', 'url': get_blank_meme(61556)},
    'Evil Toddler': {'id': '235589', 'url': get_blank_meme(235589)},
    '10 Guy': {'id': '101440', 'url': get_blank_meme(101440)},
    'Star Wars Yoda': {'id': '14371066', 'url': get_blank_meme(14371066)},
    'Running Away Balloon': {'id': '131087935', 'url': get_blank_meme(131087935)},
    'Evil Kermit': {'id': '84341851', 'url': get_blank_meme(84341851)},
    'Trump Bill Signing': {'id': '91545132', 'url': get_blank_meme(91545132)},
    'Dr Evil Laser': {'id': '40945639', 'url': get_blank_meme(40945639)},
    'Third World Success Kid': {'id': '101287', 'url': get_blank_meme(101287)},
    'Am I The Only One Around Here': {'id': '259680', 'url': get_blank_meme(259680)},
    'Laughing Men In Suits': {'id': '922147', 'url': get_blank_meme(922147)},
    'Too Damn High': {'id': '61580', 'url': get_blank_meme(61580)},
    'Face You Make Robert Downey Jr': {'id': '9440985', 'url': get_blank_meme(9440985)},
    'Tuxedo Winnie The Pooh': {'id': '178591752', 'url': get_blank_meme(178591752)},
    'Yo Dawg Heard You': {'id': '101716', 'url': get_blank_meme(101716)},
    'Spongebob Ight Imma Head Out': {'id': '196652226', 'url': get_blank_meme(196652226)},
    'Put It Somewhere Else Patrick': {'id': '61581', 'url': get_blank_meme(61581)},
    'Ill Just Wait Here': {'id': '109765', 'url': get_blank_meme(109765)},
    'Who Would Win?': {'id': '101910402', 'url': get_blank_meme(101910402)},
    'Marked Safe From': {'id': '161865971', 'url': get_blank_meme(161865971)},
    'Unsettled Tom': {'id': '175540452', 'url': get_blank_meme(175540452)},
    'Bad Pun Dog': {'id': '12403754', 'url': get_blank_meme(12403754)},
    'Confession Bear': {'id': '100955', 'url': get_blank_meme(100955)},
    'Be Like Bill': {'id': '56225174', 'url': get_blank_meme(56225174)},
    'Back In My Day': {'id': '718432', 'url': get_blank_meme(718432)},
    'Sparta Leonidas': {'id': '195389', 'url': get_blank_meme(195389)},
    'Aaaaand Its Gone': {'id': '766986', 'url': get_blank_meme(766986)},
    'Steve Harvey': {'id': '143601', 'url': get_blank_meme(143601)},
    'Hard To Swallow Pills': {'id': '132769734', 'url': get_blank_meme(132769734)},
    'Awkward Moment Sealion': {'id': '13757816', 'url': get_blank_meme(13757816)},
    'Maury Lie Detector': {'id': '444501', 'url': get_blank_meme(444501)},
    'Mugatu So Hot Right Now': {'id': '21604248', 'url': get_blank_meme(21604248)},
    'Conspiracy Keanu': {'id': '61583', 'url': get_blank_meme(61583)},
    'Say That Again I Dare You': {'id': '124212', 'url': get_blank_meme(124212)},
    'Who Killed Hannibal': {'id': '135678846', 'url': get_blank_meme(135678846)},
    'Aint Nobody Got Time For That': {'id': '442575', 'url': get_blank_meme(442575)},
    'And everybody loses their minds': {'id': '1790995', 'url': get_blank_meme(1790995)},
    'This Is Where I\'d Put My Trophy If I Had One': {'id': '3218037', 'url': get_blank_meme(3218037)},
    'Imagination Spongebob': {'id': '163573', 'url': get_blank_meme(163573)},
    'Skeptical Baby': {'id': '101711', 'url': get_blank_meme(101711)},
    'Archer': {'id': '10628640', 'url': get_blank_meme(10628640)},
    'Jack Sparrow Being Chased': {'id': '460541', 'url': get_blank_meme(460541)},
    'See Nobody Cares': {'id': '6531067', 'url': get_blank_meme(6531067)},
    'Scumbag Steve': {'id': '61522', 'url': get_blank_meme(61522)},
    'I Should Buy A Boat Cat': {'id': '1367068', 'url': get_blank_meme(1367068)},
    'Pepperidge Farm Remembers': {'id': '1232104', 'url': get_blank_meme(1232104)},
    'Me And The Boys': {'id': '184801100', 'url': get_blank_meme(184801100)},
    'Marvel Civil War 1': {'id': '28034788', 'url': get_blank_meme(28034788)},
    'Simba Shadowy Place': {'id': '371382', 'url': get_blank_meme(371382)},
    'Uncle Sam': {'id': '89655', 'url': get_blank_meme(89655)},
    'Buddy Christ': {'id': '17699', 'url': get_blank_meme(17699)},
    'Look At Me': {'id': '29617627', 'url': get_blank_meme(29617627)}
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
