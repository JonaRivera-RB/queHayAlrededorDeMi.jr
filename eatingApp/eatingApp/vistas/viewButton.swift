//
//  viewButton.swift
//  eatingApp
//
//  Created by Misael Rivera on 10/28/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable

class viewButton: UIButton {
    override func prepareForInterfaceBuilder() {
        viewButton()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewButton()
    }
    func viewButton() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.8
    }
}
