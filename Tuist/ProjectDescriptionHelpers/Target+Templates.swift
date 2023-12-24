//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Kanghos on 2023/11/26.
//

import ProjectDescription
import MyPlugin

public extension Target {
  static func makeApp(
    name: String,
    sources: ProjectDescription.SourceFilesList,
    dependencies: [ProjectDescription.TargetDependency]
  ) -> Target {
    Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: EnvironmentHelpers.makeBundleID(with: "app"),
      deploymentTarget: EnvironmentHelpers.basicDeployment,
      infoPlist: .extendingDefault(with: appInfoPlistExtension()),
      sources: sources,
      resources: EnvironmentHelpers.globalResourcePath,
      dependencies: dependencies
    )
  }

  static func makeFramework(
    name: String,
    prodcutType: ProjectDescription.Product,
    sources: ProjectDescription.SourceFilesList,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    Target(
      name: name,
      platform: .iOS,
      product: prodcutType,
      bundleId: EnvironmentHelpers.makeBundleID(with: name + ".framework"),
      deploymentTarget: EnvironmentHelpers.basicDeployment,
      sources: sources,
      resources: resources,
      dependencies: dependencies
    )
  }

  // MARK: Implement

  private static func feature(
    implementation featureName: String,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .makeFramework(
      name: featureName,
      prodcutType: .staticFramework,
      sources: [ "Sources/**" ],
      dependencies: dependencies,
      resources: resources
    )
  }

  // MARK: Interface

  private static func feature(
    interface featureName: String,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .makeFramework(
      name: featureName + "Interface",
      prodcutType: .framework,
      sources: [ "Interface/Sources/**" ],
      dependencies: dependencies,
      resources: resources
    )
  }

  static func feature(
    implementation featureName: Feature,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .feature(
      implementation: featureName.rawValue,
      dependencies: dependencies,
      resources: resources
    )
  }

  static func feature(
    interface featureName: Feature,
    dependencies: [ProjectDescription.TargetDependency] = [],
    resources: ProjectDescription.ResourceFileElements? = []
  ) -> Target {
    .feature(
      interface: featureName.rawValue,
      dependencies: dependencies,
      resources: resources
    )
  }
  
  static func feature(
    dependencies: [ProjectDescription.TargetDependency] = []
  ) -> Target {
    .makeFramework(
      name: "Feature",
      prodcutType: .staticFramework,
      sources: "Sources/**",
      dependencies: dependencies
    )
  }
}
