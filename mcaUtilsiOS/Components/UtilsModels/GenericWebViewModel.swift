//
//  GenericWebViewModel.swift
//  mcaUtilsiOS
//
//  Created by Pilar del Rosario Prospero Zeferino on 12/12/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import UIKit

public class GenericWebViewModel: NSObject {
    
    public var headerTitle: String!
    public var serviceSelected: WebViewType! /// Variable que almacena el servicio seleccionado
    public var buttonNavType: ButtonNavType!
    public var rut: String? /// Required for billing payment, ScheduleCAC, HoursCAC
    public var email: String? /// Required for billing payment, ScheduleCAC, , HoursCAC
    public var name: String? /// Required for ScheduleCAC
    public var reloadUrlSuccess: String! /// Constante que tiene la URL recarga
    public var paidUrlSucces: String! /// Constante que tiene la URL pago
    public var loadUrl: String! /// url to show in Web view
    
    public init(headerTitle: String!, serviceSelected: WebViewType!, loadUrl: String!, buttonNavType: ButtonNavType!, rut: String? = "", email: String? = "", name: String? = "", reloadUrlSuccess: String!, paidUrlSucces: String!) {
        super.init()
        self.headerTitle = headerTitle
        self.serviceSelected = serviceSelected
        self.loadUrl = loadUrl
        self.buttonNavType = buttonNavType
        if let _ = rut {self.rut = rut} else {self.rut = ""}
        if let _ = rut {self.email = rut} else {self.email = ""}
        if let _ = rut {self.name = rut} else {self.name = ""}
        self.reloadUrlSuccess = reloadUrlSuccess
        self.paidUrlSucces = paidUrlSucces
    }

}

public enum WebViewType: String {
    case BillingPayment = "billingPayment"
    case Reload = "reload"
    case TermsAndConditios = "t&c"
    case Hiring = "hiring"
    case BranchV = "sucursalV"
    case HelpCenters = "centrosAyuda"
    case TechService = "techService"
    case ScheduleCAC = "agendarCAC"
    case HoursCAC = "horasCAC"
}


