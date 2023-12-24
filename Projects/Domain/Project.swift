//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/14.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project(
  name: Feature.Domain.rawValue,
  targets: [
    .makeFramework(
      name: Feature.Domain.rawValue,
      prodcutType: .framework,
      sources: [ "Sources/**" ],
      dependencies: [
        .feature(interface: .Character),
      ]
    )
  ]
)
