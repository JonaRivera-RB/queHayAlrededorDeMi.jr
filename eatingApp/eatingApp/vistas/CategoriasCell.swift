//
//  CategoriasCell.swift
//  eatingApp
//
//  Created by misael rivera on 26/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import UIKit

class CategoriasCell: UITableViewCell {

    @IBOutlet weak var categoriaImagen: UIImageView!
    @IBOutlet weak var categoriaTitulo: UILabel!
    
    func actualizarVistas(categoria: Categoria){
        categoriaImagen.image = UIImage(named: categoria.imagenNombre)
        categoriaTitulo.text = categoria.titulo
        
    }

}
