//
//  DesignSystem.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/22.
//

import Foundation
import ProjectDescription
import MyPlugin

public extension Project {
  static func designSystem(
    name: String,
    dependencies: [TargetDependency],
    infoPlist: InfoPlist
  ) -> Project {

    let target = Target(
      name: name,
      platform: .iOS,
      product: .framework,
      bundleId: EnvironmentHelpers.rootPackagesName + name,
      deploymentTarget: EnvironmentHelpers.basicDeployment,
      infoPlist: infoPlist,
      sources: "Sources/**",
      resources: "Resources/**",
      dependencies: dependencies
    )

    // Lottie 파일

    return Project(
      name: name,
      targets: [target],
      resourceSynthesizers: [
        .custom(
          name: "Lottie",
          parser: .json,
          extensions: ["lottie"]
        ),
        .assets(),
        .fonts(),
      ]
    )
  }
}
