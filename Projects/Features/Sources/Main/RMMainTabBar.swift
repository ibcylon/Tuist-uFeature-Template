//
//  RMTabBarController.swift
//  RickAndMortyDB
//
//  Created by Kanghos on 2023/09/03.
//

import UIKit

import Core

enum TabItem: String {
  case character

  var image: String {
    switch self {
    case .character:
      return "person.circle"
    }
  }

  var tag: Int {
    switch self {
    case .character:
      return 0
    }
  }
}

final class RMTabBarController: UITabBarController, MainViewControllable {
  
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    RMLogger.ui.debug("\(#function) \(type(of: self))")
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  deinit {
    RMLogger.ui.debug("\(#function) \(type(of: self))")
  }
  
  func setViewController(_ viewControllers: [Core.ViewControllable]) {
    super.setViewControllers(viewControllers.map(\.uiController), animated: true)
  }


}

extension UITabBarItem {
  static func makeTabItem(_ item: TabItem) -> UITabBarItem {
    return UITabBarItem(
      title: item.rawValue,
      image: UIImage(systemName: item.image),
      tag: item.tag)
  }
}
