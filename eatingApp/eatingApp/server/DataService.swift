//
//  DataService.swift
//  eatingApp
//
//  Created by misael rivera on 26/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import Foundation

class DataService {
    static let ejemplo = DataService()
    
    private let categorias = [
        Categoria(titulo: "RESTAURANTE", imagenNombre: "hamburguesas.jpeg"),
        Categoria(titulo: "BAR", imagenNombre: "bar.jpg"),
        Categoria(titulo: "CAFE", imagenNombre: "cafe.jpg"),
        Categoria(titulo: "HOSPITAL", imagenNombre: "hospital.jpg"),
        Categoria(titulo: "DENTISTA", imagenNombre: "dentista.jpg"),
        Categoria(titulo: "GIMNASIO", imagenNombre: "gimansio.jpg"),
        Categoria(titulo: "CAR WASH", imagenNombre: "carwash.jpg"),
        Categoria(titulo: "CASINO", imagenNombre: "casino.jpg"),
        Categoria(titulo: "FARMACIA", imagenNombre: "farmacia.jpg"),
        Categoria(titulo: "GASOLINERA", imagenNombre: "gasolina.jpg")
    ]
    
    public var restaurante = [producto]()
    public var bares = [producto]()
    public var cafes = [producto]()
    public var hospitales = [producto]()
    public var dentistas = [producto]()
    public var gimansio = [producto]()
    public var carwashes = [producto]()
    public var casinos = [producto]()
    public var farmacia = [producto]()
    public var gasolina = [producto]()
    
    public var personalizada = [producto]()
    public var obtenerReviews = [reviews]()
    
    
    func obtenerCategoria() -> [Categoria]
    {
        return categorias
    }
    private let categoriaPersonalizada = [
        Categoria(titulo: "PERSONALIZADA", imagenNombre: "casino.jpg")
    ]
    func obtenerCategoriaPersonalizada() -> [Categoria]
    {
        return categoriaPersonalizada
    }

    func obtenerProducto(paraTituloCategoria titulo:String) -> [producto] {
        switch titulo {
        case "RESTAURANTE":
            return obtenerRestaurante()
        case "BAR":
            return obtenerBares()
        case "CAFE":
            return obtenerCafe()
        case "HOSPITAL":
            return obtenerHospital()
        case "DENTISTA":
            return obtenerDentista()
        case "GIMNASIO":
            return obtenerGimnasio()
        case "CAR WASH":
            return obtenerCarWash()
        case "CASINO":
                return obtenerCasino()
        case "FARMACIA":
            return obtenerFarmacia()
        case "GASOLINERA":
            return obtenerGasolinera()
        case "PERSONALIZADA":
            return obtenerPersonalizada()
        default:
            return obtenerRestaurante()
        }
        
    }
    
    func obtenerRestaurante() -> [producto] {
        return restaurante
    }
    
    func obtenerBares() -> [producto] {
        return bares
    }
    
    func obtenerCafe() -> [producto] {
        return cafes
    }
    
    func obtenerHospital() -> [producto] {
        return hospitales
    }
    func obtenerDentista() -> [producto] {
        return dentistas
    }
    func obtenerGimnasio() -> [producto] {
        return gimansio
    }
    func obtenerCarWash() -> [producto] {
        return carwashes
    }
    func obtenerCasino() -> [producto] {
        return casinos
    }
    
    func obtenerFarmacia() -> [producto] {
        return farmacia
    }
    
    func obtenerGasolinera() -> [producto] {
        return gasolina
    }
    func obtenerPersonalizada() -> [producto] {
        return personalizada
    }
    
}
