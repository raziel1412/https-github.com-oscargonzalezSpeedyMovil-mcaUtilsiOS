//
//  LinkeableEventDelegate.swift
//  mcaUtilsiOS
//
//  Created by Pilar del Rosario Prospero Zeferino on 12/3/18.
//  Copyright © 2018 Roberto. All rights reserved.
//

import UIKit

/// Este protocolo permite especificar la acción que será desencadenada a partir de los eventos del LinkableLabel
public protocol LinkeableEventDelegate {
    func ClickedBoldText()
    func ClickedNormalText()
}
