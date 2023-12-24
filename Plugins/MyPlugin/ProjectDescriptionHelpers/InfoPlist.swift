//
//  InfoPlist.swift
//  MyPlugin
//
//  Created by Kanghos on 2023/11/19.
//

import ProjectDescription

public func infoPlistExtension(name: String) -> [String: InfoPlist.Value] {
  [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "CFBundleName": "\(name)",

    // MARK: Font 추가
    "UIAppFonts": [
      //      "Item 0": "Pretendard-Medium.otf",

    ],
  ]
}

public func appInfoPlistExtension(name: String = EnvironmentHelpers.appName) -> [String: InfoPlist.Value] {
  [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UILaunchStoryboardName": "LaunchScreen",
    "CFBundleName": "\(name)",

    "UIApplicationSceneManifest": [
      "UIApplicationSupportsMultipleScenes": false,
      "UISceneConfigurations": [
        "UIWindowSceneSessionRoleApplication": [
          [
            "UISceneConfigurationName": "Default Configuration",
            "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
          ],
        ]
      ]
    ],
    "App Transport Security Settings": ["Allow Arbitrary Loads": true],
    "UIUserInterfaceStyle": "Dark",

    // MARK: Font 추가
    "UIAppFonts": [
      //      "Item 0": "Pretendard-Medium.otf",

    ],
  ]
}
