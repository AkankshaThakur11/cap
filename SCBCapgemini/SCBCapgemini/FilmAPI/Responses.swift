//
//  Responses.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import Foundation

struct Movies : Codable {
  let search : [Search]?
  let totalResults : String?
  let response : String?

  enum CodingKeys: String, CodingKey {

    case search = "Search"
    case totalResults = "totalResults"
    case response = "Response"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    search = try values.decodeIfPresent([Search].self, forKey: .search)
    totalResults = try values.decodeIfPresent(String.self, forKey: .totalResults)
    response = try values.decodeIfPresent(String.self, forKey: .response)
  }

}

struct Search : Codable {
  let title : String?
  let year : String?
  let imdbID : String?
  let type : String?
  let poster : String?

  enum CodingKeys: String, CodingKey {

    case title = "Title"
    case year = "Year"
    case imdbID = "imdbID"
    case type = "Type"
    case poster = "Poster"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    title = try values.decodeIfPresent(String.self, forKey: .title)
    year = try values.decodeIfPresent(String.self, forKey: .year)
    imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID)
    type = try values.decodeIfPresent(String.self, forKey: .type)
    poster = try values.decodeIfPresent(String.self, forKey: .poster)
  }

}
