//
//  NYTimesService + Constants.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import Foundation


enum API {
    static let Scheme = "https"
    static let Host = "api.nytimes.com"
    static let Path = "/svc/topstories/v2/"
}

enum ParameterKeys {
    static let APIKey = "api-key"
    static let section = "section"
    
}
