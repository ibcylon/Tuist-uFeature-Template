//
//  MainBuilder.swift
//  Feature
//
//  Created by Kanghos on 2023/11/27.
//

import UIKit

import Core
import Domain

import Character

public final class MainBuilder: MainBuildable {
  public init() { }

  func build(rootViewControllable: Core.ViewControllable) -> MainCoordinating {
    let tabBar = RMTabBarController()
    
    let characterHome = CharacterBuilder()

    rootViewControllable.setViewControllers([tabBar])

    let coordinator = MainCoordinator(
      mainViewControllable: tabBar,
      characterHome: characterHome
    )

    return coordinator
  }


}
