//
//  Project.swift
//  Config
//
//  Created by Kanghos on 2023/11/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project(
  name: Feature.Core.rawValue,
  targets: [
    .makeFramework(
      name: Feature.Core.rawValue,
      prodcutType: .framework,
      sources: [ "Sources/**" ],
      dependencies: [
        .module(implementation: .ThirdPartyLibs, pathName: .Modules(.ThirdPartyLibs)),
        .module(implementation: .Networks, pathName: .Modules(.Networks)),
        .module(implementation: .DesignSystem, pathName: .Modules(.DesignSystem))
      ]
    )
  ]
)
