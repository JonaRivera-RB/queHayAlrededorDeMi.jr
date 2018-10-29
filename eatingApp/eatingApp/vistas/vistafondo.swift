//
//  vistafondo.swift
//  eatingApp
//
//  Created by misael rivera on 18/01/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable
class vistafondo: UIView {

    override func prepareForInterfaceBuilder() {
        vistaVista()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaVista()
    }
    func vistaVista() {
        layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       // layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.8
    }

}
