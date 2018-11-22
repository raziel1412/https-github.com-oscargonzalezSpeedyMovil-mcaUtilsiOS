//
//  File.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 09/07/18.
//  Copyright © 2018 am. All rights reserved.
//
/*
import Foundation

public class CardsSummaryModel {
    var typeAccount: TypeAccountService = .None
    var nameService: String = ""
    var dateVigency: String = ""
    var amount: Float = 0.0
    
    func setTypeAccount(typeAccount: TypeAccountService) {
        self.typeAccount = typeAccount
    }
    
    func setNameService(nameService: String){
        self.nameService = nameService
    }
    
    func setDateVigency(date: String) {
        self.dateVigency = date
    }
    
    func setAmount(amount: Float) {
        self.amount = amount
    }
    
}


public class AccountManagement {
    var arrayServices       : [ServiceAccount]       = []
    var arrayMovilData      : [CardsMovilModel]      = []
    var arrayTVData         : [CardsTelevisionModel] = []
    var arrayTodoClaroData  : [CardsTodoClaroModel]  = []
    var arrayHomeService    : [HomeServiceDetailModel]=[]
    var arrayInternetData   : [CardsInternetModel]   = []
    var arrayLineaFijaData  : [CardsLineaFijaModel] = []
    var arrayPlanCards      : [PlanCard]             = []
    
    init(arrayServices: [ServiceAccount]) {
        self.arrayServices = arrayServices
    }
    
    //MARK: Movil
    /// Recuperar cuentas de tipo movil
    func filterMovilAccount() {
        self.arrayMovilData.removeAll()
        for indexAccount in 0 ..< self.arrayServices.count {
            let account = self.arrayServices[indexAccount]
            if !("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness) {
                continue
            }
            
            let totalServices = account.detailServices?.associatedService?.count ?? 0;
            for idxService in 0 ..< totalServices {
                // Crear modelo de tipo Movil
                let movilModel = CardsMovilModel()
                movilModel.setAccountID(accountID: (account.account?.accountId)!)
                movilModel.setLOB(lob: account.account?.lineOfBusiness ?? "")
                movilModel.setTypeAccount(lob: (account.account?.lineOfBusiness)!)
                
                //Recuperar informacion del servicio asociado
                let serviceCard = AssociatedServicesCard()
                let associateService: AssociatedService = (account.detailServices?.associatedService![idxService])!
                let nameService: String = associateService.serviceID!
                serviceCard.setNameService(nameService: nameService)
                serviceCard.setIndexService(index: idxService)
                
                if account.detailServices!.detailPlan!.count > idxService{
                    if let arrayServiceUsage = account.detailServices?.detailPlan![safe: idxService]?.retrieveConsumptionDetailInformation?.serviceUsage {
                        //Obtener el tipo de cuenta, Prepago, Pospago o cuenta exacta
                        let typeAccountMovil = account.detailServices?.detailPlan![safe: idxService]?.retrieveConsumptionDetailInformation?.serviceBusinessType ?? ""
                        //                        movilModel.setTypeAccount(lob: typeAccountMovil)//(account.account?.lineOfBusiness)!)
                        //                        let typeAccountMovil = "PRE"
                        
                        
                        if (arrayServiceUsage.count != 0){
                            for serviceUsage in arrayServiceUsage {
                                //                            let dataGraphic = DataGraphicCard()
                                for serviceFeature in (serviceUsage.serviceFeatureUsage)! {
                                    
                                    let dataGraphic = DataGraphicCard()
                                    print("ENCONTRAMOS LA INFORMACIÓN A MOSTRAR")
                                    //Obtener el limite del plan
                                    var serviceType = ""
                                    var usageLimit: Float = 0.0
                                    var unitUsage = ""
                                    var consumoUser: Float = 0.0
                                    var consumoUserUnit = "Disponibles"
                                    let stringToDate = convertStringToDate2(stringDate: serviceUsage.serviceUsagePeriod?.endDate ?? "")
                                    let dateValue = getStringDate(date: stringToDate)
                                    
                                    let total = Int(serviceFeature.serviceFeatureUsageLimit?.quantity ?? 0)
                                    
                                    switch total {
                                    case -1,-3: //Libres y Ilimitados
                                        serviceType = serviceFeature.serviceFeatureType ?? ""
                                        usageLimit = Float(serviceFeature.featureUsage?.quantity ?? 0.0)
                                        unitUsage = serviceFeature.featureUsage?.unit ?? ""
                                        consumoUser = Float(serviceFeature.featureUsage?.quantity ?? 0.0)
                                        consumoUserUnit = serviceFeature.featureUsage?.unit ?? "Disponibles"
                                        break
                                    case 0:
                                        serviceType = serviceFeature.serviceFeatureType ?? ""
                                        usageLimit = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        unitUsage = serviceFeature.featureReminder?.unit ?? ""
                                        consumoUser = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        consumoUserUnit = serviceFeature.featureReminder?.unit ?? "Disponibles"
                                    default:
                                        serviceType = serviceFeature.serviceFeatureType ?? ""
                                        usageLimit = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        unitUsage = serviceFeature.featureReminder?.unit ?? ""
                                        consumoUser = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        consumoUserUnit = serviceFeature.featureReminder?.unit ?? "Disponibles"
                                        break
                                    }
                                    
                                    if(account.account?.lineOfBusiness == "2"){ // Prepago lob = 2
                                        let featureReminderQuantity = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        dataGraphic.setFeatureReminderQuantity(quantity: featureReminderQuantity)
                                    }
                                    //Identificar si es una cuenta con redes sociales, mediante serviceUsage->servideID
                                    let serviceIDRRSS = serviceUsage.serviceID ?? "0"
                                    if NSString(string: serviceIDRRSS).floatValue >= 7 {
                                        dataGraphic.setExistRRSS(exist: true)
                                        let RRSStext = serviceUsage.serviceType ?? ""
                                        let socialNetwork = self.setSocialNetwork(social: RRSStext)
                                        dataGraphic.setArraySocialNetwork(arraySocial: socialNetwork)
                                    }
                                    //Identificar si se debe mostrar el tercer botón
                                    let idSaldoSection = serviceUsage.serviceID ?? "0"
                                    if NSString(string: idSaldoSection).floatValue == 6{
                                        if account.account?.lineOfBusiness == "3" {
                                            if let billDetails = account.detailServices?.detailPlan![safe: idxService]?.retrieveBillDetailsResponse {
                                                movilModel.setShowSaldoSection(showSection: true)
                                                let (saldoMaestro, dateMaestro) = self.getSaldoMaestro(billDetails: billDetails)
                                                //Obtener el saldo promocional
                                                let saldoPromocional = serviceFeature.featureReminder?.quantity ?? 0.0
                                                let dataSaldos = SaldoPromoMaster(saldoMaestro: saldoMaestro, saldoPromocional: "\(saldoPromocional)", dateMaestro: dateMaestro, datePromocional: dateValue)
                                                movilModel.setDataSaldos(dataSaldo: dataSaldos)
                                            }
                                        }
                                    }
                                    
                                    //No se debe mostrar la información de Saldo promocional en dataGraphic
                                    if NSString(string: idSaldoSection).floatValue != 6 {
                                        dataGraphic.setServiceFeatureType(service: serviceType)
                                        dataGraphic.setUsageLimit(usageLimit:"\(usageLimit)", usageLimitUnit: unitUsage)
                                        dataGraphic.setConsumingUser(consumingUser: "\(consumoUser)", consumingUserUnit: consumoUserUnit)
                                        dataGraphic.typeCard = total
                                        dataGraphic.setDateFinish(date: dateValue)
                                        dataGraphic.setServiceBusinessType(type: typeAccountMovil)
                                        
                                        movilModel.appendDataGraphic(data: dataGraphic)
                                    }
                                }
                                
                            }
                        }
                    }else{
                        
                    }
                }
                
                let namePlan: String = account.detail?.accountDetails?.plan?[idxService].planName ?? ""
                let planService = PlanDetailCard()
                planService.setNamePlan(namePlan: namePlan)
                
                //Recuperar información del detalle del plan
                if let plans = account.detail?.accountDetails?.plan {
                    let plan = plans[idxService]
                    guard let pl = plan.planLines else {
                        return //numberArrayBody;
                    }
                    if (pl.count > 0) {
                        let planLines = self.getDetailPlanData(pl: pl)
                        planService.setServiceDetail(detailPlan: planLines)
                    }
                }
                
                //Recuperar la información de los Bill items para obtener el monto total a pagar
                let detailPlan = account.detailServices?.detailPlan?[safe: idxService]
                let (balance, dateVigency) = self.getTotalBalanceAccount(detailPlan: detailPlan)
                planService.setBalancePlan(balance: balance, dateVigency: dateVigency)
                
                let descriptionPlan = (account.detail?.accountDetails?.plan?[idxService].planDescription as? String) ?? ""
                planService.setPlanDescription(descriptionPlan: descriptionPlan)
                
                movilModel.appendPlan(plan: planService)
                movilModel.appendService(service: serviceCard)
                
                //Agregar informacion del ciclo de factura
                if account.retrieveCycleInformation != nil {
                    if account.retrieveCycleInformation?.rechargeHistory != nil {
                        let cycleInfo = CycleInformation()
                        let stringStartDate = convertStringToDate2(stringDate: account.retrieveCycleInformation?.rechargeHistory?.first?.startDate ?? "")
                        let startDate = getStringDate(date: stringStartDate)
                        
                        let stringEndDate = convertStringToDate2(stringDate: account.retrieveCycleInformation?.rechargeHistory?.first?.endDate ?? "")
                        let endDate = getStringDate(date: stringEndDate)
                        
                        let daysPending = account.retrieveCycleInformation?.rechargeHistory?.first?.remainingDays ?? 0
                        
                        cycleInfo.setStartDate(date: startDate)
                        cycleInfo.setEndDate(date: endDate)
                        cycleInfo.setRemainingDays(days: daysPending)
                        
                        movilModel.setCycleInformation(cycleData: cycleInfo)
                    }
                }
                
                self.arrayMovilData.append(movilModel)
                
                //Información de boletas
                /*let planCardBoleta = self.setDataPlanCards(account: account)
                 self.arrayPlanCards.append(planCardBoleta)*/
            }
            let planCardBoleta = self.setDataPlanCards(account: account)
            self.arrayPlanCards.append(planCardBoleta)
        }
        print("EXISTEN \(self.arrayMovilData.count) CUENTAS MOVIL")
    }
    
    // Funcion para obtener el tipo de red social
    func setSocialNetwork(social: String) -> [TypeSocialNetwork] {
        var arrayWithIDsocial: [TypeSocialNetwork] = []
        
        let socialTmp = social.replacingOccurrences(of: "RRSS-", with: "")
        let arraySocial = socialTmp.split(separator: ";")
        
        for socialAux in arraySocial {
            let idSocial = String(socialAux)
            
            switch idSocial {
            case "1":
                arrayWithIDsocial.append(.Facebook)
                break
            case "2":
                arrayWithIDsocial.append(.Twitter)
                break
            case "3":
                arrayWithIDsocial.append(.Whatsapp)
                break
            case "4":
                arrayWithIDsocial.append(.Instagram)
                break
            case "5":
                arrayWithIDsocial.append(.ClaroMusica)
                break
            case "6":
                arrayWithIDsocial.append(.Snapchat)
                break
            case "7":
                arrayWithIDsocial.append(.Waze)
                break
            case "8":
                arrayWithIDsocial.append(.ColaboraCloud)
                break
            case "9":
                arrayWithIDsocial.append(.Gmail)
                break
            case "10":
                arrayWithIDsocial.append(.Hotmail)
                break
            case "11":
                arrayWithIDsocial.append(.Yahoo)
                break
            case "12":
                arrayWithIDsocial.append(.facebookMessenger)
                break
            default:
                break
            }
        }
        
        return arrayWithIDsocial
    }
    
    private func getSaldoMaestro(billDetails: RetrieveBillDetailsResponse) -> (String, String){
        let date = billDetails.dueDate ?? ""
        var saldoMaestro = ""
        
        for bill in billDetails.billItem! {
            if bill.descriptionType == "3" {
                saldoMaestro = bill.amountFormat ?? "0"
            }
        }
        
        return (saldoMaestro, date)
    }
    
    func getMovilData() -> [CardsMovilModel] {
        return self.arrayMovilData
    }
    
    //MARK: Linea Fija
    func filterLineaFijaAccount() {
        self.arrayLineaFijaData.removeAll()
        for indexAccount in 0 ..< self.arrayServices.count {
            let account = self.arrayServices[indexAccount]
            if ("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness || account.isTodoClaro()) {
                continue;
            }
            
            if account.detailServices?.associatedService?.first?.serviceType == "3" {
                let lineaFijaModel = CardsLineaFijaModel()
                lineaFijaModel.setAccountID(accountID: (account.account?.accountId)!)
                let namePlan: String = account.detail?.accountDetails?.plan?.first?.planName ?? ""
                let addressHome = account.detail?.accountDetails?.plan?.first?.planHomeAddress ?? ""
                lineaFijaModel.planDetail.setNamePlan(namePlan: namePlan)
                lineaFijaModel.setAddressHome(address: addressHome)
                let detailPlan: DetailPlan? = account.detailServices?.detailPlan?.first //[self.indexService])!
                let (balance, dateVigency) = self.getTotalBalanceAccount(detailPlan: detailPlan)
                lineaFijaModel.planDetail.setBalancePlan(balance: balance, dateVigency: dateVigency)
                lineaFijaModel.setTypeAccount(lob: (account.account?.lineOfBusiness)!)
                if account.account?.lineOfBusiness == "1" && !account.isTodoClaro() {
                    guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                        return
                    }
                    
                    if pl.count > 0 {
                        let planLines = self.getDetailPlanData(pl: pl)
                        lineaFijaModel.planDetail.arrayServiceDescription = planLines
                    }
                }
                self.arrayLineaFijaData.append(lineaFijaModel)
                
                //Información de boletas
                let planCardBoleta = self.setDataPlanCards(account: account)
                self.arrayPlanCards.append(planCardBoleta)
            }
        }
    }
    
    func getLineaFijaData() -> [CardsLineaFijaModel] {
        return self.arrayLineaFijaData
    }
    
    //MARK: Television
    func filterTelevisionAccount() {
        self.arrayTVData.removeAll()
        for indexAccount in 0 ..< self.arrayServices.count {
            let account = self.arrayServices[indexAccount]
            if ("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness || account.isTodoClaro()) {
                continue;
            }
            
            if account.detailServices?.associatedService?.first?.serviceType == "4" {
                let tvModel = CardsTelevisionModel()
                tvModel.setAccountID(accountID: (account.account?.accountId)!)
                let namePlan: String = account.detail?.accountDetails?.plan?.first?.planName ?? ""
                let addressHome = account.detail?.accountDetails?.plan?.first?.planHomeAddress ?? ""
                tvModel.planDetail.setNamePlan(namePlan: namePlan)
                tvModel.setAddressHome(address: addressHome)
                let detailPlan: DetailPlan? = account.detailServices?.detailPlan?.first //[self.indexService])!
                let (balance, dateVigency) = self.getTotalBalanceAccount(detailPlan: detailPlan)
                tvModel.planDetail.setBalancePlan(balance: balance, dateVigency: dateVigency)
                tvModel.setTypeAccount(lob: (account.account?.lineOfBusiness)!)
                if account.account?.lineOfBusiness == "1" && !account.isTodoClaro() {
                    guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                        return
                    }
                    
                    if pl.count > 0 {
                        let planLines = self.getDetailPlanData(pl: pl)
                        tvModel.planDetail.arrayServiceDescription = planLines
                    }
                }
                self.arrayTVData.append(tvModel)
                
                //Información de boletas
                let planCardBoleta = self.setDataPlanCards(account: account)
                self.arrayPlanCards.append(planCardBoleta)
            }
        }
    }
    
    func getTelevisionData() -> [CardsTelevisionModel] {
        return self.arrayTVData
    }
    
    //MARK: Internet
    func filterInternetAccount() {
        self.arrayInternetData.removeAll()
        for indexAccount in 0 ..< self.arrayServices.count {
            let account = self.arrayServices[indexAccount]
            if ("2" == account.account?.lineOfBusiness || "3" == account.account?.lineOfBusiness || account.isTodoClaro()) {
                continue;
            }
            
            if account.detailServices?.associatedService?.first?.serviceType == "5" {
                let internetModel = CardsInternetModel()
                internetModel.setAccountID(accountID: (account.account?.accountId)!)
                
                let namePlan: String = account.detail?.accountDetails?.plan?.first?.planName ?? ""
                let addressHome = account.detail?.accountDetails?.plan?.first?.planHomeAddress ?? ""
                internetModel.planDetail.setNamePlan(namePlan: namePlan)
                internetModel.setAddressHome(address: addressHome)
                let detailPlan: DetailPlan? = account.detailServices?.detailPlan?.first //[self.indexService])!
                let (balance, dateVigency) = self.getTotalBalanceAccount(detailPlan: detailPlan)
                internetModel.planDetail.setBalancePlan(balance: balance, dateVigency: dateVigency)
                internetModel.setTypeAccount(lob: (account.account?.lineOfBusiness)!)
                if account.account?.lineOfBusiness == "1" && !account.isTodoClaro() {
                    guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                        return
                    }
                    
                    if pl.count > 0 {
                        let planLines = self.getDetailPlanData(pl: pl)
                        internetModel.planDetail.arrayServiceDescription = planLines
                    }
                }
                self.arrayInternetData.append(internetModel)
                
                //Información de boletas
                let planCardBoleta = self.setDataPlanCards(account: account)
                self.arrayPlanCards.append(planCardBoleta)
            }
        }
    }
    
    func getInternetData() -> [CardsInternetModel] {
        return self.arrayInternetData
    }
    
    //MARK: Todo Claro
    func filterTodoClaroAccount() {
        self.arrayTodoClaroData.removeAll()
        for account in self.arrayServices {
            if !account.isTodoClaro() {
                continue;
            }
            let todoClaroModel = CardsTodoClaroModel()
            todoClaroModel.setAccountID(accountID: (account.account?.accountId)!)
            let namePlan: String = account.detail?.accountDetails?.plan?.first?.planName ?? ""
            let addressHome = account.detail?.accountDetails?.plan?.first?.planHomeAddress ?? ""
            todoClaroModel.planDetail.setNamePlan(namePlan: namePlan)
            todoClaroModel.setAddressHome(address: addressHome)
            let detailPlan: DetailPlan? = account.detailServices?.detailPlan?.first
            let (balance, dateVigency) = self.getTotalBalanceAccount(detailPlan: detailPlan)
            todoClaroModel.planDetail.setBalancePlan(balance: balance, dateVigency: dateVigency)
            todoClaroModel.setTypeAccount(lob: (account.account?.lineOfBusiness)!)
            if account.isTodoClaro() {
                guard let pl = account.detail?.accountDetails?.plan?.first?.planLines else {
                    return
                }
                
                if pl.count > 0 {
                    let planLines = self.getDetailPlanData(pl: pl)
                    todoClaroModel.planDetail.arrayServiceDescription = planLines
                }
            }
            self.arrayTodoClaroData.append(todoClaroModel)
            
            //Información de boletas
            let planCardBoleta = self.setDataPlanCards(account: account)
            self.arrayPlanCards.append(planCardBoleta)
        }
    }
    
    func getTodoClaroData() -> [CardsTodoClaroModel] {
        return self.arrayTodoClaroData
    }
    
    //MARK: Resumen
    func getSummaryAccount() -> [CardsSummaryModel] {
        self.filterMovilAccount()
        self.filterTelevisionAccount()
        self.filterInternetAccount()
        self.filterTodoClaroAccount()
        self.filterLineaFijaAccount()
        //        self.filterSuscripciones()
        let arrayMovil = self.getMovilData()
        let arrayTv = self.getTelevisionData()
        let arrayInternet = self.getInternetData()
        let arrayTodoClaro = self.getTodoClaroData()
        let arrayLineaFija = self.getLineaFijaData()
        
        var arraySummary: [CardsSummaryModel] = []
        
        //Realizar filtrado de la informacion
        for movil in arrayMovil {
            for indexService in 0..<movil.arrayServices.count {
                let summary = CardsSummaryModel()
                summary.setTypeAccount(typeAccount: movil.typeAccount)
                let service = movil.arrayServices[indexService]
                summary.setNameService(nameService: service.nameService)
                let plan = movil.arrayPlans[indexService]
                summary.setDateVigency(date: plan.datePlanVigency)
                summary.setAmount(amount: plan.balancePlan)
                arraySummary.append(summary)
            }
        }
        
        for tv in arrayTv {
            let summary = CardsSummaryModel()
            summary.setTypeAccount(typeAccount: tv.typeAccount)
            summary.setNameService(nameService: tv.addressHome)
            summary.setDateVigency(date: tv.planDetail.datePlanVigency)
            summary.setAmount(amount: tv.planDetail.balancePlan)
            arraySummary.append(summary)
        }
        
        for internet in arrayInternet {
            let summary = CardsSummaryModel()
            summary.setTypeAccount(typeAccount: internet.typeAccount)
            summary.setNameService(nameService: internet.addressHome)
            summary.setDateVigency(date: internet.planDetail.datePlanVigency)
            summary.setAmount(amount: internet.planDetail.balancePlan)
            arraySummary.append(summary)
        }
        
        for todoClaro in arrayTodoClaro {
            let summary = CardsSummaryModel()
            summary.setTypeAccount(typeAccount: todoClaro.typeAccount)
            summary.setNameService(nameService: todoClaro.addressHome)
            summary.setDateVigency(date: todoClaro.planDetail.datePlanVigency)
            summary.setAmount(amount: todoClaro.planDetail.balancePlan)
            arraySummary.append(summary)
        }
        
        for lineaFija in arrayLineaFija {
            let summary = CardsSummaryModel()
            summary.setTypeAccount(typeAccount: lineaFija.typeAccount)
            summary.setNameService(nameService: lineaFija.addressHome)
            summary.setDateVigency(date: lineaFija.planDetail.datePlanVigency)
            summary.setAmount(amount: lineaFija.planDetail.balancePlan)
            arraySummary.append(summary)
        }
        
        return arraySummary
    }
    
    //MARK: Boletas
    func getDataBoletas() -> [TicketBoletaModel] {
        self.filterMovilAccount()
        self.filterTelevisionAccount()
        self.filterInternetAccount()
        self.filterTodoClaroAccount()
        self.filterLineaFijaAccount()
        let arrayMovil = self.getMovilData()
        let arrayTv = self.getTelevisionData()
        let arrayInternet = self.getInternetData()
        let arrayTodoClaro = self.getTodoClaroData()
        let arrayLineaFija = self.getLineaFijaData()
        var arrayBoletas: [TicketBoletaModel] = []
        
        //Realizar filtrado de la información
        for movil in arrayMovil {
            if movil.typeAccount == .MovilPospago {
                for indexService in 0..<movil.arrayServices.count {
                    
                    let boletaModel = TicketBoletaModel()
                    boletaModel.setAccountID(accountID: movil.accountID)
                    boletaModel.setTypeAccount(typeAccount: movil.typeAccount)
                    
                    let service = movil.arrayServices[indexService]
                    boletaModel.setNameService(nameService: service.nameService)
                    boletaModel.setCuenta(cuenta: movil.accountID)
                    boletaModel.setLineOfBussiness(lineOfBussiness: "3")
                    
                    let plan = movil.arrayPlans[indexService]
                    boletaModel.setNamePlan(namePlan: plan.namePlan)
                    boletaModel.setDateVigency(dateVigency: plan.datePlanVigency)
                    let amount = formatToCountryCurrency(monto: plan.balancePlan)
                    boletaModel.setAmount(amount: amount)
                    
                    arrayBoletas.append(boletaModel)
                }
            }
        }
        
        for tv in arrayTv {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: tv.accountID)
            boletaModel.setNameService(nameService: tv.addressHome)
            boletaModel.setNamePlan(namePlan: tv.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: tv.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: tv.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: tv.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: tv.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        for internet in arrayInternet {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: internet.accountID)
            boletaModel.setNameService(nameService: internet.addressHome)
            boletaModel.setNamePlan(namePlan: internet.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: internet.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: internet.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: internet.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: internet.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        for todoClaro in arrayTodoClaro {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: todoClaro.accountID)
            boletaModel.setNameService(nameService: todoClaro.addressHome)
            boletaModel.setNamePlan(namePlan: todoClaro.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: todoClaro.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: todoClaro.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: todoClaro.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: todoClaro.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        for lineaFija in arrayLineaFija {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: lineaFija.accountID)
            boletaModel.setNameService(nameService: lineaFija.addressHome)
            boletaModel.setNamePlan(namePlan: lineaFija.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: lineaFija.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: lineaFija.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: lineaFija.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: lineaFija.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        return arrayBoletas
    }
    
    func filterArrayPlanCards() {
        self.arrayPlanCards.removeAll()
        self.filterMovilAccount()
        self.filterTelevisionAccount()
        self.filterInternetAccount()
        self.filterTodoClaroAccount()
        self.filterLineaFijaAccount()
    }
    
    func getArrayPlanCard() -> [PlanCard] {
        return self.arrayPlanCards
    }
    
    //MARK: Home
    func filterHomeServiceDetail() {
        var hasMovilServicePospago: Bool = false
        var hasMovilServicePrepago: Bool = false
        var hasTVService: Bool = false
        var hasTodoClaro: Bool = false
        var hasInternetService: Bool = false
        var hasLineaFijaService: Bool = false
        let arrayData = self.getDataHome()
        
        for item in arrayData {
            switch item.typeAccount {
            case .MovilPospago:
                hasMovilServicePospago = true
                break
            case .MovilPrepago:
                hasMovilServicePrepago = true
                break
            case .Television:
                hasTVService = true
                break
            case .TodoClaro:
                hasTodoClaro = true
                break
            case .Internet:
                hasInternetService = true
                break
            case .LineaFija:
                hasLineaFijaService = true
            default:
                break
            }
        }
        
        if hasMovilServicePospago {
            let homeItem = HomeServiceDetailModel()
            homeItem.setNameService(nameService: "Móvil")
            homeItem.setAmount(amount: self.getTotalAmountMovil())
            homeItem.setTypeAccount(typeAccount: .MovilPospago)
            self.arrayHomeService.append(homeItem)
        }
        
        if hasMovilServicePrepago {
            let homeItem = HomeServiceDetailModel()
            homeItem.setNameService(nameService: "Móvil")
            homeItem.setAmount(amount: self.getTotalAmountMovil())
            homeItem.setTypeAccount(typeAccount: .MovilPrepago)
            self.arrayHomeService.append(homeItem)
        }
        
        if hasTVService {
            let homeItem = HomeServiceDetailModel()
            homeItem.setNameService(nameService: "Televisión")
            homeItem.setAmount(amount: self.getTotalAmountTV())
            homeItem.setTypeAccount(typeAccount: .Television)
            self.arrayHomeService.append(homeItem)
        }
        
        if hasInternetService {
            let homeItem = HomeServiceDetailModel()
            homeItem.setNameService(nameService: "Internet")
            homeItem.setAmount(amount: self.getTotalAmountInternet())
            homeItem.setTypeAccount(typeAccount: .Internet)
            self.arrayHomeService.append(homeItem)
        }
        
        if hasTodoClaro {
            let homeItem = HomeServiceDetailModel()
            homeItem.setNameService(nameService: "Todo Claro")
            homeItem.setAmount(amount: self.getTotalAmountTodoClaro())
            homeItem.setTypeAccount(typeAccount: .TodoClaro)
            self.arrayHomeService.append(homeItem)
        }
        
        if hasLineaFijaService {
            let homeItem = HomeServiceDetailModel()
            homeItem.setNameService(nameService: "Línea Fija")
            homeItem.setAmount(amount: self.getTotalAmountLineaFija())
            homeItem.setTypeAccount(typeAccount: .LineaFija)
            self.arrayHomeService.append(homeItem)
        }
    }
    
    func getHomeServiceData() -> [HomeServiceDetailModel] {
        return self.arrayHomeService
    }
    
    private func getDataHome() -> [TicketBoletaModel] {
        self.filterMovilAccount()
        self.filterTelevisionAccount()
        self.filterInternetAccount()
        self.filterTodoClaroAccount()
        self.filterLineaFijaAccount()
        let arrayMovil = self.getMovilData()
        let arrayTv = self.getTelevisionData()
        let arrayInternet = self.getInternetData()
        let arrayTodoClaro = self.getTodoClaroData()
        let arrayLineaFija = self.getLineaFijaData()
        var arrayBoletas: [TicketBoletaModel] = []
        
        //Realizar filtrado de la información
        for movil in arrayMovil {
            //if movil.typeAccount == .MovilPospago {
            for indexService in 0..<movil.arrayServices.count {
                
                let boletaModel = TicketBoletaModel()
                boletaModel.setAccountID(accountID: movil.accountID)
                boletaModel.setTypeAccount(typeAccount: movil.typeAccount)
                
                let service = movil.arrayServices[indexService]
                boletaModel.setNameService(nameService: service.nameService)
                boletaModel.setCuenta(cuenta: movil.accountID)
                boletaModel.setLineOfBussiness(lineOfBussiness: "3")
                
                let plan = movil.arrayPlans[indexService]
                boletaModel.setNamePlan(namePlan: plan.namePlan)
                boletaModel.setDateVigency(dateVigency: plan.datePlanVigency)
                let amount = formatToCountryCurrency(monto: plan.balancePlan)
                boletaModel.setAmount(amount: amount)
                
                arrayBoletas.append(boletaModel)
            }
            //}
        }
        
        for tv in arrayTv {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: tv.accountID)
            boletaModel.setNameService(nameService: tv.addressHome)
            boletaModel.setNamePlan(namePlan: tv.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: tv.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: tv.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: tv.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: tv.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        for internet in arrayInternet {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: internet.accountID)
            boletaModel.setNameService(nameService: internet.addressHome)
            boletaModel.setNamePlan(namePlan: internet.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: internet.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: internet.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: internet.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: internet.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        for todoClaro in arrayTodoClaro {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: todoClaro.accountID)
            boletaModel.setNameService(nameService: todoClaro.addressHome)
            boletaModel.setNamePlan(namePlan: todoClaro.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: todoClaro.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: todoClaro.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: todoClaro.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: todoClaro.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        for lineaFija in arrayLineaFija {
            let boletaModel = TicketBoletaModel()
            boletaModel.setAccountID(accountID: lineaFija.accountID)
            boletaModel.setNameService(nameService: lineaFija.addressHome)
            boletaModel.setNamePlan(namePlan: lineaFija.planDetail.namePlan)
            boletaModel.setDateVigency(dateVigency: lineaFija.planDetail.datePlanVigency)
            let amount = formatToCountryCurrency(monto: lineaFija.planDetail.balancePlan)
            boletaModel.setAmount(amount: amount)
            boletaModel.setTypeAccount(typeAccount: lineaFija.typeAccount)
            boletaModel.setLineOfBussiness(lineOfBussiness: "1")
            boletaModel.setCuenta(cuenta: lineaFija.accountID)
            
            arrayBoletas.append(boletaModel)
        }
        
        return arrayBoletas
    }
    
    private func getTotalAmountMovil() -> Float {
        var hasPrepago = false
        var hasPospago = false
        var sumarPrepago = false
        
        let arraySummary = self.getSummaryAccount()
        
        for summary in arraySummary {
            if summary.typeAccount == .MovilPrepago {
                hasPrepago = true
            }
            if summary.typeAccount == .MovilPospago {
                hasPospago = true
            }
        }
        
        if hasPrepago && !hasPospago {
            sumarPrepago = true
        }
        
        //Realizar la suma solo de las cuentas de tipo móvil
        var totalAmount: Float = 0.0
        for summary in arraySummary {
            let amountTmp = summary.amount
            if summary.typeAccount == .MovilPospago || sumarPrepago {
                totalAmount += amountTmp
            }
        }
        
        return totalAmount
    }
    
    private func getTotalAmountTV() -> Float {
        let arrayTV = self.getTelevisionData()
        
        var totalAmount: Float = 0.0
        
        for tvItem in arrayTV {
            totalAmount += tvItem.planDetail.balancePlan
        }
        
        return totalAmount
    }
    
    private func getTotalAmountInternet() -> Float {
        let arrayInternet = self.getInternetData()
        
        var totalAmount: Float = 0.0
        
        for internetItem in arrayInternet {
            totalAmount += internetItem.planDetail.balancePlan
        }
        
        return totalAmount
    }
    
    private func getTotalAmountTodoClaro() -> Float {
        let arrayTodoClaro = self.getTodoClaroData()
        
        var totalAmount: Float = 0.0
        
        for todoClaroItem in arrayTodoClaro {
            totalAmount += todoClaroItem.planDetail.balancePlan
        }
        
        return totalAmount
    }
    
    private func getTotalAmountLineaFija() -> Float {
        let arrayTV = self.getLineaFijaData()
        
        var totalAmount: Float = 0.0
        
        for tvItem in arrayTV {
            totalAmount += tvItem.planDetail.balancePlan
        }
        
        return totalAmount
    }
    
    //MARK: Generale methods
    /// Funcion para obtener el saldo actual del plan y la fecha de vigencia
    func getTotalBalanceAccount(detailPlan: DetailPlan?) -> (Float, String) {
        var balance: Float = 0.0
        var date: String = ""
        if let bi = detailPlan?.retrieveBillDetailsResponse?.billItem {
            for bill in bi {
                if bill.descriptionType == "3" {
                    balance = NSString(format: "%@", bill.amountFormat!.digitsOnly).floatValue
                    let myDate = convertStringToDateO(stringDate: detailPlan?.retrieveBillDetailsResponse?.dueDate ?? "")
                    date = getFullStringDate(date: myDate)
                }
            }
        }
        
        return (balance, date)
    }
    
    func getDetailPlanData(pl: [PlanLine]) -> [(String, String)]{
        var arrayServices: [(String, String)] = []
        for planLines in pl {
            let title = planLines.featureCategory ?? ""
            let quantity = planLines.usageLimit?.quantity ?? "sin información"
            let unit = planLines.usageLimit?.unit?.uppercased() ?? ""
            var desc = ""
            if quantity != "sin información" {
                let quantityRound = NSString(format: "%@", quantity)
                let tmp2 = truncf(quantityRound.floatValue)
                desc = NSString(format:"%.0f %@", tmp2, unit) as String
            }else {
                desc = quantity
            }
            if quantity == "-1" {
                desc = "ILIMITADO"
            }
            if quantity == "-3" {
                desc = "LIBRES"
            }
            let detail = (title, desc)
            arrayServices.append(detail)
        }
        return arrayServices
    }
    
    private func setDataPlanCards(account: ServiceAccount) -> PlanCard {
        let planCard = PlanCard();
        planCard.retrieveBillDetailsResponse = account.detailServices?.detailPlan?.first?.retrieveBillDetailsResponse;
        planCard.plan = account.detail?.accountDetails?.plan?.first;
        //        planCard.tabName = tabNames;
        planCard.lineOfBusiness = account.account?.lineOfBusiness
        planCard.accountId = account.account?.accountId
        planCard.serviceId = account.detailServices?.associatedService?.first?.serviceID
        var serviceTypeTmp = account.detailServices?.associatedService?.first?.serviceType
        if account.isTodoClaro() {
            serviceTypeTmp = "6"
        }
        planCard.serviceType = serviceTypeTmp//account.detailServices?.associatedService?.first?.serviceType
        planCard.featureUsage = account.detailServices?.detailPlan?.first?.retrieveConsumptionDetailInformation?.serviceUsage?.first?.serviceFeatureUsage?.first?.featureUsage
        planCard.accountDetail = account.detail?.accountDetails
        planCard.serviceFeatureUsage = account.detailServices?.detailPlan?.first?.retrieveConsumptionDetailInformation?.serviceUsage?.first?.serviceFeatureUsage?.first
        
        return planCard
    }
    
    func filterMovilPrepaidAccount() {
        self.arrayMovilData.removeAll()
        for indexAccount in 0 ..< self.arrayServices.count {
            let account = self.arrayServices[indexAccount]
            if ("2" != account.account?.lineOfBusiness) {
                continue
            }
            
            let totalServices = account.detailServices?.associatedService?.count ?? 0;
            for idxService in 0 ..< totalServices {
                // Crear modelo de tipo Movil
                let movilModel = CardsMovilModel()
                movilModel.setAccountID(accountID: (account.account?.accountId)!)
                movilModel.setLOB(lob: account.account?.lineOfBusiness ?? "")
                movilModel.setTypeAccount(lob: (account.account?.lineOfBusiness)!)
                
                //Recuperar informacion del servicio asociado
                let serviceCard = AssociatedServicesCard()
                let associateService: AssociatedService = (account.detailServices?.associatedService![idxService])!
                let nameService: String = associateService.serviceID!
                serviceCard.setNameService(nameService: nameService)
                serviceCard.setIndexService(index: idxService)
                
                if account.detailServices!.detailPlan!.count > idxService{
                    if let arrayServiceUsage = account.detailServices?.detailPlan![safe: idxService]?.retrieveConsumptionDetailInformation?.serviceUsage {
                        //Obtener el tipo de cuenta, Prepago, Pospago o cuenta exacta
                        let typeAccountMovil = account.detailServices?.detailPlan![safe: idxService]?.retrieveConsumptionDetailInformation?.serviceBusinessType ?? ""
                        //                        movilModel.setTypeAccount(lob: typeAccountMovil)//(account.account?.lineOfBusiness)!)
                        //                        let typeAccountMovil = "PRE"
                        
                        
                        if (arrayServiceUsage.count != 0){
                            for serviceUsage in arrayServiceUsage {
                                //                            let dataGraphic = DataGraphicCard()
                                for serviceFeature in (serviceUsage.serviceFeatureUsage)! {
                                    
                                    let dataGraphic = DataGraphicCard()
                                    print("ENCONTRAMOS LA INFORMACIÓN A MOSTRAR")
                                    //Obtener el limite del plan
                                    var serviceType = ""
                                    var usageLimit: Float = 0.0
                                    var unitUsage = ""
                                    var consumoUser: Float = 0.0
                                    var consumoUserUnit = "Disponibles"
                                    let stringToDate = convertStringToDate2(stringDate: serviceUsage.serviceUsagePeriod?.endDate ?? "")
                                    let dateValue = getStringDate(date: stringToDate)
                                    
                                    let total = Int(serviceFeature.serviceFeatureUsageLimit?.quantity ?? 0)
                                    
                                    switch total {
                                    case -1,-3: //Libres y Ilimitados
                                        serviceType = serviceFeature.serviceFeatureType ?? ""
                                        usageLimit = Float(serviceFeature.featureUsage?.quantity ?? 0.0)
                                        unitUsage = serviceFeature.featureUsage?.unit ?? ""
                                        consumoUser = Float(serviceFeature.featureUsage?.quantity ?? 0.0)
                                        consumoUserUnit = serviceFeature.featureUsage?.unit ?? "Disponibles"
                                        break
                                    case 0:
                                        serviceType = serviceFeature.serviceFeatureType ?? ""
                                        usageLimit = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        unitUsage = serviceFeature.featureReminder?.unit ?? ""
                                        consumoUser = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        consumoUserUnit = serviceFeature.featureReminder?.unit ?? "Disponibles"
                                    default:
                                        serviceType = serviceFeature.serviceFeatureType ?? ""
                                        usageLimit = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        unitUsage = serviceFeature.featureReminder?.unit ?? ""
                                        consumoUser = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        consumoUserUnit = serviceFeature.featureReminder?.unit ?? "Disponibles"
                                        break
                                    }
                                    
                                    if(account.account?.lineOfBusiness == "2"){ // Prepago lob = 2
                                        let featureReminderQuantity = Float(serviceFeature.featureReminder?.quantity ?? 0.0)
                                        dataGraphic.setFeatureReminderQuantity(quantity: featureReminderQuantity)
                                    }
                                    //Identificar si es una cuenta con redes sociales, mediante serviceUsage->servideID
                                    let serviceIDRRSS = serviceUsage.serviceID ?? "0"
                                    if NSString(string: serviceIDRRSS).floatValue >= 7 {
                                        dataGraphic.setExistRRSS(exist: true)
                                        let RRSStext = serviceUsage.serviceType ?? ""
                                        let socialNetwork = self.setSocialNetwork(social: RRSStext)
                                        dataGraphic.setArraySocialNetwork(arraySocial: socialNetwork)
                                    }
                                    //Identificar si se debe mostrar el tercer botón
                                    let idSaldoSection = serviceUsage.serviceID ?? "0"
                                    if NSString(string: idSaldoSection).floatValue == 6{
                                        if account.account?.lineOfBusiness == "3" {
                                            if let billDetails = account.detailServices?.detailPlan![safe: idxService]?.retrieveBillDetailsResponse {
                                                movilModel.setShowSaldoSection(showSection: true)
                                                let (saldoMaestro, dateMaestro) = self.getSaldoMaestro(billDetails: billDetails)
                                                //Obtener el saldo promocional
                                                let saldoPromocional = serviceFeature.featureReminder?.quantity ?? 0.0
                                                let dataSaldos = SaldoPromoMaster(saldoMaestro: saldoMaestro, saldoPromocional: "\(saldoPromocional)", dateMaestro: dateMaestro, datePromocional: dateValue)
                                                movilModel.setDataSaldos(dataSaldo: dataSaldos)
                                            }
                                        }
                                    }
                                    
                                    //No se debe mostrar la información de Saldo promocional en dataGraphic
                                    if NSString(string: idSaldoSection).floatValue != 6 {
                                        dataGraphic.setServiceFeatureType(service: serviceType)
                                        dataGraphic.setUsageLimit(usageLimit:"\(usageLimit)", usageLimitUnit: unitUsage)
                                        dataGraphic.setConsumingUser(consumingUser: "\(consumoUser)", consumingUserUnit: consumoUserUnit)
                                        dataGraphic.typeCard = total
                                        dataGraphic.setDateFinish(date: dateValue)
                                        dataGraphic.setServiceBusinessType(type: typeAccountMovil)
                                        
                                        movilModel.appendDataGraphic(data: dataGraphic)
                                    }
                                }
                                
                            }
                        }
                    }else{
                        
                    }
                }
                
                let namePlan: String = account.detail?.accountDetails?.plan?[idxService].planName ?? ""
                let planService = PlanDetailCard()
                planService.setNamePlan(namePlan: namePlan)
                
                //Recuperar información del detalle del plan
                if let plans = account.detail?.accountDetails?.plan {
                    let plan = plans[idxService]
                    guard let pl = plan.planLines else {
                        return //numberArrayBody;
                    }
                    if (pl.count > 0) {
                        let planLines = self.getDetailPlanData(pl: pl)
                        planService.setServiceDetail(detailPlan: planLines)
                    }
                }
                
                //Recuperar la información de los Bill items para obtener el monto total a pagar
                let detailPlan = account.detailServices?.detailPlan?[safe: idxService]
                let (balance, dateVigency) = self.getTotalBalanceAccount(detailPlan: detailPlan)
                planService.setBalancePlan(balance: balance, dateVigency: dateVigency)
                
                let descriptionPlan = (account.detail?.accountDetails?.plan?[idxService].planDescription as? String) ?? ""
                planService.setPlanDescription(descriptionPlan: descriptionPlan)
                
                movilModel.appendPlan(plan: planService)
                movilModel.appendService(service: serviceCard)
                
                //Agregar informacion del ciclo de factura
                if account.retrieveCycleInformation != nil {
                    if account.retrieveCycleInformation?.rechargeHistory != nil {
                        let cycleInfo = CycleInformation()
                        let stringStartDate = convertStringToDate2(stringDate: account.retrieveCycleInformation?.rechargeHistory?.first?.startDate ?? "")
                        let startDate = getStringDate(date: stringStartDate)
                        
                        let stringEndDate = convertStringToDate2(stringDate: account.retrieveCycleInformation?.rechargeHistory?.first?.endDate ?? "")
                        let endDate = getStringDate(date: stringEndDate)
                        
                        let daysPending = account.retrieveCycleInformation?.rechargeHistory?.first?.remainingDays ?? 0
                        
                        cycleInfo.setStartDate(date: startDate)
                        cycleInfo.setEndDate(date: endDate)
                        cycleInfo.setRemainingDays(days: daysPending)
                        
                        movilModel.setCycleInformation(cycleData: cycleInfo)
                    }
                }
                
                self.arrayMovilData.append(movilModel)
                
                //Información de boletas
                /*let planCardBoleta = self.setDataPlanCards(account: account)
                 self.arrayPlanCards.append(planCardBoleta)*/
            }
            let planCardBoleta = self.setDataPlanCards(account: account)
            self.arrayPlanCards.append(planCardBoleta)
        }
        print("EXISTEN \(self.arrayMovilData.count) CUENTAS MOVIL PREPAGO")
    }
}
*/

