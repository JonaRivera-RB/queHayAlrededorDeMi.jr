//
//  lugaress.swift
//  eatingApp
//
//  Created by misael rivera on 30/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import UIKit

class lugaress: UITableViewCell {
    
    @IBOutlet weak var lugarImagen: UIImageView!
    @IBOutlet weak var lugarNombre: UILabel!
    @IBOutlet weak var lugarDireccion:UILabel!
    @IBOutlet weak var lugarEstrellas:UILabel!
    @IBOutlet weak var estrella1: UIImageView!
    @IBOutlet weak var estrella2: UIImageView!
    @IBOutlet weak var estrella3: UIImageView!
    @IBOutlet weak var estrella4: UIImageView!
    @IBOutlet weak var estrella5: UIImageView!
    
    func actualizarVistas(producto: producto){
        lugarImagen.kf.setImage(with: producto.imagenLugar)
        lugarNombre.text = producto.nombre
        lugarDireccion.text = producto.direccion
        lugarEstrellas.text = String(producto.valoracion)
        estrella1.image = UIImage(named: producto.estrella1)
        estrella2.image = UIImage(named: producto.estrella2)
        estrella3.image = UIImage(named: producto.estrella3)
        estrella4.image = UIImage(named: producto.estrella4)
        estrella5.image = UIImage(named: producto.estrella5)
    }
}
