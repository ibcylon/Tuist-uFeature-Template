//
//  Demo+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/12/22.
//

import Foundation
import ProjectDescription
import MyPlugin

public extension Target {
  static func feature(
    demo featureName: Feature,
    dependencies: [TargetDependency] = [],
    resources: ResourceFileElements? = EnvironmentHelpers.globalResourcePath
  ) -> Target {
    .makeDemoApp(
      name: featureName.rawValue + "Demo",
      sources: [ "Demo/Sources/**" ],
      resources: resources,
      dependencies: dependencies
    )
  }

  private static func makeDemoApp(
    name: String,
    sources: SourceFilesList,
    resources: ResourceFileElements? = [],
    dependencies: [TargetDependency]
  ) -> Target {
    Target(
      name: name + "v1",
      platform: .iOS,
      product: .app,
      bundleId: EnvironmentHelpers.makeBundleID(with: name),
      deploymentTarget: EnvironmentHelpers.basicDeployment,
      infoPlist: .extendingDefault(with: appInfoPlistExtension(name: name)),
      sources: sources,
      resources:  resources,
      dependencies: dependencies
    )
  }
}
