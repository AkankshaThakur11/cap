//
//  TextFieldView.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import Foundation
import UIKit

protocol ViewTextFieldDelegate: AnyObject {
  func search(textField: UISearchBar)
}
// Reusable view for text field
final class TextFieldView: UIView, UISearchBarDelegate {
  enum Constant {
    static let textFieldHeight: CGFloat = 50
  }
  
  private let stackView: UIStackView = {
    let view = UIStackView().forAutolayout()
    view.axis = .vertical
    view.spacing = 8
    return view
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.textColor = UIColor.darkGray
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.textAlignment = .left
    label.numberOfLines = 0
    return label
  }()
  
//  private let textField: CustomTextField = {
//    let textField = CustomTextField().forAutolayout()
//    textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//    textField.textColor = .black
//    textField.clearButtonMode = .whileEditing
//    textField.layer.borderWidth = 1.0
//    textField.layer.cornerRadius = 8.0
//    textField.autocapitalizationType = .none
//    textField.autocorrectionType = .no
//    textField.enablesReturnKeyAutomatically = false
//    return textField
//  }()
  
  let textField:  UISearchBar = {
        let sear = UISearchBar()
    sear.tintColor = .lightGray
    sear.backgroundColor = .white
    sear.barTintColor =  .gray
        sear.placeholder = "Search Asset"
        sear.layer.cornerRadius = 30
        sear.barStyle = .default
        sear.backgroundImage = UIImage()

        sear.returnKeyType = .search

        // sear.addShadow(offset: CGSize(width: 10, height: 10), color: UIColor.darkGray, radius: 20, opacity: 5)

        return sear

    }()
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    delegate?.search(textField: textField)
    }
  
  var text: String? {
    return textField.text
  }
  
  var textFields: UISearchBar {
    return textField
  }
  
  weak var delegate: ViewTextFieldDelegate?
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(textField)
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      textField.heightAnchor.constraint(equalToConstant: Constant.textFieldHeight),
      titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
    ])
 //   textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    textField.delegate = self
  }
  
  func update(title: String, placeholder: String = "") {
    titleLabel.text = title
    textField.placeholder = placeholder
  }
  
  func secureTextFeild() {
    textField.isSecureTextEntry = true
  }

  func clearTextField() {
    textField.text = ""
   // updateTextField(textColor: .black, borderColor: .black)
  }
  
  func updateText(_ text: String) {
    textField.text = text
  }
}

// MARK: Custom Text Field
final class CustomTextField: UITextField
{
  private enum Constant {
    static let textOffset: CGFloat = 15.0
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.textRect(forBounds: bounds)
    return CGRect(x: rect.origin.x + Constant.textOffset, y: rect.origin.y, width: rect.size.width - Constant.textOffset, height: rect.size.height)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    let rect = super.editingRect(forBounds: bounds)
    return CGRect(x: rect.origin.x + Constant.textOffset, y: rect.origin.y, width: rect.size.width - Constant.textOffset, height: rect.size.height)
  }
}
