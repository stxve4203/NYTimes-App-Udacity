//
//  ArticlesViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import UIKit

class ArticlesViewController: UIViewController {

    var selectedCategory: String?
    var nyTimesService = NYTimesService()
    var result: Int?
    var image: UIImage!
    var articles = [Article]()
    var multimedia = [Multimedia]()
    
    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    var articleImageURL: String?
    var articleSection: String?
    var articlePublishedDate: String?
    var articleUpdatedDate: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            title = selectedCategory
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //   downloadArticles()
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        tableView.reloadData()
    }
    
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.ARTICLES_CELL , for: indexPath) as? ArticlesTableViewCell
        let articleArray = articles[indexPath.row]
        cell?.titleLabel.text = articleArray.title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleArray = articles[indexPath.row]
        articleText = articleArray.abstract
        articleTitle = articleArray.title
        articleSection = articleArray.section
        articleUpdatedDate = articleArray.updatedDate
        articlePublishedDate = articleArray.publishedDate
        
        let multimedia = articleArray.multimedia
        for media in multimedia ?? [] {
            let mediaURL = media.url
            articleImageURL = mediaURL
            nyTimesService.getImages(img: mediaURL) { image, error in
                self.articleImage = image
            }
        }
        performSegue(withIdentifier: SegueIdentifiers.SHOW_DETAILS, sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.SHOW_DETAILS {
            let detailsVC = segue.destination as? DetailsViewController
            
            detailsVC?.articleTitle = articleTitle
            detailsVC?.articleText = articleText
            detailsVC?.articleImage = articleImage
            detailsVC?.articleImageURL = articleImageURL
            detailsVC?.articlePublishedDate = articlePublishedDate
            detailsVC?.articleSection = articleSection
            detailsVC?.articleUpdatedDate = articleUpdatedDate
            
        }
    }
}
