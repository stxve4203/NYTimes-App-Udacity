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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    var articleImageURL: String?
    var articleSection: String?
    var articlePublishedDate: String?
    var articleUpdatedDate: String?
    var articleURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            _ = NYTimesService().getImages(img: self.articleImageURL) { image, error in
                if error != nil {
                    self.showAlert()
                } else {
                self.imageView.image = image
            }
        self.activityIndicator.stopAnimating()
            }
    }
    }
    
    
    func setLabels() {

        titleLabel.text = articleTitle
        textLabel.text = articleText
        sectionLabel.text = "Category: \(articleSection?.uppercased() ?? "")"
    
        publishedAtLabel.text = "Published Date: \(articlePublishedDate ?? "")"
        updatedAtLabel.text = "Updated At: \(articleUpdatedDate ?? "")"

        }
    
    @IBAction func openLink(_ sender: Any) {
        if let url = URL(string: articleURL ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error downloading photo", message: "Check your internet connection and try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
