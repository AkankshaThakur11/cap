//
//  ViewController.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 27/6/22.
//

import UIKit
import Combine
import SwiftUI

class FilmListViewController: UIViewController, ViewTextFieldDelegate {

  enum Constant {
    static let spacing: CGFloat = 24
  }
  
  private let textField = TextFieldView().forAutolayout()
  @ObservedObject var viewModel: PhotoListViewModel = PhotoListViewModel(photoFetcher: PhotosFetcher())
  var movieData : [Search]  = [Search]()
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViewLayouts()
    setupViews()
    viewModel.refresh()
  }
  
  private let stackView: UIStackView = {
    let view = UIStackView().forAutolayout()
    view.axis = .vertical
    view.spacing = Constant.spacing
    return view
  }()
  
  fileprivate let collectionView:UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = CGSize(width: 1, height: 1)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    return cv
  }()
  
  private func setUpViewLayouts() {
    self.view.addSubview(stackView)
    stackView.addArrangedSubview(textField)
    stackView.addStyle(borderColor: .lightGray, backgroundColor: nil, cornerRadius: 18)
    self.view.addSubview(collectionView)
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2*Constant.spacing),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.spacing),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.spacing),
      
      collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 2*Constant.spacing),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constant.spacing),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constant.spacing),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.spacing),
    ])
  }
  
  private func setupViews() {
    textField.update(title: "Wanna search movies ⇣", placeholder: "Type here...")
    textField.delegate = self
  }
  
  func search(textField: UISearchBar) {
    self.showLoader()
    movieData.removeAll()
    if let textVal = textField.text, let vals = viewModel.dataSource?.item.search {
      for movies in  vals {
        if let title = movies.title, title.lowercased().contains(textVal.lowercased()) {
          print(movies)
          movieData.append(movies)
          print("******")
          print(movieData)
        }
      }
    }
    collectionView.reloadData()
  }
}

extension FilmListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movieData.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
    cell.updateInfo(title: movieData[indexPath.row].title ?? "")
    if let url = URL(string: movieData[indexPath.row].poster ?? "" ) {
      if let data = try? Data(contentsOf: url) {
        cell.imageView.image = UIImage(data: data)
         }
    }
    self.hideLoader()
    return cell
  }
}

@ViewBuilder
func placeholderImage() -> some View {
  Image(systemName: "photo")
    .renderingMode(.template)
    .resizable()
    .aspectRatio(contentMode: .fit)
    .frame(width: 150, height: 150)
    .foregroundColor(.gray)
}
