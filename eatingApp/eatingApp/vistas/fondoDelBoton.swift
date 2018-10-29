//
//  fondoDelBoton.swift
//  eatingApp
//
//  Created by misael rivera on 30/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable

class fondoDelBoton: UIButton {
    
    override func prepareForInterfaceBuilder() {
        vistaPerzonalidaBoton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaPerzonalidaBoton()
    }
    func vistaPerzonalidaBoton(){
        layer.borderWidth = 2.0
        layer.borderColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = 5.0
    }
}
