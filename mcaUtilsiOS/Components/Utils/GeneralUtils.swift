//
//  GeneralUtils.swift
//  MiClaro
//
//  Created by Mauricio Javier Perez Flores on 7/27/17.
//  Copyright © 2017 am. All rights reserved.
//

import Foundation
import UIKit
//import mcaManageriOS


public let UNAVAILABLE_TEXT = "Texto no disponible"

/// Variable que contiene todos los tabs que son usadas en MiClaro
public var allTabsArray = ["Resumen", "Móvil", "Internet", "Teléfono", "Televisión", "Todo Claro", "Suscripciones"]

/// Estructura que verifica si se está usando un simulador
public struct checkForSimulator {
    
    public static func isRuningSimulator() -> Bool {
    
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    
    }
}
/// Url contiene el CountryList
public struct urlCountryList{
    public static func getContryUrl() -> String{
        let url = "https://firebasestorage.googleapis.com/v0/b/mi-claro-955bc.appspot.com/o/countriesList.json?alt=media&token=12ae69f5-8cbb-4922-a576-a68cb89e3558"
        return url
    }
}
/// Url base usada para la contrucción de algunas URL
public struct baseUrl {
    public static func getBaseUrl(countryCode: String) -> String {
//        let url = String.init(format: "https://firebasestorage.googleapis.com/v0/b/mi-claro-955bc.appspot.com/o/configMiClaro_%@.json?alt=media&token=7f662957-5ca3-43de-83a8-521e676890be", countryCode.lowercased());
        let url = String.init(format: "http://contenido.speedymovil.com:8007/contenedor/MiClaroTemporal/configMiClaro_%@.json", countryCode.lowercased());
        return url
    }
}
/// Estructura que almacena los colores usados en MiClaro
public struct institutionalColors {
    public static let claroBlueColor = UIColor(rgb: 0x1F97AE, alphaVal: 1)
    public static let claroRedColor = UIColor(rgb: 0xEF3829, alphaVal: 1)
    public static let claroGrayNavColor = UIColor(rgb: 0xF5F5F5, alphaVal: 1)
    public static let claroLightGrayColor = UIColor(rgb: 0xAFAFAF, alphaVal: 1)
    public static let claroSelectionGrayColor = UIColor(rgb: 0xF7F7F7, alphaVal: 1)
    public static let claroToolBarColor = UIColor(rgb: 0xF0F0F0, alphaVal: 1)
    public static let claroTextColor = UIColor(rgb: 0x666666, alphaVal: 1)
    public static let claroNavTitleColor = UIColor(rgb: 0xFFFFFF, alphaVal: 1)
    public static let claroTitleColor = UIColor(rgb: 0x333333, alphaVal: 1)
    public static let claroWhiteColor = UIColor(rgb: 0xffffff, alphaVal: 1);
    public static let claroBlackColor = UIColor(rgb: 0x000000, alphaVal: 1);
    public static let claroPerlColor = UIColor(rgb: 0xFAFAFA, alphaVal: 1);
    public static let claroPlecaColor = UIColor(rgb: 0xFAFAFA, alphaVal: 1);
    public static let claroOrangeColor = UIColor(rgb: 0xF5842B, alphaVal: 1);
    public static let claroLightGrayColorExpandView = UIColor(rgb: 0xF2F2F2, alphaVal: 1);
    public static let claroRedColorDisabled = UIColor(rgb: 0xF69A93, alphaVal: 1)
    public static let claroTextAlertBodyColor = UIColor(rgb: 0x222222, alphaVal: 1)
    public static let claroButtonDetailGraphicSelect = UIColor(rgb: 0xF4F4F4, alphaVal: 1)

    public static let claroMenuDarkGray = UIColor(rgb: 0x383838, alphaVal: 1);
    public static let claroMenuLightGray = UIColor(rgb: 0x6A6A6A, alphaVal: 1);
    public static let claroMenuChildGray = UIColor(rgb: 0x7D7D7D, alphaVal: 1);
    public static let claroMenuElementSeparatorGray = UIColor(rgb: 0x979797, alphaVal: 1);
    public static let claroBorderBalanceView = UIColor(rgb: 0xF1F4FF , alphaVal: 1)
}
/// Estructura con los elementos de validación
public struct passwordValidation {
     public static var between6and12Characters = NSLocalizedString("lengthValidation", comment: "")
     public static var atLeastOneNumber = NSLocalizedString("numbersValidation", comment: "")
     public static var atLeastOneLetter = NSLocalizedString("charsValidation", comment: "")
     public static var allowedSymbols = NSLocalizedString("symbolsValidation", comment: "")
}
/// Estructura con los identificadores de los cells
public struct identifiers {
   public static let genericHeader = "GenericHeaderCell"
   public static let genericExpandable = "GenericExpandableCell"
   public static let cardCellView = "CardCellView"
}
/// Estructura de la altura de las cards
public struct cardHeights {
    public static let genericHeaderResumeHeight: CGFloat = 280
    public static let genericHeaderPrepaidHeight: CGFloat = 420
    public static let genericHeaderPospaidHeight: CGFloat = 420
    public static let genericHeaderInsideCellResumeHeight: CGFloat = 80
    public static let genericHeaderInsideCellMobileHeight: CGFloat = 40
    public static let genericBodyInsideCellHeight: CGFloat = 200

}



/// Función que ayuda a obtener la fecha en un formato
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
public func getFullStringDate(date : Date) -> String{
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
public func getStringDate(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "dd/MM/yyyy"
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a obtener la fecha en un formato fecha y hora
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
public func getStringDateTime(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "dd/MM/yyyy HH:mm"
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a obtener la fecha en un formato fecha y hora
/// - parameter date: Date Fecha a formatear
/// - Returns String : Fecha formateada
public func getStringDateTime2(date : Date) -> String{
    var stringDate = ""
    let formatter = DateFormatter()
    formatter.dateFormat =  "YYYY-MM-dd"
    stringDate = formatter.string(from: date)
    return stringDate
}

/// Función que ayuda a convertir un string en una fecha
/// - parameter String: Fecha a formatear
/// - Returns Date : Fecha
public func convertStringToDateO(stringDate : String) -> Date {
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
public func convertStringToDate(stringDate : String) -> Date{
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

public func convertStringToDate2(stringDate : String) -> Date{
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
/// - parameter amountSeparator (SessionSingleton.sharedInstance.getAmountSeparator())
/// - parameter countryCurrency (SessionSingleton.sharedInstance.getGeneralConfig()?.country?.currency ?? "$")
/// - Returns String: Formateado
public func formatToCountryCurrency(monto : Float, amountSeparator: String, countryCurrency: String) -> String {
    let monto_decimal = modf(monto).1
    if monto_decimal > 0 {
        let strMonto = monto.description
        return formatToCountryCurrency(strMonto: strMonto, countryCurrency: countryCurrency)
    } else {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = amountSeparator
        formatter.numberStyle = .decimal
        let strMonto = formatter.string(from: NSNumber(value: monto)) ?? "0"
        return formatToCountryCurrency(strMonto: strMonto, countryCurrency: countryCurrency)
    }
}

/// Función que da el formato a la moneda según el archivo de configuración del país seleccionado
/// - parameter monto: String
/// - parameter countryCurrency (SessionSingleton.sharedInstance.getGeneralConfig()?.country?.currency ?? "$")
/// - Returns String: Formateado
public func formatToCountryCurrency(strMonto: String, countryCurrency: String) -> String {
    let moneda = String(format: "%@ %@", countryCurrency, strMonto);
    return moneda;
}

/// Función que permite realizar una acción (llamar) sobre un ViewController
/// - parameter phoneNumber: String
/// - parameter currentVC: UIViewController
public func callPhone(phoneNumber: String, currentVC: UIViewController ) {
    let application:UIApplication = UIApplication.shared
    if phoneNumber.contains("*") || phoneNumber.contains("#") {
        
        let accept = AlertAcceptOnly()
        accept.text = "Para recibir asistencia marque este número: \n\(phoneNumber)"
        accept.acceptTitle = "ACEPTAR"
        accept.icon = AlertIconType.IconoAlertaPregunta
        accept.onAcceptEvent = {
            print("Hidde alert")
        }
        
        Observers.AcceptOnlyAlert(info: accept)
        
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
public func convertShortStringDateToDate(stringDate : String) -> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = NSTimeZone(name: "America/Mexico_City")! as TimeZone
    dateFormatter.dateFormat = "yyyy-MM-dd"; // "dd-MM-yyyy"
    let my_date = dateFormatter.date(from: stringDate)
    return my_date;
}

/// Función que ayuda a convertir un Date en una fecha con un formato
/// - parameter Date: Fecha a formatear
/// - Returns String : Fecha
public func getStringMonthDate(in_date : Date?) -> String{
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
public func getStringMonthYear(date : Date) -> String{
  
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
public func substractDaysDates(date1: String, date2: String) -> Int {
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
public func getFormattedVersion(showFullVersion : Bool) -> String {
    let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "";
    let currentBuildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "";
    let fullVersion = (true == showFullVersion ? String(format: "%@.%@", currentVersion, currentBuildNumber) : currentVersion);

    return fullVersion;
}
/// Versión formaterada del OS para impresión
/// - Returns String
public func getVersionSO() -> Float {
    let modelPhone: NSString = UIDevice.current.systemVersion as NSString
    print("MODEL PHONE \(modelPhone.floatValue)")
    
    return modelPhone.floatValue
}

/// Extension UINavigationController
public extension UINavigationController {
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
public extension UITextField {
    /// Perform action
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(select(_:)) || action == #selector(selectAll(_:)) || action == #selector(cut(_:)) {
            return true
        }
        return false
    }
}
/// Extensión Array
public extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

func resizeImageP(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

func checkImageExistsP(fileName: String) -> Bool{
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = URL(fileURLWithPath: path)
    
    let filePath = url.appendingPathComponent(fileName).path
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath) {
        print("FILE AVAILABLE")
        return true
    } else {
        print("FILE NOT AVAILABLE")
    }
    return false
}
func drawViewUnderLineP(generalView: UIView, topObject: UIView, whereSubview: UIView, color: UIColor?, width: CGFloat?, height: CGFloat?, proportion: CGFloat?) -> UIView{
    ///Linea con UIView
    let viewLinear = UIView()
    ///Proporción
    let lProportion :CGFloat = proportion != nil ? proportion! : 0.45
    let contraProportion = 1.0 - lProportion
    let posXViewLinear = (generalView.frame.width * contraProportion / 2)
    let posYViewLinear = topObject.frame.maxY + 8.0
    viewLinear.backgroundColor = color != nil ? color : .lightGray
    viewLinear.frame = CGRect(x: posXViewLinear, y:posYViewLinear, width: topObject.bounds.width * lProportion, height: 2)
    whereSubview.addSubview(viewLinear)
    return viewLinear
}


