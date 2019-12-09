//
//  ViewController.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 11/21/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var titleLabel: UILabel!
    var userNameLabel: UILabel!
    var passwordLabel: UILabel!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    var invalidName: UIAlertController!
    var failed: UIAlertController!
    var newMeme: MemeHistoryViewController!
    
    static var username: String = ""
    static var password: String = ""
    static var userID: Int = 1
    
    var temp: [Meme] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 232/255.0, green: 216/255.0, blue: 255/255.0, alpha: 1)
        title = "Meme!!!"
        
        
        NetworkManger.getMemes { Meme in
            self.temp = Meme
            DispatchQueue.main.async {
                
            }
        }

        titleLabel = UILabel()
        titleLabel.text = "Meme is Life"
        titleLabel.font = UIFont(name: "Zapfino", size: 40)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        userNameLabel = UILabel()
        userNameLabel.text = "Username:"
        userNameLabel.font = UIFont(name: "SavoyeLetPlain", size: 40)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        passwordLabel = UILabel()
        passwordLabel.text = "Password:"
        passwordLabel.font = UIFont(name: "SavoyeLetPlain", size: 40)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        userNameTextField = UITextField()
        userNameTextField.text = "Username"
        userNameTextField.backgroundColor = .white
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.font = UIFont(name: "Papyrus-Condensed", size: 28)
        userNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        userNameTextField.clearsOnBeginEditing = true
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.text = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = UIFont(name: "Papyrus-Condensed", size: 28)
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.clearsOnBeginEditing = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemBlue, for: .normal)
        loginButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginButton.backgroundColor = .white
        loginButton.layer.borderColor = UIColor.systemBlue.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        loginButton.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 40)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        signupButton = UIButton()
        signupButton.setTitle("Don't have an account? Sign Up!", for: .normal)
        signupButton.setTitleColor(.systemBlue, for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 36)
        signupButton.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
    
        invalidName = UIAlertController(title: "Invalid Input!", message: "Username or password cannot be empty", preferredStyle: .alert)
        failed = UIAlertController(title: "Login Failed", message: "Username and password may not exist", preferredStyle: .alert)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let offset: CGFloat = 30
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: offset),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset)
        ])
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: offset - 5),
            userNameTextField.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: offset),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: offset),
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset)
                ])
                
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: offset - 5),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant: offset),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: offset * 3),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: offset / 1.5),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    @objc func loginAction() {
        newMeme = MemeHistoryViewController()
        let u: String = userNameTextField.text ?? ""
        let p: String = passwordTextField.text ?? ""
        if u == "" || p == "" {
            self.present(invalidName, animated: true) {
            self.invalidName.view.superview?.subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped)))
            }
            return
        } else {
            NetworkManger.signIn(username: u, password: p)
            //sleep(5)
            print("hello")
            print(NetworkManger.signInResult)

            if NetworkManger.signInResult == true {
                navigationController?.pushViewController(newMeme, animated: true)
            } else {
                self.present(failed, animated: true) { self.failed.view.superview?.subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped)))
                }
            }
        }
        
        //navigationController?.pushViewController(newMeme, animated: true)
        
    }
    
    @objc func signupAction() {
        let signupView = SignUpViewController()
        navigationController?.pushViewController(signupView, animated: true)
    }
    
    @objc func backgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
