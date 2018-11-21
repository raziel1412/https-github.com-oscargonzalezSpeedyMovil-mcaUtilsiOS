//
//  deviceFeatures.swift
//  mcaUtilsiOS
//
//  Created by Roberto on 11/20/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import Foundation

open func isNetworkConnected() -> Bool {
    let connected = self.reachability?.isReachable ?? true;
    return connected;
}
