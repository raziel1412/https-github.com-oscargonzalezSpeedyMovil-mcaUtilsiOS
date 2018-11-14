//
//	CreateNewRegisterResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio CreateNewRegister. Crea un nuevo registro de cuenta  en los sistemas de backend permitiendo la administración de los servicios
/// Forma parte del adaptador MC_IdentityManagementAdapter
class CreateNewRegisterResponse : BaseResponse{

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }
}
