//
//  LinkableLabel.swift
//  MiClaro
//
//  Created by Roberto Gutierrez Resendiz on 02/08/17.
//  Copyright © 2017 am. All rights reserved.
//

import UIKit

/// Esta clase especializa un UILabel para permitirle tener apariencia de label subrayado con la posibilidad de detectar clicks o toques en la región donde se visualiza.
public class LinkableLabel: UILabel, UIGestureRecognizerDelegate {
    private var linkTextRange : NSRange?;
    private var gesture : UITapGestureRecognizer?;
    public var delegate : LinkeableEventDelegate?;

    public override init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) {
        super.init(frame: frame);
        setup();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }

    deinit {
        if let g = self.gesture {
            self.removeGestureRecognizer(g);
        }
    }

    private func setup(){
        self.textColor = institutionalColors.claroLightGrayColor;
        self.font = UIFont(name: RobotoFontName.RobotoRegular.rawValue, size: CGFloat(14))
        self.textAlignment = .left;
        self.isUserInteractionEnabled = true;

        self.showText(text : self.text ?? "");
        self.sizeToFit();
        self.numberOfLines = 0;
        self.lineBreakMode = .byWordWrapping;

        gesture = UITapGestureRecognizer(target: self, action: #selector(showLink));
        gesture?.delegate = self;
        self.addGestureRecognizer(gesture!);
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }

    public func showText(text : String) {
        self.attributedText = self.boldString(string: text);
    }
    
    public func showTextWithoutUnderline(text : String) {
        self.attributedText = self.boldStringWithoutUnderline(string: text);
    }

    private func boldString(string : String) -> NSAttributedString {
        if (string.isEmpty) {
            return NSMutableAttributedString(string: string);
        }

        do {
            let attributedDescription = NSMutableAttributedString(string: string);
            let regex = try NSRegularExpression(pattern: ".*?<b>(.*?)<\\/b>.*?",
                                                options: NSRegularExpression.Options.caseInsensitive);
            let myArray = regex.matches(in: string,
                                        options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds,
                                        range: NSMakeRange(0, string.count));
            for match : NSTextCheckingResult in myArray {
                let matchRange : NSRange = match.rangeAt(1);
                linkTextRange = matchRange;
                attributedDescription.addAttributes([NSForegroundColorAttributeName : institutionalColors.claroBlueColor,
                                                     NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue,
                                                     NSFontAttributeName : UIFont.boldSystemFont(ofSize: self.font.pointSize)],
                                                    range: matchRange);
            }

            let startTag = "<b>";
            let endTag = "</b>";

            while(true == attributedDescription.string.contains(startTag) || true == attributedDescription.string.contains(endTag)) {
                if let rangeOfTag = attributedDescription.string.range(of: startTag, options: NSString.CompareOptions.caseInsensitive) {
                    attributedDescription.replaceCharacters(in: attributedDescription.string.nsRange(from: rangeOfTag), with: "");
                }

                if let rangeOfTag = attributedDescription.string.range(of: endTag, options: NSString.CompareOptions.caseInsensitive) {
                    attributedDescription.replaceCharacters(in: attributedDescription.string.nsRange(from: rangeOfTag), with: "");
                }
            }

            return attributedDescription;
        } catch {
            return NSMutableAttributedString(string: string);
        }
    }
    
    private func boldStringWithoutUnderline(string : String) -> NSAttributedString {
        if (string.isEmpty) {
            return NSMutableAttributedString(string: string);
        }
        
        do {
            let attributedDescription = NSMutableAttributedString(string: string);
            let regex = try NSRegularExpression(pattern: ".*?<b>(.*?)<\\/b>.*?",
                                                options: NSRegularExpression.Options.caseInsensitive);
            let myArray = regex.matches(in: string,
                                        options: NSRegularExpression.MatchingOptions.withoutAnchoringBounds,
                                        range: NSMakeRange(0, string.count));
            for match : NSTextCheckingResult in myArray {
                let matchRange : NSRange = match.rangeAt(1);
                linkTextRange = matchRange;
                attributedDescription.addAttributes([NSForegroundColorAttributeName : institutionalColors.claroBlueColor,
                                                     NSUnderlineStyleAttributeName : NSUnderlineStyle.styleNone.rawValue,
                                                     NSFontAttributeName : UIFont.boldSystemFont(ofSize: self.font.pointSize)],
                                                    range: matchRange);
            }
            
            let startTag = "<b>";
            let endTag = "</b>";
            
            while(true == attributedDescription.string.contains(startTag) || true == attributedDescription.string.contains(endTag)) {
                if let rangeOfTag = attributedDescription.string.range(of: startTag, options: NSString.CompareOptions.caseInsensitive) {
                    attributedDescription.replaceCharacters(in: attributedDescription.string.nsRange(from: rangeOfTag), with: "");
                }
                
                if let rangeOfTag = attributedDescription.string.range(of: endTag, options: NSString.CompareOptions.caseInsensitive) {
                    attributedDescription.replaceCharacters(in: attributedDescription.string.nsRange(from: rangeOfTag), with: "");
                }
            }
            
            return attributedDescription;
        } catch {
            return NSMutableAttributedString(string: string);
        }
    }

    public func showLink(gesture : UITapGestureRecognizer) {
        if let ltr = self.linkTextRange {
            if (gesture.didTapAttributedTextInLabel(label: self, inRange: ltr)) {
                delegate?.ClickedBoldText();
            } else {
                delegate?.ClickedNormalText();
            }
        }
    }

}

/// Esta extensión sirve para detectar los toques dentro de una región de un UILabel
extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                            in: textContainer,
                                                            fractionOfDistanceBetweenInsertionPoints: nil);

        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
