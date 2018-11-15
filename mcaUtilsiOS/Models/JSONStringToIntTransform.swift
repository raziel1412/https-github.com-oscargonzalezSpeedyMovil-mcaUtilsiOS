//
//  JSONStringToIntTransform.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 16/05/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class JSONStringToIntTransform: TransformType {

    typealias Object = String
    typealias JSON = Int

    init() {}

    func transformFromJSON(_ value: Any?) -> Object? {
        if let strValue = value as? JSON {
            return Object(strValue)
        }
        return value as? Object ?? nil
    }

    func transformToJSON(_ value: Object?) -> JSON? {
        if let intValue = value {
            return (intValue as NSString).integerValue;
        }
        return nil
    }
}
