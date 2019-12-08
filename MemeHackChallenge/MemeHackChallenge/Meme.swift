//
//  Meme.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 11/22/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import Foundation

class Meme: Codable {
    var URL: String!
    var imageID: String!
    var name: String!
    
    init(URL: String, imageID: String, name: String) {
        self.URL = URL
        self.imageID = imageID
        self.name = name
    }
}

