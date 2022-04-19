//
//  DetailsViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    
    var articleImageURL: String?
    
    var savedFilesDictionary = [[String: String]]()
    var newEntryDictionary = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = articleTitle
        textLabel.text = articleText
        imageView.image = articleImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
            
        newEntryDictionary["articleTitle"] = articleTitle
        newEntryDictionary["articleText"] = articleText
        newEntryDictionary["articleImageURL"] = articleImageURL

        var dict = [String:String]()

        dict["articleTitle"] = articleTitle
        dict["articleText"] = articleText
        dict["articleImageURL"] = articleImageURL

        var dataArray = [dict]
        
        print (dataArray)
    UserDefaults.standard.set(dataArray, forKey: "favoriteArticlesArray")
        print(dataArray.count)
        UserDefaults.standard.synchronize()
    }
    
}
