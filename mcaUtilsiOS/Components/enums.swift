//
//  enums.swift
//  mcaUtilsiOS
//
//  Created by Roberto on 11/20/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import Foundation

/// Tipo de NavigationBar
public enum navType {
    case login
    case register
    case onlinePayment
    case reloadBalance
    case terms
    case home
    case recoveryPassword
    case addPrePaid
    case addPrePaidCode
    case support
    case editPerfil
    case supportLogged
    case supportNoLogged
    case supportSectionReportError
    case supportSectionSuggestion
    case supportSectionSendEmail
    case supportSectionAboutme
    case menuBoleta
    case boleta
    case sendTicket
    case supportSectionCenterAttention
    case serviceAccount
    case requestChangePlan
    case successChangePlan
    case hiring
    case hiringWeb
    case digitalBorn
    case completeRegister
    case sucursalVirtual
    case centrosAyuda
    case servicioTecnico
    case citasCAC
    case citasAgendCAC
    case horasCAC
    case packages
    case packagesDetail
}

/// Tipo de NavigationBar
public enum ButtonNavType {
    case None
    case IconBack
    case IconMenu
    case IconBackHiden
}

public enum ubicationRadioButton {
    case left
    case right
}

public enum typeOptions: Int {
    case Account = 1
    case categories
}

public enum ServiceType : Int {
    case Resumen
    case Movil = 1
    case Otros = 2
    case Telefono = 3
    case TV = 4
    case Internet = 5
    case TodoClaro
}

/// Enumerado de Típo de card
public enum TypeCardView : String {
    case None
    case Summary = "Resumen"
    case Mobile = "Móvil"
    case Internet
    case Television = "Televisión"
    case TodoClaro = "Todo Claro"
    case Telephone = "Teléfono"
    case Subscription = "Suscripciones"
}

/// Enumerado Tipo de cuenta
public enum TypeAccounts {
    case Postpago
    case Prepago
    case PostpagoAndPrepago
    case None
}

/// Colocar el borde dependiendo el lado elegido
public enum Sides {
    case left
    case right
    case top
    case bottom
}

public struct SideView{
    
    public var Left: Bool
    public var Right: Bool
    public var Top: Bool
    public var Bottom: Bool
    
    public init(Left: Bool, Right: Bool, Top: Bool, Bottom: Bool) {
        self.Left = Left
        self.Right = Right
        self.Top = Top
        self.Bottom = Bottom
    }
    
}

public enum SupportSectionType {
    case ReportError
    case Suggestion
    case SendEmail
    case AboutClaro
    case AttentionCenter
    case SucursalVirtual
    case SocialNetwork
}

/// Enumerador para diferenciar el "Landing" de las otras páginas
public enum WalktrhoughType : Int {
    case landing = 0
    case steps = 1
}

/// Enumerado con las fuentes usadas en MiClaro
public enum RobotoFontName : String {
    case RobotoRegular = "Roboto-Regular"
    case RobotoLight = "Roboto-Light"
    case RobotoMedium = "Roboto-Medium"
    case RobotoBlack = "Roboto-Black"
    case RobotoCondensedItalic = "Roboto-CondensedItalic"
    case RobotoBoldCondensedItalic = "Roboto-BoldCondensedItalic"
    case RobotoBoldItalic = "Roboto-BoldItalic"
    case RobotoLightItalic = "Roboto-LightItalic"
    case RobotoThin = "Roboto-Thin"
    case RobotoMediumItalic = "Roboto-MediumItalic"
    case RobotoCondensed = "Roboto-Condensed"
    case RobotoBold = "Roboto-Bold"
    case RobotoBlackItalic = "Roboto-BlackItalic"
    case RobotoItalic = "Roboto-Italic"
    case RobotoThinItalic = "Roboto-ThinItalic"
    case RobotoBoldCondensed = "Roboto-BoldCondensed"
}

public enum TypeLineOfBussines: String {
    case Fixed = "1"
    case Prepaid = "2"
    case Postpaid = "3"
}

/// Enumerado del AppVersion
public enum AppVersionStatus {
    case Nueva
    case Actualizacion
    case SinCambio
}

/// Enumerado de DigitalBorn
public enum actionTypeDigitalBorn {
    case Normal
    case PrimerLogin
    case RecuperarPass
}

/// Enumerado del típo de card
public enum cardType {
    case Resumen
    case Móvil
    case Internet
    case Teléfono
    case Televisión
    var name: String {
        get {
            return String(describing: self)
        }
    }
}

public enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
