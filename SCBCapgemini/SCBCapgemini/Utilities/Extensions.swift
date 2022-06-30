//
//  Extensions.swift
//  SCBCapgemini
//
//  Created by Akanksha Thakur on 29/6/22.
//

import Foundation
import UIKit

public extension UIView {
  @discardableResult
  func forAutolayout() -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}

extension UIStackView {
  func addStyle(borderColor: UIColor, backgroundColor: UIColor?, cornerRadius: CGFloat = 0) {
    let subView = UIView(frame: CGRect(x: bounds.minX - 14, y: bounds.minY - 18, width: bounds.width + 26, height: bounds.height + 38))
    subView.layer.borderColor = borderColor.cgColor
    subView.backgroundColor = backgroundColor == nil ? .clear : backgroundColor
    subView.layer.cornerRadius = cornerRadius
    subView.layer.borderWidth = 0.3
    subView.layer.shadowOffset = CGSize(width: 2,
                                        height: 2)
    subView.layer.shadowRadius = 2
    subView.layer.shadowOpacity = 0.5
    subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(subView, at: 0)
  }
}


// color pallet
extension UIColor {
  static var darkBlue: UIColor {return UIColor(red: 0/255.0, green: 0/255.0, blue: 102/255.0, alpha: 1)}
  static var red: UIColor {return UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)}
  static var lightRed: UIColor {return UIColor(red: 255/255.0, green: 233/255.0, blue: 236/255.0, alpha: 1)}
  static var moreGray: UIColor {return UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1)}
  static var golden: UIColor {return UIColor(red: 204/255.0, green: 204/255.0, blue: 0/255.0, alpha: 1)}
  static var lightGreen: UIColor {return UIColor(red: 252/255.0, green: 255/255.0, blue: 237/255.0, alpha: 1)}
}


public extension UIViewController {
  var loaderAlert:UIAlertController {
    get {
      let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
      
      let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
      loadingIndicator.hidesWhenStopped = true
      loadingIndicator.style = .medium
      loadingIndicator.startAnimating();
      
      alert.view.addSubview(loadingIndicator)
      return alert
    }
  }
  func showLoader(completion: (() -> Void)? = nil) {
    present(loaderAlert, animated: false, completion: completion)
  }
  
  func hideLoader(completion: (() -> Void)? = nil) {
    dismiss(animated: true, completion: completion)
  }
  
}
