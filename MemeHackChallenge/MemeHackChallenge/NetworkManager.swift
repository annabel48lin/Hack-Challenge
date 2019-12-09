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
    private static let endpoint = "http://34.73.20.1"

    static var signUpResult: Bool = false
    static var signInResult: Bool = false
    static var templateID: String = ""
    static var text0: String = ""
    static var text1: String = ""
    static var urlsTemps: [String] = []
    static var idTemps: [String] = []
    static var userID: Int = 0

    
    
    static func searchMemes(fromTitle title: String) {
        Alamofire.request(endpoint + "/api/templates/", method: .get, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userData = try? jsonDecoder.decode(templatesResponse.self, from: data) {
//                    var a: [String: [String:String]]= userData.data.values
                    
                    for i in 0..<(Array(userData.data.values)).count {
                        urlsTemps.append(Array(userData.data.values)[i]["url"]!)
                        idTemps.append(Array(userData.data.values)[i]["id"]!)
                    }
                    //print(Array(userData.data.values)[0]["url"])
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
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
    
    static func create(userID: Int, templateID: String, text0: String, text1: String) {
        let parameters: [String: Any] = [
            "template_id": Int(templateID),
            "text0": text0,
            "text1": text1,
            "font": "arial",
            "name": "meme"
        ]
        print(userID)
        let url: String = "\(endpoint)/api/user/\(userID)/create/"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userData = try? jsonDecoder.decode(CreateMemeResponseData.self, from: data) {
                    // STORE INFO
                    print(NetworkManger.templateID)
                    print(userData.data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

    static func delete(memeID: Int, username: String, password: String, userID: Int) {
        let url: String = "\(endpoint)/api/user/\(userID)/memes/\(memeID)/"
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

    static func signIn(username: String, password: String) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
            
        let url: String = "\(endpoint)/api/users/signin/"
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userData = try? jsonDecoder.decode(SignInResponseData.self, from: data) {
                    signInResult = true
                    userID = userData.data.id
                    print(signInResult)
                    print(userData.data.id)
                }
                

            case .failure(let error):
                print(error.localizedDescription)
                signInResult = false
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
    let data: signUpData
}

struct signUpData: Codable {
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

struct SignInResponseData: Codable {
    let success: Bool
    let data: SignInResponse
}

struct SignInResponse: Codable {
    let id: Int
    let username: String
    let memes: [String]
}

struct templatesResponse: Codable {
    let success: Bool
    let data: [String: [String:String]]
}

