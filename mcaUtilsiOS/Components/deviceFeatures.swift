//
//  deviceFeatures.swift
//  mcaUtilsiOS
//
//  Created by Roberto on 11/20/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import Foundation
import ReachabilitySwift

public func isNetworkConnected() -> Bool {
    
    let reachability = Reachability()
    
    let connected = reachability?.isReachable ?? true;
    return connected;
}

