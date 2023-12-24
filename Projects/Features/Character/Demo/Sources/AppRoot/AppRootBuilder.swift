
//
//  LaunchBuilder.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit

import Core

import Character
import Domain

protocol AppRootBuildable {
  func build() -> LaunchCoordinating
}

public final class AppRootBuilder: AppRootBuildable {
  public init() { }

  public func build() -> LaunchCoordinating {

    let rootViewController = NavigationControllable(rootViewControllable: RMLaunchViewController())
    let characterBuilder = CharacterBuilder()
    return AppCoordinator(
      rootViewControllable: rootViewController,
      mainBuildable: characterBuilder
    )
  }
}
