//
//  NYTimesResponse.swift
//  Last-Udacity-Project
//
//  Created by Stefan Weiss on 19.04.22.
//

import Foundation

struct Articles: Codable {
    let results: [Article]
    let status: String?
    let numResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case status = "status"
        case numResults = "num_results"
    }
}

struct Article: Codable {
    let section: String?
    let abstract: String?
    let title: String?
      let url: String?
      let updatedDate, createdDate, publishedDate: String?
      let materialTypeFacet: String?
      let multimedia: [Multimedia]?

      enum CodingKeys: String, CodingKey {
          case section = "section"
          case abstract = "abstract"
         case title = "title"
         case url = "url"
          case updatedDate = "updated_date"
          case createdDate = "created_date"
          case publishedDate = "published_date"
          case materialTypeFacet = "material_type_facet"
          case multimedia = "multimedia"
      }
}

struct Multimedia: Codable {
        let url: String?
        let format: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case format = "format"
    }
}
