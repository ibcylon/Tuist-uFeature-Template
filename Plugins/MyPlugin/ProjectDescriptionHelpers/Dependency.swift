//
//  Dependency.swift
//  MyPlugin
//
//  Created by Kanghos on 2023/12/22.
//

import Foundation
import ProjectDescription

public extension TargetDependency {
  static func external(_ module: External) -> ProjectDescription.TargetDependency {
    .external(name: module.rawValue)
  }
}

public enum External: String {
  case RxSwift
  case RxCocoa
  case SnapKit
  case CachedAsyncImage
  case RxCocoaRuntime
  case RxRelay
  case RxBlocking
  case RxTest
}
