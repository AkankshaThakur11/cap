//
//  FilmFetcher.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import Foundation
import Combine
import UIKit

protocol PhotosFetchable {
  func Movies() -> AnyPublisher<Movies, MoviesError>
  func DonwloadPhoto(url: String) -> AnyPublisher<UIImage?, MoviesError>
}

class PhotosFetcher {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
}

// MARK: - PhotosFetchable
extension PhotosFetcher: PhotosFetchable {
  func Movies() -> AnyPublisher<Movies, MoviesError> {
    return forecast(with: makePhotosAPIComponents())
  }
  
  func DonwloadPhoto(url: String) -> AnyPublisher<UIImage?, MoviesError> {
    return session.dataTaskPublisher(for: URL(string: url)!)
      .mapError { error in
          .network(description: error.localizedDescription)
      }
      .map { UIImage(data: $0.data) ?? nil }
      .eraseToAnyPublisher()
  }
  
  private func forecast<T>(
    with components: URLComponents
  ) -> AnyPublisher<T, MoviesError> where T: Decodable {
    guard let url = components.url else {
      let error = MoviesError.network(description: "Couldn't create URL")
      return Fail(error: error).eraseToAnyPublisher()
    }
    return session.dataTaskPublisher(for: URLRequest(url: url))
      .mapError { error in
          .network(description: error.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
}

// MARK: - OpenWeatherMap API
private extension PhotosFetcher {
  struct PhotosAPI {
    static let scheme = "http"
    static let host = "www.omdbapi.com"
    static let path = "/"
    static let key = "88685f62"
    static let type = "movie"
    static let s = "Marvel"
  }
  //http://www.omdbapi.com/?apikey=b9bd48a6&s=Marvel&type=movie
//http://www.omdbapi.com/?apikey=b9bd48a6&s=Marvel&type=movie
  ///https://api.unsplash.com/photos?page=1&client_id=pYlr2dIxyJyWTKAEx_UnmY8eznaTvoMxoRG-OPXvFgA
  func makePhotosAPIComponents() -> URLComponents {
    var components = URLComponents()
    components.scheme = PhotosAPI.scheme
    components.host = PhotosAPI.host
    components.path = PhotosAPI.path
    components.queryItems = [
      
      URLQueryItem(name: "apikey", value: PhotosAPI.key),
      URLQueryItem(name: "s", value: PhotosAPI.s),
      URLQueryItem(name: "type", value: PhotosAPI.type)
    ]
    
    return components
  }
}

enum MoviesError: Error {
  case parsing(description: String)
  case network(description: String)
}

//http://www.omdbapi.com/?apikey=b9bd48a6&s=Marvel&type=movie
