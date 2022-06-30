//
//  Parsing.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, MoviesError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970
  
  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
        .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
