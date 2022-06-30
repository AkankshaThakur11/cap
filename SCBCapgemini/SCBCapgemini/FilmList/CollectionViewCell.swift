//
//  CollectionViewCell.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  private enum Constant {
    static let commonPadding: CGFloat = 24
    static let outerViewSpacing: CGFloat = 12
  }
  
  private let containerView = UIView().forAutolayout()
  var customClearButton: UIButton?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupLayout()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.leftAnchor.constraint(equalTo: leftAnchor),
      contentView.rightAnchor.constraint(equalTo: rightAnchor),
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError(" init(coder:) has not been implemented")
  }
  
  private lazy var OuterView: UIView = {
    let view = UIView().forAutolayout()
    view.backgroundColor = .lightGreen
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.backgroundColor = .clear
    label.textAlignment = .left
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textColor = UIColor.black
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    label.text = ""
    return label
  }()
  public lazy var imageView: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    imageView.image = UIImage()
    return imageView
  }()
  
  private func setupLayout() {
    // containerView.addSubview(stackView)
    containerView.addSubview(imageView)
    containerView.addSubview(titleLabel)
    contentView.addSubview(containerView)
    containerView.insertSubview(OuterView, at: 0)
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      OuterView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      OuterView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      OuterView.topAnchor.constraint(equalTo: containerView.topAnchor),
      OuterView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constant.commonPadding),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      
      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2),
      imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2 - 2*Constant.commonPadding),
    ])
  }
  
  func updateInfo(title: String) {
    titleLabel.text = ""
    titleLabel.text = title
  }
}
