//
//  StringExtension.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 02/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Foundation
import mcaManageriOS

/// Extensión Strings
extension String {
    /// Función que retorna un rango de un String
    /// - parameter range: Range<Index>
    /// - Returns : NSRange
    func nsRange(from range: Range<Index>) -> NSRange {
        let lower = UTF16View.Index(range.lowerBound, within: utf16)!;
        let upper = UTF16View.Index(range.upperBound, within: utf16)!;
        return NSRange(location: utf16.startIndex.distance(to: lower), length: lower.distance(to: upper))
    }
    
    /// Función que determina si un email es válido
    /// - Returns : Bool
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    /// Función que determina si un email es válido
    /// - Returns : Bool
    func isValidEmailOption2() -> Bool {
        guard !self.lowercased().hasPrefix("mailto:") else { return false }
        guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        let matches = emailDetector.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: self.count))
        guard matches.count == 1 else { return false }
        return matches[0].url?.scheme == "mailto"
    }
    /// Función que permite enmascarar RUT
    /// - Returns maskedString: String
    /// - Returns errorString : String?
    func enmascararRut() -> (maskedString : String, errorString : String?) {
        var maskRUT = self
        var error : String? = nil
        if let characterSpecial = mcaManagerSession.getGeneralConfig()?.country?.userProfileIdConfig?.separador, var posCharacter = (mcaManagerSession.getGeneralConfig()?.country?.userProfileIdConfig?.posicion), let max =  mcaManagerSession.getGeneralConfig()?.country?.userProfileIdConfig?.max , let min = mcaManagerSession.getGeneralConfig()?.country?.userProfileIdConfig?.min{
            posCharacter = posCharacter - 1
            if !self.contains(characterSpecial) {
                
                let lenghtID = self.count
                
                if lenghtID >=  (min - characterSpecial.count) && lenghtID <= (max - characterSpecial.count)  {
                    let firstIndex = lenghtID - posCharacter
                    
                    let firstText = self.substring(to: self.index(self.startIndex, offsetBy: firstIndex))
                    let secondText = self.substring(from: self.index(self.endIndex, offsetBy: -posCharacter))
                    
                    maskRUT = "\(firstText)\(characterSpecial)\(secondText)"
                    print("MASK RUT \(firstText)\(characterSpecial)\(secondText)")
                } else if lenghtID > 0 {
                    error = mcaManagerSession.getGeneralConfig()?.country?.userProfileIdConfig?.msgError
                } else {
                    error = mcaManagerSession.getGeneralConfig()?.translations?.data?.generales?.emptyField ?? "";
                }
            }
        }
        return (maskRUT, error)
        
        //        let IdentificationNumber = self.replacingOccurrences(of: "-", with: "");
        //        if let lastCharacter = IdentificationNumber.last {
        //            let droppedString = String(IdentificationNumber.dropLast(1))
        //            let newIdentificationNumber = "\(droppedString)" + "-" + "\(lastCharacter)"
        //            return newIdentificationNumber
        //        } else {
        //            return "";
        //        }
    }
    
    func maskPhone() -> String {
        let number = self
        if let unmaskedChars = mcaManagerSession.getGeneralConfig()?.pinMessageRules?.unmaskedCharactersForPhone {
            let conditionIndex = number.count - unmaskedChars
            var maskedPhone = String(number.enumerated().map{(index, element) -> Character in
                return index < conditionIndex ? "*" : element
            })
            if maskedPhone.count > 8 {
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 2)
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 6)
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 10)
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 12)
            }
            return maskedPhone
        }
        return number
    }
    
    //current string masked by
    
    func maskAsPhone() -> String {
            let conditionIndex = self.count - 4
            var maskedPhone = String(self.enumerated().map{(index, element) -> Character in
                return index < conditionIndex ? "*" : element
            })
            if maskedPhone.count > 8 {
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 2)
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 6)
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 10)
                maskedPhone.insert(string: " ", ind: maskedPhone.count - 12)
            }
            return maskedPhone
    }
    
    func maskAsEmail() -> String {
        
        
        let mail = self.split(separator: "@")
        print(mail)
        
        let conditionIndex = 2//mail[0].count - 2
        var maskedPhone = String(mail[0].enumerated().map{(index, element) -> Character in
            return index < conditionIndex ? element : "*"
        })
        if maskedPhone.count > 8 {
            maskedPhone.insert(string: " ", ind: maskedPhone.count - 2)
            maskedPhone.insert(string: " ", ind: maskedPhone.count - 6)
            maskedPhone.insert(string: " ", ind: maskedPhone.count - 10)
            maskedPhone.insert(string: " ", ind: maskedPhone.count - 12)
        }
        
        maskedPhone += "@" + mail[1]
        return maskedPhone
    }
    
    mutating func insert(string:String,ind:Int) {
        self.insert(contentsOf: string, at:self.index(string.startIndex, offsetBy: ind) )
    }
    
    // MARK: Identifier validation, Formatter
    /// Función depreciada
    func applyFormattedTextBy(countryCode : String) -> String {
        var currentText = self
        switch countryCode {
        case "CL",
             "EC",
             "PE",
             "SV",
             "UY":
            currentText = currentText.removeAll(_character: "-")
            if currentText.count > 8 {
                currentText = currentText.append(at: (currentText.count - 1), _character : "-")
                return currentText
            }
        case "BR":
            currentText = currentText.removeAll(_character: "-")
            if currentText.count > 2 {
                currentText = currentText.append(at: (currentText.count - 2), _character : "-")
                return currentText
            }
        case "DO":
            currentText = currentText.removeAll(_character: "-")
            currentText = currentText.append(at: 3, _character: "-")
            currentText = currentText.append(at: 11, _character: "-")
            return currentText
        case "NI":
            currentText = currentText.removeAll(_character: "-")
            currentText = currentText.append(at: 3, _character: "-")
            currentText = currentText.append(at: 10, _character: "-")
            return currentText
        case "HN":
            currentText = currentText.removeAll(_character: "-")
            currentText = currentText.append(at: 4, _character: "-")
            currentText = currentText.append(at: 9, _character: "-")
            return currentText
        default:
            return self
        }
        return self
    }
    
    /// Función depreciada
    func isValidFor(countryCode : String) -> Bool {
        var regex : String?
        switch countryCode {
        case "CL",
             "EC",
             "PE",
             "SV",
             "UY":
            regex = "[0-9]+-+[0-9]{1}"
            break
        case "CO",
             "AR",
             "CR",
             "GT",
             "PA",
             "PR":
            regex = "[0-9]"
            break
        case "BR":
            regex = "[0-9]+-+[0-9]{2}"
            break
        case "DO":
            regex = "[0-9]{3}+-+[0-9]{7}+-+[0-9]{1}"
            break
        case "HN":
            regex = "[0-9]{4}+-+[0-9]{4}+-+[0-9]{4}"
            break
        case "NI":
            regex = "[0-9]{3}+-+[0-9]{6}+-+[0-9]{3}+[A-z0-9]{1}"
            break
        default:
            return false
        }
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex!)
        return predicate.evaluate(with:self)
    }
    /// Función que evalua una expresión regular
    /// - parameter expression: String
    /// - Returns : Bool
    func evalRegexWith( expression : String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", expression)
        return predicate.evaluate(with:self)
    }
    
    // MARK: Helpers
    /// Función que remueve un caracter de un stirng
    /// - parameter character: Character
    // - Returns: String
    func removeAll(_character : Character ) -> String {
        var result = self
        while result.contains(_character) {
            result.remove(at: result.index(of: _character)!)
        }
        return result
    }
    /// Función que agrega un caracter a un índice
    /// - parameter at: Int
    /// - parameter character : Character
    /// - Returns : String
    func append(at: Int, _character : Character) -> String {
        var result = ""
        var index = 0
        for character in self {
            if index == at {
                result.append(_character)
            }
            result.append(character)
            index += 1
        }
        return result
    }
    
    // MARK: Localization
    /// Variable para localizar un string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    /// Función que determina el Line of Business
    /// Returns : String
    func calculateLineOfBusiness() -> String {
        if self.contains("1") { return "1" }
        if self.contains("3") { return "3" }
        return "2"
    }

    var digitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    ///Obtener la altura para un label dependiendo el texto
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
}




