//
//  fondotxt.swift
//  eatingApp
//
//  Created by misael rivera on 30/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable

class fondotxt: UITextField {
    
    override func prepareForInterfaceBuilder() {
        vistaPersonalidazaTXT()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaPersonalidazaTXT()
    }
    func vistaPersonalidazaTXT() {
        backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.06502278646, blue: 0.21484375, alpha: 0.25)
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 2.0
        layer.cornerRadius = 5.0
        textAlignment = .center
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        clipsToBounds = true
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
}

