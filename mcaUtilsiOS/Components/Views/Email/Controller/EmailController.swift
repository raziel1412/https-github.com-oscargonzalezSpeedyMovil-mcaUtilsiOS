//
//  EmailController.swift
//  MiClaro
//
//  Created by Jonathan Abimael Cruz Orozco on 21/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

 extension EmailView: UITextViewDelegate {

    //MARK: UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        let textViewFixedWidth: CGFloat = textView.frame.size.width
        let newSize : CGSize = textView.sizeThatFits(CGSize(width: textViewFixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame: CGRect = textView.frame
        
        //var textViewYPosition = self.txtDescription.frame.origin.y
        let heightDifference = textView.frame.height - newSize.height
        
        if (abs(heightDifference) > 20) {
            newFrame.size = CGSize(width: fmax(newSize.width, textViewFixedWidth), height: newSize.height)
            newFrame.offsetBy(dx: 0.0, dy: 0.0)
        }
        
        textView.frame = newFrame
        
        delegate?.emailViewChangeHeight(newHeight: newFrame.height)
        self.updateBottomLinePosition()
    }
    
    public func updateLabelCount(numCharacteres: Int) {
        self.lblCharacters.text = NSString(format: "%d/160", numCharacteres) as String
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == institutionalColors.claroLightGrayColor {
            applyNonPlaceholderStyle(textView: textView)
        }else if textView.text != placeHolderDescription {
//            bottomBorderLine.backgroundColor = institutionalColors.claroBlueColor
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == placeHolderDescription {
            textView.text = self.placeHolderDescription
            textView.textColor = institutionalColors.claroLightGrayColor
           bottomBorderLine.backgroundColor = institutionalColors.claroLightGrayColor
        }else {
           bottomBorderLine.backgroundColor = institutionalColors.claroLightGrayColor
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // remove the placeholder text when they start typing
        // first, see if the field is empty
        // if it's not empty, then the text should be black and not italic
        // BUT, we also need to remove the placeholder text if that's the only text
//        let newLength = textView.text.utf16.count + text.utf16.count - range.length
//        if newLength > 0 // have text, so don't show the placeholder
//        {
//            // check if the only text is the placeholder and remove it if needed
//            if textView.textColor == institutionalColors.claroLightGrayColor// && textView.text == PLACEHOLDER_TEXT
//            {
//                applyNonPlaceholderStyle(textView: textView)
//                textView.text = ""
//            }
//        }else {
//            applyPlaceholderStyle(textView: textView)
//        }
        let maxText = 160
        
        let newString = (textView.text! as NSString).replacingCharacters(in: range, with: text) as String
        let nsString = NSString(string: newString)
        if nsString.length > maxText {
            return false
        }else {
            self.updateLabelCount(numCharacteres: nsString.length)
            return true
        }
    }
    
    
    /// Para aplicar un diseño similar a un textfield del componente textView
    /// - Parameter textView: Componente tipo textView al cual se le agregará un diseño similar a un textfield **no seleccionado**
    func applyNonPlaceholderStyle(textView: UITextView) {
        textView.text = nil
        textView.textColor = institutionalColors.claroBlackColor
        bottomBorderLine.backgroundColor = institutionalColors.claroBlueColor
    }
    
    /// Para aplicar un diseño similar a un textfield del componente textView
    /// - Parameter textView: Componente tipo textView al cual se le agregará un diseño similar a un textfield **seleccionado**
    func applyPlaceholderStyle(textView: UITextView) {
        textView.text = placeHolderDescription
        textView.textColor = institutionalColors.claroLightGrayColor
        bottomBorderLine.backgroundColor = institutionalColors.claroLightGrayColor
    }
}
