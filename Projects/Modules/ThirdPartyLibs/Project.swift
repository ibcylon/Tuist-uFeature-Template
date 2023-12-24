//
//  Project.swift
//  Config
//
//  Created by Kanghos on 2023/11/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.dynamicFramework(
  name: Feature.ThirdPartyLibs.rawValue,
  dependencies: [
    .external(.RxSwift),
    .external(.SnapKit),
    .external(.RxCocoa),
    .external(.CachedAsyncImage)
  ]
)
