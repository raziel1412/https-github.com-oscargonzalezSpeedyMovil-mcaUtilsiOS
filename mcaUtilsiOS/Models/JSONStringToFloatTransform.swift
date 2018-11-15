//
//  JSONStringToFloatTransform.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation
import ObjectMapper

class JSONStringToFloatTransform: TransformType {
    
    typealias StringObject = String
    typealias JSONDouble = Double
    
    init() {}
    
    func transformFromJSON(_ value: Any?) -> StringObject? {
        if let strValue = value as? JSON {
            return StringObject(strValue)
        }
        return value as? StringObject ?? nil
    }
    
    func transformToJSON(_ value: StringObject?) -> JSONDouble? {
        if let intValue = value {
            return (intValue as NSString).doubleValue;
        }
        return nil
    }
}
