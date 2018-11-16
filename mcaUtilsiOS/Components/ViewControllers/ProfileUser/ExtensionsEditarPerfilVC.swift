//
//  EditarPerfilVC.swift
//  MiClaro
//
//  Created by Omar Israel Trujillo Osornio on 07/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
//import ALCameraViewController
import AVFoundation

extension EditarPerfilVC :  UIImagePickerControllerDelegate  {
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Image saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imagePicker.dismiss(animated: true, completion: nil)
        //        imgName.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.guardarImagen(image: (info[UIImagePickerControllerOriginalImage] as? UIImage)!)
    }
    
}

extension URL {
    static var documentsDirectory: URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(string: documentsDirectory)!
    }
    
    static func urlInDocumentsDirectory(with filename: String) -> URL {
        return documentsDirectory.appendingPathComponent(filename)
    }
}


