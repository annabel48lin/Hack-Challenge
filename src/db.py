from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'user'
    username = db.Column(db.String, primary_key=True)
    password = db.Column(db.String, nullable=False)
    memes = db.relationship('Meme', cascade='delete')
    shared = db.relationship('Meme')
    following = db.relationship('User')
    followers = db.relationship('User')

    def __init__(self, **kwargs):
        self.username = kwargs.get('username')
        self.password = kwargs.get('password')
        self.memes = []
        self.shared = []
        self.following = []
        self.followers = []

    def serialize(self):
        return {
            'username': self.username,
            'memes': [m.serialize_for_table() for m in self.memes],
            'shared': [s.serialize_for_table() for s in self.shared],
            'following': [f.serialize_for_table() for f in self.following],
            'followers': [f.serialize_for_table() for f in self.followers]
        }

    def serialize_for_table(self):
        return{
            'username': self.username
        }

class Meme(db.Model):
    __tablename__ = 'meme'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    url = db.Column(db.String, nullable=False)
    

    def __init__(self, **kwargs):
        self.name = kwargs.get('title')
        self.url = kwargs.get('url')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'url': self.url,
        }
