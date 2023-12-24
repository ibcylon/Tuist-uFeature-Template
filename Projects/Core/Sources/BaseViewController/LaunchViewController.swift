//
//  LaunchVIewController.swift
//  App
//
//  Created by Kanghos on 2023/11/30.
//

import UIKit
import DSKit

public final class RMLaunchViewController: RMBaseViewController {

  public override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .orange
    

    let view = UIImageView(image: DSKitAsset.launchSreen.image)
    view.contentMode = .scaleAspectFit
    view.backgroundColor = .black
    view.bounds = self.view.bounds

    view.center = self.view.center
    self.view.addSubview(view)
  }
  
  public override func navigationSetting() {

  }
}
