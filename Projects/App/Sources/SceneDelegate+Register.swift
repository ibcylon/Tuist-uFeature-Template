//
//  SceneDelegate+Register.swift
//  App
//
//  Created by Kanghos on 2023/11/26.
//

import UIKit

import Core
import Data

import Feature
import Networks

import CharacterInterface
import Character

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
