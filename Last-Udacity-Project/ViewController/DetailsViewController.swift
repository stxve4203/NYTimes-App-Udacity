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
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!

    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    var articleSection: String?
    var articlePublishedDate: String?
    var articleUpdatedDate: String?
    var articleURL: String?
    var articleImageURL: String?
    
    var myNewDictArray = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = articleTitle
        textLabel.text = articleText
        //imageView.image = articleImage
        
        sectionLabel.text = "Category: \(articleSection?.uppercased() ?? "")"
        updatedAtLabel.text = "Updated at: \(articleUpdatedDate ?? "")"
        publishedAtLabel.text = "Published at: \(articlePublishedDate ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            let image = NYTimesService().getImages(img: self.articleImageURL) { image, error in
                self.imageView.image = image
        }
        }
        
    }
    
    @IBAction func openLink(_ sender: Any) {
        if let url = URL(string: articleURL ?? "") {
            UIApplication.shared.open(url)
        }
        
    }
    
    
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
            
        var userDict: Dictionary<String,String> = [
                    "articleTitle" : articleTitle!,
                     "articleText" : articleText!,
                     "articleImageURL" : articleImageURL!,
                    "articlePublishedDate" : articlePublishedDate!,
                    "articleUpdatedDate" : articleUpdatedDate!,
                    "articleSection" : articleSection!,
                    "articleURL" : articleURL!
            
]
    
        if let arr = UserDefaults.standard.array(forKey: Constants.FAVORITE_ARTICLES) as? [Dictionary<String, String>]
                {
                    var arrvalues = arr
                    arrvalues.append(userDict)
            UserDefaults.standard.set(arrvalues, forKey: Constants.FAVORITE_ARTICLES)
            UserDefaults.standard.synchronize()
                    print (arr)
                }
                else
                {
                    UserDefaults.standard.set([userDict], forKey: Constants.FAVORITE_ARTICLES)
                }
    }
    
}

