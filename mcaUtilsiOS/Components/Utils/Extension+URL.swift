//
//  Extension+URL.swift
//  mcaUtilsiOS
//
//  Created by Roberto on 11/22/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import Foundation

extension URL {
    static var documentsDirectory: URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(string: documentsDirectory)!
    }
    
    static func urlInDocumentsDirectory(with filename: String) -> URL {
        return documentsDirectory.appendingPathComponent(filename)
    }
}
