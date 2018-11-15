//
//  JSONIntToStringTransformation.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 16/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class JSONIntToStringTransform: TransformType {

    typealias Object = Int
    typealias JSON = String

    init() {}

    func transformFromJSON(_ value: Any?) -> Object? {
        if let strValue = value as? JSON {
            return Object(strValue)
        }
        return value as? Object ?? nil
    }

    func transformToJSON(_ value: Object?) -> JSON? {
        if let intValue = value {
            return String(format: "%d", intValue);
        }
        return nil
    }
}
