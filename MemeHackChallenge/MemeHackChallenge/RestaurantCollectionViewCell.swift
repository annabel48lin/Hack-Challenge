//
//  RestaurantCollectionViewCell.swift
//  cw696_p5
//
//  Created by Claire Wang on 11/2/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    var image: UIImageView!
    //var name: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
//        name = UILabel()
//        name.font = UIFont(name: "SavoyeLetPlain", size: 30)
//        name.textAlignment = .center
//        name.translatesAutoresizingMaskIntoConstraints = false
        //contentView.addSubview(name)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let vPadding: CGFloat = -3
        let hPadding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: hPadding),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hPadding),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
//        NSLayoutConstraint.activate([
//            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
//            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//        ])
        
    }
    
    func configure(for meme: Meme) {
        //image.image = UIImage(named: meme.URL)
        //name.text = meme.name
        let url = URL(string: meme.URL)!
        let data = try? Data(contentsOf: url)
        image.image = UIImage(data: data!)
    }
    
    
    
//    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//    
//    func downloadImage(from url: URL) {
//        print("Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                self.image.image = UIImage(data: data)
//            }
//        }
//    }
//    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

