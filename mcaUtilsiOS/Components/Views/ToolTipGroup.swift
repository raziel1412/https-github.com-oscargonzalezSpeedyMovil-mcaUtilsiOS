//
//  ToolTipGroup.swift
//  MiClaro
//
//  Created by Fernando Rodriguez Minguet on 06/06/18.
//  Copyright © 2018 am. All rights reserved.
//

import UIKit
import Cartography


public class ToolTipGroup : UIView {
    
    private var headerView : UIHeaderForm = UIHeaderForm(frame: .zero)
    private var oldId : ToolTipElement = ToolTipElement(frame: .zero)
    private var newId : ToolTipElement = ToolTipElement(frame: .zero)
    private var closeButton : GreenBorderWhiteBackgroundButton = GreenBorderWhiteBackgroundButton(textButton: "")
    
    public var haderSubtitleFont : UIFont {
        get {
            return self.haderSubtitleFont
        }
        set(font) {
            self.headerView.subtitleFont = font
        }
    }
    
    public var tipElementSubtitleFont : UIFont {
        get {
            return self.tipElementSubtitleFont
        }
        set(font) {
            self.oldId.descriptionFont = font
            self.newId.descriptionFont = font
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        self.backgroundColor = institutionalColors.claroWhiteColor
        [headerView, oldId, newId, closeButton].forEach({
            self.addSubview($0)
        })
        setupConstraints()
    }
    
    private func setupConstraints() {
        constrain(self, headerView, oldId, newId, closeButton) { (view, header, old, new, button) in
            header.top == view.top
            header.height == view.height * 0.45
            header.leading == view.leading
            header.trailing == view.trailing
            
            old.top == header.bottom + 12.0
            old.leading == view.leading + 12.0
            old.width == view.width / 2 - 12.0
            old.height == view.height * 0.35
            
            new.top == header.bottom + 12.0
            new.leading == old.trailing
            new.trailing == view.trailing - 12.0
            new.width == view.width / 2 - 12.0
            new.height == view.height * 0.35
            
            button.top == new.bottom + 12
            button.top == old.bottom + 12
            button.leading == view.leading + 12.0
            button.trailing == view.trailing - 12.0
            button.height == view.height * 0.08
            button.bottom == view.bottom - 16.0
            
        }
    }
    
    public func setHeaderContent(title: String?, subtitle: String?, imageName: String?) {
        self.headerView.setupElements(imageName: imageName, title: title, subTitle: subtitle)
    }
    
    public func setLeftItemContent(title: String?, subtitle: String?, imageName: String?) {
        self.oldId.setupContent(title: title, description: subtitle, image: imageName)
    }
    
    public func setRightItemContent(title: String?, subtitle: String?, imageName: String?) {
        self.newId.setupContent(title: title, description: subtitle, image: imageName)
    }
    
    public func setButtonContent(title: String?, target: Any? = nil, action: Selector? = nil, controlEvent: UIControlEvents = .touchUpInside) {
        closeButton.setTitle(title, for: .normal)
        closeButton.setTitle(title, for: .selected)
        if let _ = action, let _ = target {
            closeButton.addTarget(target!, action: action!, for: controlEvent)
        }
    }
    
}

