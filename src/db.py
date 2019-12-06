from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

association_table = db.Table('association', db.Model.metadata,
    db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
    db.Column('meme_id', db.Integer, db.ForeignKey('meme.id'))
)

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=False)
    memes = db.relationship('Meme', cascade='delete')
    #shared = db.relationship('Meme', secondary=association_table, back_populates='users')

    def __init__(self, **kwargs):
        self.username = kwargs.get('username')
        self.password = kwargs.get('password')
        self.memes = []
        #self.shared = []
        #self.following = []

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username,
            'memes': [m.serialize() for m in self.memes]
            #'shared': [s.serialize() for s in self.shared],
            #'following': [f.serialize() for f in self.following]
        }

class Meme(db.Model):
    __tablename__ = 'meme'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, nullable=False)
    url = db.Column(db.String, nullable=False)
    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    #users = db.relationship('User', secondary=association_table, back_populates='shared')

    def __init__(self, **kwargs):
        self.name = kwargs.get('name')
        self.url = kwargs.get('url')
        self.creator_id = kwargs.get('creator_id')

    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'url': self.url,
            'creator_id': self.creator_id
        }
