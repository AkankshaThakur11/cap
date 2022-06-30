//
//  MovieListViewModel.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import Foundation
import SwiftUI
import Combine

class PhotoListViewModel: ObservableObject {
  @Published var dataSource: PhotosviewModel?
  @Published var title: String?
  private let photoFetcher: PhotosFetchable
  private var disposables = Set<AnyCancellable>()
  
  init(photoFetcher: PhotosFetcher) {
    self.photoFetcher = photoFetcher
  }
  
  func refresh() {
    photoFetcher
      .Movies()
      .map(PhotosviewModel.init)
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure:
          self.dataSource = nil
        case .finished:
          break
        }
      }, receiveValue: { [weak self] val in
        guard let self = self else { return }
        self.dataSource = val
      })
      .store(in: &disposables)
  }
}

struct PhotosviewModel {
  let item: Movies
  init(item: Movies) {
    self.item = item
  }
}
