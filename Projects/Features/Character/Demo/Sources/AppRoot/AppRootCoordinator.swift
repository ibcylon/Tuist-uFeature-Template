//
//  AppCoordinator.swift
//  App
//
//  Created by Kanghos on 2023/12/01.
//

import UIKit
import Core
import CharacterInterface

protocol AppCoordinating {
  func featureHomeFlow()
}

final class AppCoordinator: LaunchCoordinator, AppCoordinating {

  private let mainBuildable: CharacterBuildable

  init(
    rootViewControllable: ViewControllable,
    mainBuildable: CharacterBuildable
  ) {
    self.mainBuildable = mainBuildable
    super.init(rootViewController: rootViewControllable)
  }

  public override func start() {
    featureHomeFlow()
  }

  // MARK: - public

  func featureHomeFlow() {
    let coordinator = self.mainBuildable.build(rootViewControllable: self.viewControllable)
    attachChild(coordinator)
    coordinator.delegate = self

    coordinator.start()
  }
}

extension AppCoordinator: CharacterCoordinatorDelegate {
  func detach(_ coordinator: Core.Coordinator) {
    detachChild(coordinator)
  }
}
