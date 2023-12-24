//
//  Workspace.swift
//  Config
//
//  Created by Kanghos on 2023/11/19.
//

import ProjectDescription
import MyPlugin

let workspace = Workspace(
  name: EnvironmentHelpers.appName,
  projects: [
    "Projects/*"
  ])
