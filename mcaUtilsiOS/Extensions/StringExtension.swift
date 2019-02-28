//
//  StringExtension.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 02/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import Foundation

/// Extensión Strings
public extension String {
    /// Función que retorna un rango de un String
    /// - parameter range: Range<Index>
    /// - Returns : NSRange
    public func nsRange(from range: Range<Index>) -> NSRange {
        let lower = UTF16View.Index(range.lowerBound, within: utf16)!;
        let upper = UTF16View.Index(range.upperBound, within: utf16)!;
        return NSRange(location: utf16.startIndex.distance(to: lower), length: lower.distance(to: upper))
    }
    
    /// Función que determina si un email es válido
    /// - Returns : Bool
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    /// Función que determina si un email es válido
    /// - Returns : Bool
    public func isValidEmailOption2() -> Bool {
        guard !self.lowercased().hasPrefix("mailto:") else { return false }
        guard let emailDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        let matches = emailDetector.matches(in: self, options: NSRegularExpression.MatchingOptions.anchored, range: NSRange(location: 0, length: self.count))
        guard matches.count == 1 else { return false }
        return matches[safe:0]?.url?.scheme == "mailto"
    }
    
    public mutating func insert(string:String,ind:Int) {
        self.insert(contentsOf: string, at:self.index(string.startIndex, offsetBy: ind) )
    }
    
    //current string masked by
    
    public func maskAsPhone() -> String {
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
    
    public func maskAsEmail() -> String {
        
        
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
        
        if mail.count > 1{
            maskedPhone += "@" + mail[1]
        }
        return maskedPhone
    }
    
    // MARK: Identifier validation, Formatter
    /// Función depreciada
    public func applyFormattedTextBy(countryCode : String) -> String {
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
    public func isValidFor(countryCode : String) -> Bool {
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
    public func evalRegexWith( expression : String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", expression)
        return predicate.evaluate(with:self)
    }
    
    // MARK: Helpers
    /// Función que remueve un caracter de un stirng
    /// - parameter character: Character
    // - Returns: String
    public func removeAll(_character : Character ) -> String {
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
    public func append(at: Int, _character : Character) -> String {
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
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    /// Función que determina el Line of Business
    /// Returns : String
    public func calculateLineOfBusiness() -> String {
        if self.contains("1") { return "1" }
        if self.contains("3") { return "3" }
        return "2"
    }
    
    public var digitsOnly: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    ///Obtener la altura para un label dependiendo el texto
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    public func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
    
    
}





