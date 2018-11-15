//
//  Profile.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 08/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import ObjectMapper

/// Clase relacionada con la definición del archivo de configuración
class Profile: NSObject, Mappable {

    var exp : String?
    var field : [String]?
    var addressEditable : Bool?
    var addressViewable : Bool?
    var dateOfBirthEditable : Bool?
    var dateOfBirthViewable : Bool?
    var emailEditable : Bool?
    var emailViewable : Bool?
    var lastNameEditable : Bool?
    var lastNameViewable : Bool?
    var mobileNumberEditable : Bool?
    var mobileNumberViewable : Bool?
    var nameEditable : Bool?
    var nameViewable : Bool?
    var passwordEditable : Bool?
    var passwordViewable : Bool?
    var rutEditable : Bool?
    var rutViewable : Bool?
    var secondLastNameEditable : Bool?
    var secondLastNameViewable : Bool?
    var birthDate : String?
    var changePassword : String?
    var edit : String?
    var editPhotoAlbum : String?
    var editPhotoCamera : String?
    var editPhotoDelete : String?
    var editPhotoDeleteConfirm : String?
    var editPhotoEdit : String?
    var editPhotoTitle : String?
    var email : String?
    var header : String?
    var insertData : String?
    var mobile : String?
    var password : String?
    var passwordChange : String?
    var profileDescription : String?
    var saveChanges : String?
    var title : String?
    var userProfileId : String?

    

    override init() {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    required init?(map: Map) {

    }

    /// Función encargada de mapear el JSON correspondiente
    /// - parameter Map: Objeto de tipo Map
    func mapping(map: Map)
    {
        exp <- map["exp"]
        field <- map["field"]
        addressEditable <- map["addressEditable"]
        addressViewable <- map["addressViewable"]
        dateOfBirthEditable <- map["dateOfBirthEditable"]
        dateOfBirthViewable <- map["dateOfBirthViewable"]
        emailEditable <- map["emailEditable"]
        emailViewable <- map["emailViewable"]
        lastNameEditable <- map["lastNameEditable"]
        lastNameViewable <- map["lastNameViewable"]
        mobileNumberEditable <- map["mobileNumberEditable"]
        mobileNumberViewable <- map["mobileNumberViewable"]
        nameEditable <- map["nameEditable"]
        nameViewable <- map["nameViewable"]
        passwordEditable <- map["passwordEditable"]
        passwordViewable <- map["passwordViewable"]
        rutEditable <- map["rutEditable"]
        rutViewable <- map["rutViewable"]
        secondLastNameEditable <- map["secondLastNameEditable"]
        secondLastNameViewable <- map["secondLastNameViewable"]
        birthDate <- map["birthDate"]
        changePassword <- map["changePassword"]
        edit <- map["edit"]
        editPhotoAlbum <- map["editPhotoAlbum"]
        editPhotoCamera <- map["editPhotoCamera"]
        editPhotoDelete <- map["editPhotoDelete"]
        editPhotoDeleteConfirm <- map["editPhotoDeleteConfirm"]
        editPhotoEdit <- map["editPhotoEdit"]
        editPhotoTitle <- map["editPhotoTitle"]
        email <- map["email"]
        header <- map["header"]
        insertData <- map["insertData"]
        mobile <- map["mobile"]
        password <- map["password"]
        passwordChange <- map["passwordChange"]
        profileDescription <- map["profileDescription"]
        saveChanges <- map["saveChanges"]
        title <- map["title"]
        userProfileId <- map["userProfileId"]
        
    }
}
