//
//  File.swift
//  eatingApp
//
//  Created by misael rivera on 30/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import Foundation
struct producto {
    private(set) public var nombre: String
    private(set) public var imagenLugar: URL
    private(set) public var direccion: String
    private(set) public var longitud: Double
    private(set) public var latitud: Double
    private(set) public var idplace: String
    private(set) public var valoracion: Float
    private(set) public var estrella1:String
    private(set) public var estrella2:String
    private(set) public var estrella3:String
    private(set) public var estrella4:String
    private(set) public var estrella5:String
    
    init(titulo: String, imagenLugar: URL, direccion: String,longitud: Double, latitud: Double,idplace:String,valoracion:Float,estrella1:String,estrella2:String,estrella3:String,estrella4:String,estrella5:String) {
        self.nombre = titulo
        self.imagenLugar = imagenLugar
        self.direccion = direccion
        self.longitud = longitud
        self.latitud = latitud
        self.idplace = idplace
        self.valoracion = valoracion
        self.estrella1 = estrella1
        self.estrella2 = estrella2
        self.estrella3 = estrella3
        self.estrella4 = estrella4
        self.estrella5 = estrella5
    }
}
