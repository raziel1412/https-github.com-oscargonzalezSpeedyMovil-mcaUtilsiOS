//
//  GeneralUtils.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 7/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import Foundation
import UIKit
import mcaManageriOS


let UNAVAILABLE_TEXT = "Texto no disponible"

/// Variable que contiene todos los tabs que son usadas en MiClaro
var allTabsArray = ["Resumen", "Móvil", "Internet", "Teléfono", "Televisión", "Todo Claro", "Suscripciones"]

/// Estructura que verifica si se está usando un simulador
struct checkForSimulator {
    
    static func isRuningSimulator() -> Bool {
    
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    
    }
}
/// Url contiene el CountryList
struct urlCountryList{
    static func getContryUrl() -> String{
        let url = "https://firebasestorage.googleapis.com/v0/b/mi-claro-955bc.appspot.com/o/countriesList.json?alt=media&token=12ae69f5-8cbb-4922-a576-a68cb89e3558"
        return url
    }
}
/// Url base usada para la contrucción de algunas URL
struct baseUrl {
    static func getBaseUrl(countryCode: String) -> String {
//        let url = String.init(format: "https://firebasestorage.googleapis.com/v0/b/mi-claro-955bc.appspot.com/o/configMiClaro_%@.json?alt=media&token=7f662957-5ca3-43de-83a8-521e676890be", countryCode.lowercased());
        let url = String.init(format: "http://contenido.speedymovil.com:8007/contenedor/MiClaroTemporal/configMiClaro_%@.json", countryCode.lowercased());
        return url
    }
}
/// Estructura que almacena los colores usados en MiClaro
struct institutionalColors {
    static let claroBlueColor = UIColor(rgb: 0x1F97AE, alphaVal: 1)
    static let claroRedColor = UIColor(rgb: 0xEF3829, alphaVal: 1)
    static let claroGrayNavColor = UIColor(rgb: 0xF5F5F5, alphaVal: 1)
    static let claroLightGrayColor = UIColor(rgb: 0xAFAFAF, alphaVal: 1)
    static let claroSelectionGrayColor = UIColor(rgb: 0xF7F7F7, alphaVal: 1)
    static let claroToolBarColor = UIColor(rgb: 0xF0F0F0, alphaVal: 1)
    static let claroTextColor = UIColor(rgb: 0x666666, alphaVal: 1)
    static let claroNavTitleColor = UIColor(rgb: 0xFFFFFF, alphaVal: 1)
    static let claroTitleColor = UIColor(rgb: 0x333333, alphaVal: 1)
    static let claroWhiteColor = UIColor(rgb: 0xffffff, alphaVal: 1);
    static let claroBlackColor = UIColor(rgb: 0x000000, alphaVal: 1);
    static let claroPerlColor = UIColor(rgb: 0xFAFAFA, alphaVal: 1);
    static let claroPlecaColor = UIColor(rgb: 0xFAFAFA, alphaVal: 1);
    static let claroOrangeColor = UIColor(rgb: 0xF5842B, alphaVal: 1);
    static let claroLightGrayColorExpandView = UIColor(rgb: 0xF2F2F2, alphaVal: 1);
    static let claroRedColorDisabled = UIColor(rgb: 0xF69A93, alphaVal: 1)
    static let claroTextAlertBodyColor = UIColor(rgb: 0x222222, alphaVal: 1)
    static let claroButtonDetailGraphicSelect = UIColor(rgb: 0xF4F4F4, alphaVal: 1)

    static let claroMenuDarkGray = UIColor(rgb: 0x383838, alphaVal: 1);
    static let claroMenuLightGray = UIColor(rgb: 0x6A6A6A, alphaVal: 1);
    static let claroMenuChildGray = UIColor(rgb: 0x7D7D7D, alphaVal: 1);
    static let claroMenuElementSeparatorGray = UIColor(rgb: 0x979797, alphaVal: 1);
    static let claroBorderBalanceView = UIColor(rgb: 0xF1F4FF , alphaVal: 1)
}
/// Estructura con los elementos de validación
struct passwordValidation {
     static var between6and12Characters = NSLocalizedString("lengthValidation", comment: "")
     static var atLeastOneNumber = NSLocalizedString("numbersValidation", comment: "")
     static var atLeastOneLetter = NSLocalizedString("charsValidation", comment: "")
     static var allowedSymbols = NSLocalizedString("symbolsValidation", comment: "")
}
/// Estructura con los identificadores de los cells
struct identifiers {
   static let genericHeader = "GenericHeaderCell"
   static let genericExpandable = "GenericExpandableCell"
   static let cardCellView = "CardCellView"
}
/// Estructura de la altura de las cards
struct cardHeights {
    static let genericHeaderResumeHeight: CGFloat = 280
    static let genericHeaderPrepaidHeight: CGFloat = 420
    static let genericHeaderPospaidHeight: CGFloat = 420
    static let genericHeaderInsideCellResumeHeight: CGFloat = 80
    static let genericHeaderInsideCellMobileHeight: CGFloat = 40
    static let genericBodyInsideCellHeight: CGFloat = 200

}



/// Función que ayuda a obtener la fecha en un formato
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
func getFullStringDate(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "dd/MMMM/yyyy"
    formatter.locale = Locale(identifier: "es_MX");
    formatter.monthSymbols = formatter.monthSymbols.map { $0.capitalized(with: formatter.locale) }
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a obtener la fecha en un formato
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
func getStringDate(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "dd/MM/yyyy"
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a obtener la fecha en un formato fecha y hora
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
func getStringDateTime(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "dd/MM/yyyy HH:mm"
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a obtener la fecha en un formato fecha y hora
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
func getStringDateTime2(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "YYYY-MM-dd"
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a convertir un string en una fecha
/// - parameter String: Fecha a formatear
/// - Returns Date : Fecha
func convertStringToDateO(stringDate : String) -> Date {
    if stringDate.count < 10 {
        return Date();
    }
    let index = stringDate.index(stringDate.startIndex, offsetBy: 10)
    let cad = stringDate.substring(to: index)
    var date : Date?;
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd";
    date = dateFormatter.date(from: cad)
    return date ?? Date();
}
/// Función que ayuda a convertir un string en una fecha con un formato
/// - parameter String: Fecha a formatear (yyyy-MM-dd'T'HH:mm:ss.SSSXXX)
/// - Returns Date : Fecha
func convertStringToDate(stringDate : String) -> Date{
    var date : Date?
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    date = dateFormatter.date(from: stringDate)
    if let _date = date{
        return _date
    }else{
        return Date()
    }
}

func convertStringToDate2(stringDate : String) -> Date{
    var date : Date?
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    //dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    date = dateFormatter.date(from: stringDate)
    if let _date = date{
        return _date
    }
    else{
        let aDate = convertStringToDateO(stringDate: stringDate)
        return aDate
    }
}

/// Función que da el formato a la moneda según el archivo de configuración del país seleccionado
/// - parameter monto: Float
/// - Returns String: Formateado
func formatToCountryCurrency(monto : Float) -> String {
    let monto_decimal = modf(monto).1;
    if monto_decimal > 0 {
        let strMonto = monto.description
        return formatToCountryCurrency(strMonto: strMonto);
    } else {
        let formatter = NumberFormatter();
        formatter.groupingSeparator = mcaManagerSession.getAmountSeparator()
        formatter.numberStyle = .decimal;
        let strMonto = formatter.string(from: NSNumber(value: monto)) ?? "0"
        return formatToCountryCurrency(strMonto: strMonto);
    }
}

/// Función que da el formato a la moneda según el archivo de configuración del país seleccionado
/// - parameter monto: String
/// - Returns String: Formateado
func formatToCountryCurrency(strMonto: String) -> String {
    let moneda = String(format: "%@ %@", mcaManagerSession.getGeneralConfig()?.country?.currency ?? "$", strMonto);
    return moneda;
}

/// Función que permite realizar una acción (llamar) sobre un ViewController
/// - parameter phoneNumber: String
/// - parameter currentVC: UIViewController
func callPhone(phoneNumber: String, currentVC: UIViewController ) {
    let application:UIApplication = UIApplication.shared
    if phoneNumber.contains("*") || phoneNumber.contains("#") {
        
        let accept = AlertAcceptOnly()
        accept.text = "Para recibir asistencia marque este número: \n\(phoneNumber)"
        accept.acceptTitle = "ACEPTAR"
        accept.icon = AlertIconType.IconoAlertaPregunta
        accept.onAcceptEvent = {
            print("Hidde alert")
        }
        
        NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name,
                                        object: accept);
        
    }else {
        if let phoneCallURL:URL = URL(string: "tel://\(phoneNumber)") {
            
            if (application.canOpenURL(phoneCallURL)) {
                
                if #available(iOS 10, *) {
                    UIApplication.shared.open(phoneCallURL)
                } else {
                    UIApplication.shared.openURL(phoneCallURL)
                }
            }
        }
    }
    
}
/// Función que ayuda a convertir un string en una fecha con un formato
/// - parameter String: Fecha a formatear
/// - Returns Date : Fecha
func convertShortStringDateToDate(stringDate : String) -> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = NSTimeZone(name: "America/Mexico_City")! as TimeZone
    dateFormatter.dateFormat = "yyyy-MM-dd"; // "dd-MM-yyyy"
    let my_date = dateFormatter.date(from: stringDate)
    return my_date;
}

/// Función que ayuda a convertir un Date en una fecha con un formato
/// - parameter Date: Fecha a formatear
/// - Returns String : Fecha
func getStringMonthDate(in_date : Date?) -> String{
    guard let my_date = in_date else {
        return "";
    }

    let currentLocale = Locale(identifier: "es_MX");
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "dd/MMMM/yyyy"
    formatter.locale = currentLocale;
    formatter.timeZone = NSTimeZone(name: "America/Mexico_City")! as TimeZone
    formatter.monthSymbols =  formatter.monthSymbols.map { $0.capitalized(with: currentLocale) }
    stringDate = formatter.string(from: my_date)
    return stringDate
}

///Conversion para tablePeriods
/// - parameter date: Date
/// - Returns String
func getStringMonthYear(date : Date) -> String{
  
    var stringDate = ""
    let formatter = DateFormatter()
    let currentLocale = Locale(identifier: "es_MX");
    formatter.dateFormat =  "MMMM yyyy"
    formatter.locale = currentLocale //Locale(identifier: "es_MX”)
    
    formatter.timeZone = NSTimeZone(name: "America/Mexico_City")! as TimeZone
    formatter.monthSymbols =  formatter.monthSymbols.map { $0.capitalized(with: currentLocale) }
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Restar fechas
func substractDaysDates(date1: String, date2: String) -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    if let someDate = dateFormatter.date(from: date1)
    {
        let dateTmp = dateFormatter.date(from: date2)
//        let now = Date()

        print("someDate is greater than now")
        //Obtenemos la diferencia de días
        let days = someDate.days(from: dateTmp!)
        return days
    }
    else
    {
        print("date string \"\(date1)\" is invalid")
        return 0
    }
}

/// Versión formaterada para impresión
/// - parameter showFullVersion : Bool
/// - Returns String
func getFormattedVersion(showFullVersion : Bool) -> String {
    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "";
    let currentBuildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "";
    let fullVersion = (true == showFullVersion ? String(format: "%@.%@", currentVersion, currentBuildNumber) : currentVersion);

    return fullVersion;
}
/// Versión formaterada del OS para impresión
/// - Returns String
func getVersionSO() -> Float {
    let modelPhone: NSString = UIDevice.current.systemVersion as NSString
    print("MODEL PHONE \(modelPhone.floatValue)")
    
    return modelPhone.floatValue
}

/// Extension UINavigationController
extension UINavigationController {
    /// Reemplaza el TopViewController con un controller nuevo
    /// - parameter viewController: UIViewController
    /// - parameter animated : Bool
    func replaceTopViewController(with viewController: UIViewController, animated: Bool) {
        var vcs = viewControllers
        vcs[vcs.count - 1] = viewController
        setViewControllers(vcs, animated: animated)
    }
}

/// Extensión UITextField
extension UITextField {
    /// Perform action
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(select(_:)) || action == #selector(selectAll(_:)) || action == #selector(cut(_:)) {
            return true
        }
        return false
    }
}
/// Extensión Array
extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

// Methods for update alert
func isUpdateAvailable() {
    DispatchQueue.global().async {
        do {
            let conf = mcaManagerSession.getGeneralConfig()
            let updateAvailable = conf?.newUpdateAvailable?.updateAvailable ?? false
            
            if updateAvailable && mcaManagerSession.getCanUpdateApp() {
                let update = try isUpdateAppAvailable()
                mcaManagerSession.setIsUpdateAppAvailable(isUpdateAppAvailable: update)
                showUpdateAlertView()
            }
            
        } catch {
            print(error)
        }
    }
}

func showUpdateAlertView() {
    
    if mcaManagerSession.getIsUpdateAppAvailable() {
        let alert = AlertAcceptOnly()
        NotificationCenter.default.post(name: Observers.ObserverList.UpdateAppAlert.name, object: alert);
    }
}

func isUpdateAppAvailable() throws -> Bool {
    let country = mcaManagerSession.getCountry()?.lowercased() ?? ""
    guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "http://itunes.apple.com/\(country)/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
    
    let data = try Data(contentsOf: url)
    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
        throw VersionError.invalidResponse
    }
    if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
        return version != currentVersion
    }
    throw VersionError.invalidResponse
}


func ShowAlertAcceptOnly(title: String = "", text: String = "", icon: AlertIconType, cancelBtnColor: UIColor? = nil, cancelButtonName: String = "", acceptTitle: String = "", acceptBtnColor: UIColor? = nil, buttonName: String = "", onAccept: @escaping() -> Void) {
    let alert = AlertAcceptOnly();
    alert.title = title
    alert.icon = icon
    alert.onAcceptEvent = onAccept
    if title != "" {
        alert.title = title
    }
    if acceptTitle != "" {
        alert.acceptTitle = acceptTitle
    }
    if text != "" {
        alert.text = text
    }
    if acceptBtnColor != nil{
        alert.buttonColor = acceptBtnColor
    }
    if buttonName != "" {
        alert.buttonName = buttonName
    }
    alert.cancelButtonColor = cancelBtnColor
    alert.cancelButtonName = cancelButtonName
    
    NotificationCenter.default.post(name: Observers.ObserverList.AcceptOnlyAlert.name, object: alert)
}

