//
//  fondoImagen.swift
//  eatingApp
//
//  Created by misael rivera on 30/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import UIKit
@IBDesignable
class fondoImagen: UIImageView {
    
    override func prepareForInterfaceBuilder() {
        vistaimagen()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        vistaimagen()
    }
    func vistaimagen()
    {
        layer.cornerRadius = 5.0
        //let radius = 5.0
       // let path = UIBezierPath(roundedRect: layer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: radius, height: radius))
      //  let mask = CAShapeLayer()
       // mask.path = path.cgPath
       // layer.mask = mask
    }
}
