//
//  FavoriteDetailsViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 20.04.22.
//

import UIKit

class FavoriteDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    var articleImageURL: String?
    var articleSection: String?
    var articlePublishedDate: String?
    var articleUpdatedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        
    }
    
    func setLabels() {
        titleLabel.text = articleTitle
        textLabel.text = articleText
        sectionLabel.text = articleSection
        
        let convertedUpdatedDate = convertDate(inputDate: articleUpdatedDate ?? "")
        let convertedPublishedDate =  convertDate(inputDate: articlePublishedDate ?? "")
        publishedAtLabel.text = convertedPublishedDate
        updatedAtLabel.text = convertedUpdatedDate
        
        let image = NYTimesService().getImages(img: articleImageURL) { image, error in
            self.imageView.image = image
        }
        
        func convertDate(inputDate: String) -> String {
            let dateFormatterGet = DateFormatter()
               dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
               let dateFormatterPrint = DateFormatter()
               dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"  //"MMM d, h:mm a" for  Sep 12, 2:11 PM
               let datee = dateFormatterGet.date(from: inputDate)
            return dateFormatterPrint.string(from: datee ?? Date())
            
        }

        
    }
    


}
