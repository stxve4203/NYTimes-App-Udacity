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
    var articleURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLabels()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            let image = NYTimesService().getImages(img: self.articleImageURL) { image, error in
                self.imageView.image = image
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
}
