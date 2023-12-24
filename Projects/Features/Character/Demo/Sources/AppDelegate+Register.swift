//
//  SceneDelegate+Register.swift
//  App
//
//  Created by Kanghos on 2023/11/26.
//

import UIKit

import Core

import Networks

import Character
import Domain
import Data

extension AppDelegate {
  var container: DIContainer {
    DIContainer.shared
  }

  func registerDependencies() {

    container.register(
      interface: FetchCharacterUseCaseInterface.self,
      implement: {
        FetchRMCharacterUseCase(
          repository: CharacterRepository(
            characterService: DefaultCharacterService(endPoint: APIComponent(endPoint: .character)))
        )
      }
    )
  }
}
