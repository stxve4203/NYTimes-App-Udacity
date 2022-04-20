//
//  FavoriteArticlesViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import UIKit

class FavoriteArticlesViewController: UIViewController {

    var savedDict = [String: Any]()
    var articlesList: [String] = []
    
    var articleTitle: String?
    var articleText: String?
    var articleImage: UIImage?
    var articleImageURL: String?
    var articleSection: String?
    var articlePublishedDate: String?
    var articleUpdatedDate: String?
    var articleURL: String?
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func deleteAllFavorites(_ sender: Any) {
             
        UserDefaults.standard.removeObject(forKey: Constants.FAVORITE_ARTICLES)
        UserDefaults.standard.synchronize()
        tableView.reloadData()
    }

}

extension FavoriteArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchedArrayWithDictionary = (UserDefaults.standard.array(forKey: Constants.FAVORITE_ARTICLES) as? [[String: Any]])
        
        return fetchedArrayWithDictionary?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.FAVORITE_ARTICLE_CELL, for: indexPath) as? FavoritesTableViewCell
        let fetchedArrayWithDictionary = (UserDefaults.standard.array(forKey: Constants.FAVORITE_ARTICLES) as? [[String: Any]])
        
        let indexPathForDict = fetchedArrayWithDictionary![indexPath.row]
        
        let favoriteArticleTitle = indexPathForDict["articleTitle"] as? String
       
        cell?.favoriteArticleTitle.text = favoriteArticleTitle
        
        let articleSection = indexPathForDict["articleSection"]
        cell?.favoriteArticleSection.text = articleSection as? String

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fetchedArrayWithDictionary = (UserDefaults.standard.array(forKey: Constants.FAVORITE_ARTICLES) as? [[String: Any]])
        
        let indexPathForDict = fetchedArrayWithDictionary![indexPath.row]
        
        let favoriteArticleTitle = indexPathForDict["articleTitle"] as? String
        articleTitle = favoriteArticleTitle
        
        let favoriteArticleText = indexPathForDict["articleText"] as? String
        articleText = favoriteArticleText
        
        let favoriteArticleUpdatedDate = indexPathForDict["articleUpdatedDate"] as? String
        articleUpdatedDate = favoriteArticleUpdatedDate
        
        let favoriteArticlePublishedDate = indexPathForDict["articlePublishedDate"] as? String
        articlePublishedDate = favoriteArticlePublishedDate
        
        let favoriteArticleSection = indexPathForDict["articleSection"] as? String
        articleSection = favoriteArticleSection
        
        let favoriteArticleImage = indexPathForDict["articleImageURL"] as? String
        articleImageURL = favoriteArticleImage
        
        let favoriteArticleURL = indexPathForDict["articleURL"] as? String
        articleURL = favoriteArticleURL
        
        performSegue(withIdentifier: SegueIdentifiers.SHOW_FAVORITE_DETAILS, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.SHOW_FAVORITE_DETAILS {
            let favoriteDetailsVC = segue.destination as? FavoriteDetailsViewController
            
            favoriteDetailsVC?.articleTitle = articleTitle
            favoriteDetailsVC?.articleText = articleText
            favoriteDetailsVC?.articleImageURL = articleImageURL
            favoriteDetailsVC?.articleSection = articleSection
            favoriteDetailsVC?.articleUpdatedDate = articleUpdatedDate
            favoriteDetailsVC?.articlePublishedDate = articlePublishedDate
            favoriteDetailsVC?.articleURL = articleURL
        }
    }
    
}
