//
//  ViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 18.04.22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var selectedCategoryAtIndexPath: String!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var result: Int!
    var article = [Article]()
    var image: UIImage!
    var multimedias = [Multimedia]()
    
    var sectionArray = ["arts", "automobiles", "books", "business", "fashion", "food", "health", "home", "insider", "magazine", "movies", "nyregion", "obituaries", "opinion", "politics", "realestate", "science", "sports", "sundayreview", "technology", "theater", "t-magazine", "travel", "upshot", "us", "world"]
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.CATEGORY_CELL, for: indexPath) as? CategoryTableViewCell
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none

        cell?.categoryTitle.text = sectionArray[indexPath.row]
        //print(sectionArray[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        self.activityIndicator.startAnimating()

        delay(0.2, closure: {
            let categoryIndexPath = self.sectionArray[indexPath.row]
            self.selectedCategoryAtIndexPath = categoryIndexPath
                NYTimesService().getArticlesFromNYTimesAPI(selectedCategory: self.selectedCategoryAtIndexPath) { data, error in
                if error != nil, data == nil {
                    self.showAlert()
                } else {
                self.result = data?.count
                    self.article = data ?? []
                self.performSegue(withIdentifier: SegueIdentifiers.SHOW_ARTICLES, sender: nil)
            }
        }
            self.activityIndicator.stopAnimating()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.SHOW_ARTICLES {
            guard let articlesVC = segue.destination as? ArticlesViewController else {
                print("Segue destination not found.")
                return
            }
            
            articlesVC.selectedCategory = selectedCategoryAtIndexPath
            articlesVC.articles = article
            articlesVC.result = result
            articlesVC.image = image
            articlesVC.multimedia = multimedias
            
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error downloading photo", message: "Check your internet connection and try again", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
}

