//
//  CardsMovilModel.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 27/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import Foundation

enum TypeAccountService {
    case None
    case Resumen
    case MovilPrepago
    case MovilPospago
    case Television
    case TodoClaro
    case Internet
    case LineaFija
    case Suscripcion
}

class CardsMovilModel {
    var accountID: String = ""
    var typeAccount: TypeAccountService = .None
    var lob: String = ""
    
    /// La cantidad de elementos en arrayServices y arrayPlans siempre serán los mismos
    /// Por tal motivo la relación siempre sera con el indice de cada arreglo 0 -> 0, 1 -> 1
    var arrayServices: [AssociatedServicesCard] = []
    var arrayPlans: [PlanDetailCard] = []
    var arrayDataGraphic: [DataGraphicCard] = []
    var cycleInformation: CycleInformation?
    var showSaldoSection: Bool = false
    /*Saldos promocional y maestro*/
    var saldosSection: SaldoPromoMaster?
    /*var saldoPromocional: String = ""
    var saldoMaestro: String = ""
    var datePromocional: String = ""
    var dateMaestro: String = ""*/
    
    init() {
    }
    
    /// Settear la informacion
    func setAccountID(accountID: String) {
        self.accountID = accountID
    }
    
    func setLOB(lob: String) {
        self.lob = lob
    }
    
    func appendService(service: AssociatedServicesCard) {
        self.arrayServices.append(service)
    }
    
    func appendPlan(plan: PlanDetailCard) {
        self.arrayPlans.append(plan)
    }
    
    func appendDataGraphic(data: DataGraphicCard) {
        self.arrayDataGraphic.append(data)
    }
    
    func setTypeAccount(lob: String) {
        switch lob {
        case "2":
            self.typeAccount = .MovilPrepago
            break
        case "3":
            self.typeAccount = .MovilPospago
            break
        default:
            break
        }
    }
    
    func setCycleInformation(cycleData: CycleInformation) {
        self.cycleInformation = cycleData
    }
    
    func setShowSaldoSection(showSection: Bool) {
        self.showSaldoSection = showSection
    }
    
    func setDataSaldos(dataSaldo: SaldoPromoMaster) {
        self.saldosSection = dataSaldo
    }
    /*func setSaldoPromocional(saldo: String, date: String) {
        self.saldoPromocional = saldo
        self.datePromocional = date
    }
    
    func setDateSaldoMaestro(saldo:String, date: String) {
        self.saldoMaestro = saldo
        self.dateMaestro = date
    }*/
}

class AssociatedServicesCard {
    var nameService: String = ""
    var indexService: Int = 0
    
    init() {
    }
    
    func setNameService(nameService: String) {
        self.nameService = nameService
    }
    
    func setIndexService(index: Int) {
        self.indexService = index
    }
}

class PlanDetailCard {
    var namePlan: String = ""
    var arrayServiceDescription: [(String, String)] = []
    var datePlanVigency: String = ""
    var balancePlan: Float = 0.0
    var planDescription: String = ""
    
    init() {
    }
    
    /// Nombre del plan
    func setNamePlan(namePlan: String) {
        self.namePlan = namePlan
    }
    
    /// Información a mostrar para el "Detalle del plan"
    func setServiceDetail(detailPlan: [(String, String)]) {
        self.arrayServiceDescription = detailPlan
    }
    
    /// Informacion a mostrar para saber el saldo actual del plan
    func setBalancePlan(balance: Float, dateVigency: String) {
        self.balancePlan = balance
        self.datePlanVigency = dateVigency
    }
    
    /// Detalle del plan, solo para cuentas pospago
    func setPlanDescription(descriptionPlan: String) {
        self.planDescription = descriptionPlan
    }
}

class DataGraphicCard {
    var serviceFeatureType: String = ""
    var usageLimit: String = ""
    var usageLimitUnit: String = ""
    var consumingUser: String = ""
    var consumingUserUnit: String = ""
    var dateFinish: String = ""
    var existRRSS: Bool = false
    var has3country: Bool = false
    var has8country: Bool = false
    var serviceBusinessType: String = ""
    var featureReminderQuantity: Float = -20.0
    var typeCard: Int = 1
    
    var arraySocialNetwork: [TypeSocialNetwork] = []
    
    init() {
    }
    
    func setServiceFeatureType(service: String) {
        //self.serviceFeatureType = self.setNameServiceFeatureType(service: service)
        self.setNameServiceFeatureType(service: service)
    }
    
    func setUsageLimit(usageLimit: String, usageLimitUnit: String) {
        self.usageLimit = usageLimit
        self.usageLimitUnit = usageLimitUnit
    }
    
    func setConsumingUser(consumingUser: String, consumingUserUnit: String) {
        self.consumingUser = consumingUser
        self.consumingUserUnit = consumingUserUnit
    }
    
    func setDateFinish(date: String) {
        self.dateFinish = date
    }
    
    func setExistRRSS(exist: Bool) {
        self.existRRSS = exist
    }
    
    func setArraySocialNetwork(arraySocial: [TypeSocialNetwork]) {
        self.arraySocialNetwork = arraySocial
    }
    
    func setServiceBusinessType(type: String) {
        self.serviceBusinessType = type
    }
    
    func setFeatureReminderQuantity(quantity: Float) {
        self.featureReminderQuantity = quantity
    }
    
    private func setNameServiceFeatureType(service: String){
        switch service.uppercased() {
        case "INTERNET":
            self.serviceFeatureType = "Datos"
            break
        case "MINUTOS":
            self.serviceFeatureType = "MINS"
            break
        case "MINUTOS A TODO DESTINO":
            self.serviceFeatureType = "MINS"
            break
        case "MINUTOS LARGA DISTANCIA INTERNACIONAL 3 PAISES":
            self.serviceFeatureType = "Minutos internacionales"
            self.setHas3countries()
            break
        case "MINUTOS LARGA DISTANCIA INTERNATIONAL 8 PAISES":
            self.serviceFeatureType = "Minutos internacionales"
            self.setHas8countries()
            break
        case "SMS":
            self.serviceFeatureType = "SMS"
            break
        case "SMS TODO DESTINO":
            self.serviceFeatureType = "SMS"
            break
        default:
            break
        }
    }
    
    private func setHas3countries() {
        self.has3country = true
    }
    
    private func setHas8countries() {
        self.has8country = true
    }
}

class CycleInformation {
    var startDate: String = ""
    var endDate: String = ""
    var remainingDays: Int = 0
    
    init() {
    }
    
    func setStartDate(date: String) {
        self.startDate = date
    }
    
    func setEndDate(date: String) {
        self.endDate = date
    }
    
    func setRemainingDays(days: Int) {
        self.remainingDays = days
    }
}

struct SaldoPromoMaster {
    var saldoMaestro: String = ""
    var saldoPromocional: String = ""
    var dateMaestro: String = ""
    var datePromocional: String = ""
}
