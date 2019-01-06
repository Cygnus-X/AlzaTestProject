//
//  CustomNetworkActivityPlugin.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import Moya
import Result

public final class CustomNetworkActivityPlugin: PluginType {
    
    // Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
    }
    
    // Called by the provider as soon as a response arrives, even if the request is cancelled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
    }
}
