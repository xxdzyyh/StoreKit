//
//  AuthPlugin.swift
//  iOSAppNext
//
//  Created by XXXX on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import Moya

protocol AuthorizedTargetType: TargetType {
  var needsAuth: Bool { get }
}

struct AuthPlugin: PluginType {
  let tokenClosure: () -> String?

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    guard
      let token = tokenClosure(),
      let target = target as? AuthorizedTargetType,
      target.needsAuth
    else {
      return request
    }

    var request = request
    request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    return request
  }
}
