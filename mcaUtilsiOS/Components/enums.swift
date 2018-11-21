//
//  enums.swift
//  mcaUtilsiOS
//
//  Created by Roberto on 11/20/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import Foundation

/// Tipo de NavigationBar
enum navType {
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

enum ubicationRadioButton {
    case left
    case right
}

enum typeOptions: Int {
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
enum TypeCardView : String {
    case None
    case Resumen
    case Móvil
    case Internet
    case Televisión
    case TodoClaro = "Todo Claro"
    case Teléfono
    case Suscripción
}

/// Enumerado Tipo de cuenta
enum TypeAccounts {
    case Postpago
    case Prepago
    case PostpagoAndPrepago
    case None
}

enum TypeSocialNetwork {
    case Facebook// 1
    case Twitter // 2
    case Whatsapp // 3
    case Instagram // 4
    case ClaroMusica // 5
    case Snapchat // 6
    case Waze // 7
    case ColaboraCloud// 8
    case Gmail // 9
    case Hotmail // 10
    case Yahoo // 11
    case facebookMessenger // 12
}

/// Colocar el borde dependiendo el lado elegido
enum Sides {
    case left
    case right
    case top
    case bottom
}

struct SideView {
    var Left: Bool
    var Right: Bool
    var Top: Bool
    var Bottom: Bool
}

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

enum SupportSectionType {
    case ReportError
    case Suggestion
    case SendEmail
    case AboutClaro
    case AttentionCenter
    case SucursalVirtual
    case SocialNetwork
}

/// Enumerador para diferenciar el "Landing" de las otras páginas
enum WalktrhoughType : Int {
    case landing = 0
    case steps = 1
}

/// Enumerado con las fuentes usadas en MiClaro
enum RobotoFontName : String {
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

enum TypeLineOfBussines: String {
    case Fijo = "1"
    case Prepago = "2"
    case Postpago = "3"
}

/// Enumerado del AppVersion
enum AppVersionStatus {
    case Nueva
    case Actualizacion
    case SinCambio
}

/// Enumerado de DigitalBorn
enum actionTypeDigitalBorn {
    case Normal
    case PrimerLogin
    case RecuperarPass
}

/// Enumerado del típo de card
enum cardType {
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

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}
