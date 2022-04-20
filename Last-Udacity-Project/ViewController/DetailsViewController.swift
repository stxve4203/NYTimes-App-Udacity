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
    
    var articleImageURL: String?
    
    var myNewDictArray = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = articleTitle
        textLabel.text = articleText
        imageView.image = articleImage
        
        
        let convertedUpdatedDate = convertDate(inputDate: articleUpdatedDate ?? "")
        let convertedPublishedDate =  convertDate(inputDate: articlePublishedDate ?? "")
        
        sectionLabel.text = "Section: \(articleSection ?? "")"
        updatedAtLabel.text = "Updated at: \(convertedUpdatedDate)"
        publishedAtLabel.text = "Published at: \(convertedPublishedDate)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func convertDate(inputDate: String) -> String {
        let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
           let dateFormatterPrint = DateFormatter()
           dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"
           let datee = dateFormatterGet.date(from: inputDate)
        return dateFormatterPrint.string(from: datee ?? Date())
        
    }

    
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
            
        var userDict: Dictionary<String,String> = [
                    "articleTitle" : articleTitle!,
                     "articleText" : articleText!,
                     "articleImageURL" : articleImageURL!,
                    "articlePublishedDate" : articlePublishedDate!,
                    "articleUpdatedDate" : articleUpdatedDate!,
                    "articleSection" : articleSection!
            
]
        
        myNewDictArray.insert(userDict, at: 0)
        
//        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let imageURL = documents.appendingPathComponent("tempImage_wb.jpg")
//        print("Documents directory:", imageURL.path)
        
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
