//
//  UsagePermissionsText.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class UsagePermissionsText : NSObject, Mappable {

    var usagePermissionsAlbum : String?
    var usagePermissionsBill : String?
    var usagePermissionsCamera : String?
    var usagePermissionsGPS : String?
    var usagePermissionsLater : String?
    var usagePermissionsNow : String?
    var usagePermissionsSIM : String?
    var usagePermissionsTitle : String?

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {
        super.init();
    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        usagePermissionsAlbum <- map["usagePermissionsAlbum"]
        usagePermissionsBill <- map["usagePermissionsBill"]
        usagePermissionsCamera <- map["usagePermissionsCamera"]
        usagePermissionsGPS <- map["usagePermissionsGPS"]
        usagePermissionsLater <- map["usagePermissionsLater"]
        usagePermissionsNow <- map["usagePermissionsNow"]
        usagePermissionsSIM <- map["usagePermissionsSIM"]
        usagePermissionsTitle <- map["usagePermissionsTitle"]
    }
}
