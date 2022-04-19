//
//  ViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 18.04.22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var selectedCategoryAtIndexPath: String!
    
    var result: Int!
    var article = [Article]()
    var image: UIImage!
    var multimedias = [Multimedia]()
    
    var sectionArray = ["arts", "automobiles", "books", "business", "fashion", "food", "health", "home", "insider", "magazine", "movies", "nyregion", "obituaries", "opinion", "politics", "realestate", "science", "sports", "sundayreview", "technology", "theater", "t-magazine", "travel", "upshot", "us", "world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.CATEGORY_CELL, for: indexPath) as? CategoryTableViewCell
        cell?.categoryTitle.text = sectionArray[indexPath.row]
        //print(sectionArray[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryIndexPath = sectionArray[indexPath.row]
        selectedCategoryAtIndexPath = categoryIndexPath
        
        DispatchQueue.main.async {
            NYTimesService().getArticlesFromNYTimesAPI(selectedCategory: self.selectedCategoryAtIndexPath) { [self] data, error in
                self.result = data?.count
                self.article = data!
                // self.multimedias = multiMedia!
                self.performSegue(withIdentifier: SegueIdentifiers.SHOW_ARTICLES, sender: nil)

            }
        }
        

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
    
    
}

