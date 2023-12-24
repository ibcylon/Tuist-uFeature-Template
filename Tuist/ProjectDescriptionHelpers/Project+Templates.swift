import ProjectDescription
import MyPlugin

public extension Project {
   static func dynamicFramework(
    name: String,
    dependencies: [TargetDependency]
  ) -> Project {
    let target = Target(
        name: name,
        platform: .iOS,
        product: .framework,
        bundleId: EnvironmentHelpers.rootPackagesName + "\(name)",
        deploymentTarget: EnvironmentHelpers.basicDeployment,
        infoPlist: .default,
        sources: ["Sources/**/*.swift"],
        resources:  EnvironmentHelpers.globalResourcePath,
        dependencies: dependencies
    )

    return Project(
      name: name,
      targets: [target]
    )
  }

  static func library(
   name: String,
   dependencies: [TargetDependency],
   product: Product = .staticLibrary
 ) -> Project {
   let target = Target(
       name: name,
       platform: .iOS,
       product: product,
       bundleId: EnvironmentHelpers.rootPackagesName + "\(name)",
       deploymentTarget: EnvironmentHelpers.basicDeployment,
       infoPlist: .default,
       sources: ["Sources/**/*.swift"],
       resources:  nil,
       dependencies: dependencies
   )

   return Project(
     name: name,
     targets: [target]
   )
 }

}
