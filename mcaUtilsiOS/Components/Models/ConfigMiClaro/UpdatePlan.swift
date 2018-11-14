//
//  UpdatePlan.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import ObjectMapper

class UpdatePlan: NSObject, Mappable {

    var actualPlan : String?
    var actualPlanDetail : String?
    var agreeAcceptDisclaimer : String?
    var alreadyTicket : String?
    var planIncludes : String?
    var requestPlanChange : String?
    var selectedLine : String?
    var successChangePlan : String?
    var updatePlanExists : String?
    var updatePlanHeader : String?
    var viewMore : String?
    var wantToContinuePlan : String?
    var weContactYou : String?
    var yourActualRate : String?
    var yourFolio : String?

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
        actualPlan <- map["actualPlan"]
        actualPlanDetail <- map["actualPlanDetail"]
        agreeAcceptDisclaimer <- map["agreeAcceptDisclaimer"]
        alreadyTicket <- map["alreadyTicket"]
        planIncludes <- map["planIncludes"]
        requestPlanChange <- map["requestPlanChange"]
        selectedLine <- map["selectedLine"]
        successChangePlan <- map["successChangePlan"]
        updatePlanExists <- map["updatePlanExists"]
        updatePlanHeader <- map["updatePlanHeader"]
        viewMore <- map["viewMore"]
        wantToContinuePlan <- map["wantToContinuePlan"]
        weContactYou <- map["weContactYou"]
        yourActualRate <- map["yourActualRate"]
        yourFolio <- map["yourFolio"]
    }

}
