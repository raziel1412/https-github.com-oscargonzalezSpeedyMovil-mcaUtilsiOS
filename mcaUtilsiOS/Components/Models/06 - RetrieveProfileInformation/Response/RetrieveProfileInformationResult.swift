//
//  RetrieveProfileInformationResult.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 14/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase que representa el Response utilizado para consumir el servicio RetrieveProfileInformation. Despliega la información del perfil de la cuenta de usuario
/// Forma parte del adaptador MC_IdentityManagementAdapter
class RetrieveProfileInformationResult : BaseResult{

    var retrieveProfileInformationResponse : RetrieveProfileInformationResponse?
    var retrieveProfileInformationFault : BaseFault?

    override init() {
        super.init();
    }

    required init?(map: Map) {
        super.init();
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
        retrieveProfileInformationResponse <- map["RetrieveProfileInformationResponse"]
        retrieveProfileInformationFault <- map["RetrieveProfileInformationFault"]
    }

}
