//
//  LaunchBuilder.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit

import Core

protocol AppRootBuildable {
  func build() -> LaunchCoordinating
}

public final class AppRootBuilder: AppRootBuildable {
  public init() { }

  public func build() -> LaunchCoordinating {

    let rootViewController = NavigationControllable(rootViewControllable: RMLaunchViewController())
    return AppCoordinator(
      rootViewControllable: rootViewController,
      mainBuildable: MainBuilder(),
      registerBuildable: RegisterBuilder()
    )
  }
}

