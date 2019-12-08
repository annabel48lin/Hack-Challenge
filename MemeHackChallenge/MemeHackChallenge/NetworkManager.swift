//
//  NetworkManager.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 12/6/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManger {
    private static let endpoint = "http://0.0.0.0:5000"
    static var signUpResult: Bool = false
    
    static func getMemes(completion: @escaping ([Meme]) -> Void) {
        Alamofire.request(endpoint + "/api/users/", method: .get).validate().responseData { response in
            switch response.result {
                
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                // var searchResult: [Meme] = []
                if let json: JSON? = JSON(data) {
                    for i in 0..<json!["results"].count {
                        print(json!["results"][i]["memes"].stringValue)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func signup(username: String, password: String) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(endpoint + "/api/users/signup/", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userData = try? jsonDecoder.decode(signUp.self, from: data) {
                    print(userData.data.username)
                }
                signUpResult = true
            case .failure(let error):
                print(error.localizedDescription)
                signUpResult = false
            }
        }
    }
    
    static func create(userID: Int, username: String, password: String) {
        let url: String = "\(endpoint)/api/user/\(userID)/create/"
        Alamofire.request(url, method: .post, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userData = try? jsonDecoder.decode(CreateMemeResponseData.self, from: data) {
                    // STORE INFO
                    print(userData.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func delete(memeID: Int, username: String, password: String) {
        let url: String = "\(endpoint)/api/user/memes/\(memeID)/"
        Alamofire.request(url, method: .delete, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userData = try? jsonDecoder.decode(DeleteResponse.self, from: data) {
                    print(userData.success)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

struct memeHistory: Codable {
    let username: String
    let memes: [String]
}

struct signUp: Codable {
    let success: Bool
    let data: Data
}

struct Data: Codable {
    let username: String
    let memes: [String]
}

struct CreateMemeBody: Codable {
    let template_id: Int
    let text0: String
    let text1: String
    let font: String
    let name: String
}

struct CreateMemeResponseData: Codable {
    let success: Bool
    let data: CreateMemeResponse
}

struct CreateMemeResponse: Codable {
    let id: Int
    let name: String
    let url: String
    let creator_id: Int
}

struct DeleteResponse: Codable {
    let success: Bool
}