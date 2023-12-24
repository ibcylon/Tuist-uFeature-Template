//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/22.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.designSystem(
  name: Feature.DesignSystem.rawValue,
  dependencies: [],
  infoPlist: .extendingDefault(with: infoPlistExtension(name: Feature.DesignSystem.rawValue))
)
