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
    @IBOutlet weak var addFavoritesButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    var articleSection: String?
    var articlePublishedDate: String?
    var articleUpdatedDate: String?
    var articleURL: String?
    var articleImageURL: String?
    
    var myNewDictArray = [Dictionary<String, String>]()
    var favorites: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentOffset.x = 0.0
        titleLabel.text = articleTitle
        textLabel.text = articleText
        //imageView.image = articleImage
        
        sectionLabel.text = "Category: \(articleSection?.uppercased() ?? "")"
        updatedAtLabel.text = "Updated at: \(articleUpdatedDate ?? "")"
        publishedAtLabel.text = "Published at: \(articlePublishedDate ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchedArray = (UserDefaults.standard.array(forKey: Constants.FAVORITE_ARTICLES) as? [[String: Any]])
        favorites = fetchedArray ?? []
        if checkForInFavorites() {
            addFavoritesButton.isEnabled = false
        } else {
            addFavoritesButton.isEnabled = true
        }
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            let image = NYTimesService().getImages(img: self.articleImageURL) { image, error in
                if error != nil {
                    self.showAlert()
                } else {
                self.imageView.image = image
            }
        self.activityIndicator.stopAnimating()

        }
        }
    }
    
    @IBAction func openLink(_ sender: Any) {
        if let url = URL(string: articleURL ?? "") {
            UIApplication.shared.open(url)
        }
        
    }
    
    
    func checkForInFavorites() -> Bool {
        for favorite in favorites {
            if let favoriteArticleTitle = favorite["articleTitle"] as? String {
                if articleTitle == favoriteArticleTitle {
                    return true
                }
            }
        }
        return false
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
        addFavoritesButton.isEnabled = false
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error downloading photo", message: "Check your internet connection and try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


