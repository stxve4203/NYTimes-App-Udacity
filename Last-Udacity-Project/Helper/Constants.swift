//
//  Constants.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import Foundation

enum Constants {
    static let API_KEY = "pwDZKFUfrxvgjiX5LAq02N5YNsxHncMv"
    static let ARTICLE_TEXT = "articleText"
    static let ARTICLE_TITLE = "articleTitle"
    static let ARTICLE_IMAGE = "articleImage"
    static let FAVORITE_ARTICLES = "favoriteArticles"
}

enum Cells {
    static let CATEGORY_CELL = "CategoryCell"
    static let ARTICLES_CELL = "ArticlesCell"
    static let FAVORITE_ARTICLE_CELL = "favoriteArticleCell"
}


enum SegueIdentifiers {
    static let SHOW_ARTICLES = "showArticles"
    static let SHOW_DETAILS = "showDetails"
    static let SHOW_FAVORITE_DETAILS = "showDetailsFavorites"
}
