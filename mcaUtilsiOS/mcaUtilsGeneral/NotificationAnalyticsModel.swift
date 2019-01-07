//
//  NotificationAnalyticsModel.swift
//  mcaUtilsiOS
//
//  Created by Pilar del Rosario Prospero Zeferino on 1/7/19.
//  Copyright © 2019 Roberto. All rights reserved.
//

import UIKit

public class NotificationAnalyticsModel: NSObject {
    
    public var viewName: String!
    public var isStopped: Bool!
    public var message: String!
    
    public init(viewName: String, isStopped: Bool = false, message: String = "") {
        super.init()
        self.viewName = viewName
        self.isStopped = isStopped
        self.message = message
    }

}
