//
//	RetrieveSwitchPlanImplicationsResponse.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

/// Clase que representa los datos del Response utilizado para consumir el servicio RetrieveSwitchPlanImplications. Para obtener el costo y la información relacionada a un cambio de plan
/// Forma parte del adaptador MC_ServiceManagementAdapter
class RetrieveSwitchPlanImplicationsResponse : BaseResponse{

    var billPeriodToApply : String?
    var implicitCost : Float?
    var startDate : String?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map);
    }

    override func mapping(map: Map)
    {
        super.mapping(map: map);
		billPeriodToApply <- map["BillPeriodToApply"]
		implicitCost <- map["ImplicitCost"]
		startDate <- map["StartDate"]
		
	}

}
