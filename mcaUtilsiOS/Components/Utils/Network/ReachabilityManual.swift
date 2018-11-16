//
//  connectivityVerifier.swift
//  MiClaro
//
//  Created by Roberto on 11/15/18.
//  Copyright © 2018 Robs. All rights reserved.
//
import Foundation
import SystemConfiguration

//MARK: Creacion de clase publica
public class ReachabilityManual {
    
    class func connectedToNetwork() -> Bool {
        
        var verifyAddress = sockaddr_in()
        verifyAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        verifyAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &verifyAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let connectionMode = flags.contains(.isWWAN)
        print("Network Observer: Is reachable?: \(isReachable)") //true or false
        print("Network Observer: Needs Connection?: \(needsConnection)")//true or false
        print("Network Observer: Access is by 3G/4G?: \(connectionMode)")//true or false
        return (isReachable && !needsConnection)
    }
    
}

//MARK: Ejemplo de implementacion
/*if ReachabilityManual.connectedToNetwork() == true {
    let url = URL(string: "https://www.google.com")!
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) {data, response, error in
        if error != nil {
            print("Network Observer: Internet Connection not Available!")
        }
        else if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                print("Network Observer: Internet Connection OK")
            }
            print("statusCode: \(httpResponse.statusCode)")
        }
    }
    task.resume()
} else {
    print("Network Observer: Internet connection FAILED")
}
*/
