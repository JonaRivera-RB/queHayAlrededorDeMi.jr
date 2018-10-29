//
//  categoria.swift
//  eatingApp
//
//  Created by misael rivera on 26/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import Foundation

struct Categoria {
    private(set) public var titulo: String
    private(set) public var imagenNombre: String
    
    init(titulo: String, imagenNombre: String) {
        self.titulo = titulo
        self.imagenNombre = imagenNombre
    }
}
