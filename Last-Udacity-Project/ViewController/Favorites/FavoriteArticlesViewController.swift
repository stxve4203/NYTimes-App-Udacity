//
//  FavoriteArticlesViewController.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import UIKit

class FavoriteArticlesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let fetchedArrayWithDictionaryOfStrings: [[String: String]] = (UserDefaults.standard.object(forKey: "favoriteArticlesArray") as? [[String: String]]) {
            print(fetchedArrayWithDictionaryOfStrings.count)
            print(fetchedArrayWithDictionaryOfStrings)
    }
    }

    @IBAction func deleteAllFavorites(_ sender: Any) {
             
        UserDefaults.standard.removeObject(forKey: "favoriteArray")
        UserDefaults.standard.synchronize()
    }
    

}
