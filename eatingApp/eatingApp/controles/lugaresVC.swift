//
//  lugaresVC.swift
//  eatingApp
//
//  Created by misael rivera on 01/01/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher
//import mapkit

class lugaresVC: UIViewController, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate {
    
     @IBOutlet weak var tablaLugares: UITableView!
    
    private (set) public var productos = [producto]()
    var refreshControl: UIRefreshControl!
    var titulo:String = ""
    var activityindicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var direcciones = [String]()
    var nombres = [String]()
    var latitudes = [Double]()
    var longitudes = [Double]()
    var fotosReferencia = [String]()
    var placeId = [String]()
    var valoraciones = [Float]()
    
    var latitud = 0.0
    var Longitud = 0.0
    var palabra = ""
    var locationManager:CLLocationManager = CLLocationManager()
    
    //detectar si hay internet
     var reachability:Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaLugares.dataSource = self
        tablaLugares.delegate = self
        cargarlogo()
        
        refrescar()
        activarIndicador()
        //internet
        self.reachability = Reachability.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(conexion), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch  {
            print("error en la notificacion")
        }
    }
    @objc func conexion(nota:Notification){
        let reach = nota.object as! Reachability
        switch reach.connection {
        case .wifi:
            break
          //  self.indicadorLbl.text = "Hay conexion wifi"
        case .cellular:
            break
          //  self.indicadorLbl.text = "Hay conexion movil"
        case .none:
            showAlert()
            break
          //  self.indicadorLbl.text = "no hay conexion"
        }
    }
    
    
    func refrescar()
    {
        tablaLugares.layer.cornerRadius = 5.0
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "jale para actualizar")
        refreshControl.tintColor = #colorLiteral(red: 0, green: 0.5919514298, blue: 0.92571944, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tablaLugares.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: Any) {
        productos = DataService.ejemplo.obtenerProducto(paraTituloCategoria: titulo)
        tablaLugares.reloadData()
        refreshControl.endRefreshing()
        if reachability.connection == .none {
            showAlert()
        }
    }
    
    func cargarlogo()
    {
        let logo = UIImage(named: "phood_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    func  activarIndicador()
    {
        //posicionamos indicador en el centro
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        //agregamos estilo color gris
        activityindicator.style = UIActivityIndicatorView.Style.gray
        //agregamos la vista a una sub vista con la animacion
        activityindicator.accessibilityLabel = "Cargando"
        view.addSubview(activityindicator)
    }
    
    func initCordenadas(latitud2: Double, longitud2:Double, palabra2:String) {
        latitud = latitud2
        Longitud = longitud2
        palabra = palabra2
        print("latitud \(latitud),\(Longitud),\(palabra)")
    }
    func initProducto(categoria: Categoria){
        productos = DataService.ejemplo.obtenerProducto(paraTituloCategoria: categoria.titulo)
       titulo = categoria.titulo
       if productos.isEmpty == true {
        print("aqui estoy antes de hacer peticion ")
        activityindicator.startAnimating()
        switch titulo {
        case "RESTAURANTE":
            peticion(tipo: "restaurant")
        case "BAR":
            peticion(tipo: "bar")
        case "CAFE":
            peticion(tipo: "cafe")
        case "HOSPITAL":
            peticion(tipo: "hospital")
        case "DENTISTA":
            peticion(tipo: "dentist")
        case "GIMNASIO":
            peticion(tipo: "gym")
        case "CAR WASH":
            peticion(tipo: "car_wash")
        case "CASINO":
            peticion(tipo: "casino")
        case "FARMACIA":
            peticion(tipo: "pharmacy")
        case "GASOLINERA":
            peticion(tipo: "gas_station")
        case "PERSONALIZADA":
            peticion(tipo: palabra)
        default:
            peticion(tipo: "restaurant")
        }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productos.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
       let transform = CATransform3DTranslate(CATransform3DIdentity, -250 , 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1.0)
            {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let celda2 = tableView.dequeueReusableCell(withIdentifier: "productoCell", for: indexPath) as? lugaress {
            let lugares = productos[indexPath.row]
            celda2.actualizarVistas(producto: lugares)
            return celda2
        } else {
            return lugaress()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lugar = productos[indexPath.row]
        performSegue(withIdentifier: "identificadorVC", sender: lugar)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let lugarVC = segue.destination as? detalleVC {
          assert(sender as? producto != nil)
            lugarVC.initDetalles(producto: sender as! producto)
            print("adentro--")
        }
    }
    func peticion(tipo:String)
    {
        var urlApi:String
        if palabra.isEmpty {
            print("---estoy adentro----")
         urlApi = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitud),\(Longitud)&rankby=distance&type=\(tipo)&key=AIzaSyD4aBuZnkQ5E3hjA1gZFjz4sBWXBnvX-e4"
            print(urlApi)
            print("---estoy adentro----")
        }
        else {
            print("----estoy fuera----")
             urlApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(tipo)&location=\(latitud),\(Longitud)&radius=500&key=AIzaSyD4aBuZnkQ5E3hjA1gZFjz4sBWXBnvX-e4"
            print(urlApi)
            print("----estoy fuera----")
            
        }
        //AIzaSyAFMkzVDuISRqh8xwX5oynliaYUS0CFJfM
        
        //AIzaSyDdg0hxZg8i1VfTi-o-wD5Ykij7ILqbVSM
        
        //original AIzaSyD4aBuZnkQ5E3hjA1gZFjz4sBWXBnvX-e4
        print(urlApi)
        let urlObjeto = URL(string:urlApi)
        let homework = URLSession.shared.dataTask(with: urlObjeto!)
        {
            datos,respuesta,error in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    let getResultados = json["results"] as? [Any]
                    
                    for int in getResultados! {
                        let firstObject = int as? [String:Any]
                        
                        if let obtDireccion = firstObject!["vicinity"] as? String {
                            self.direcciones.append(obtDireccion)
                        }
                        else {
                            if let obtDireccion = firstObject!["formatted_address"] as? String {
                                self.direcciones.append(obtDireccion)
                            }
                        }
                        let guardarNombre = [firstObject!["name"] as! String]
                        let guardarId = [firstObject!["place_id"]as! String]
                        if let obtValoracion = firstObject!["rating"] as? Double {
                            self.valoraciones.append(Float(obtValoracion))
                        }
                        else {
                            self.valoraciones.append(0)
                        }
                        
                        let obtDireccion1 = firstObject!["geometry"] as? [String:Any]
                        let obtCordenadas = obtDireccion1!["location"] as? [String:Any]
                        
                        let latitud =  obtCordenadas!["lat"] as! Double
                        let longitud = obtCordenadas!["lng"] as! Double
                        
                        if let obtReferencia = firstObject!["photos"] as? [Any]{
                            for int in obtReferencia {
                                let firsObject2 = int as? [String:Any]
                                if let foto = firsObject2!["photo_reference"] as? String{
                                    self.fotosReferencia.append(foto)
                                }
                            }
                        }
                        else {
                            self.fotosReferencia.append("")
                        }
                        self.latitudes.append(latitud)
                        self.longitudes.append(longitud)
                        self.nombres.append(contentsOf: guardarNombre)
                        self.placeId.append(contentsOf: guardarId)
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        var numero:Int = 0
                        for _ in self.nombres {
                            let urlString = self.fotosReferencia[numero]
                            if  urlString != "" {
                                let urlFoto = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(urlString)&key=AIzaSyD4aBuZnkQ5E3hjA1gZFjz4sBWXBnvX-e4"
                                let url = URL(string: urlFoto)
                                
                                let nombre:String = self.nombres[numero]
                                let direccion:String = self.direcciones[numero]
                                let latitud:Double = self.latitudes[numero]
                                let longitud:Double = self.longitudes[numero]
                                let idplace:String = self.placeId[numero]
                                let valoracion:Float = self.valoraciones[numero]
                                
                                print("valoraciones que entran:\(valoracion)")
                                estrellasAsigar(valoracion: valoracion)
                                switch tipo {
                                case "restaurant":
                                    DataService.ejemplo.restaurante.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "bar":
                                    DataService.ejemplo.bares.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "cafe":
                                    DataService.ejemplo.cafes.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "hospital":
                                    DataService.ejemplo.hospitales.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "dentist":
                                    DataService.ejemplo.dentistas.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "gym":
                                    DataService.ejemplo.gimansio.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "car_wash":
                                    DataService.ejemplo.carwashes.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "casino":
                                    DataService.ejemplo.casinos.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "pharmacy":
                                    DataService.ejemplo.farmacia.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case "gas_station":
                                    DataService.ejemplo.gasolina.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                case self.palabra:
                                    DataService.ejemplo.personalizada.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                    
                                default:
                                    DataService.ejemplo.restaurante.append(producto(titulo: nombre, imagenLugar: url!, direccion: direccion, longitud: longitud, latitud: latitud, idplace: idplace, valoracion: valoracion, estrella1: estrellai, estrella2: estrella2i, estrella3: estrella3i, estrella4: estrella4i, estrella5: estrella5i))
                                }
                            }
                            numero = numero + 1
                        }
                        print("aqui estoy")
                        self.productos = DataService.ejemplo.obtenerProducto(paraTituloCategoria: self.titulo)
                        self.tablaLugares.reloadData()
                        if self.palabra.isEmpty == false {
                        DataService.ejemplo.personalizada.removeAll()
                        }
                        self.activityindicator.stopAnimating()
                    })
                }catch{ print("el procesamiento salio mal")
                    
                }
            }
        }
        homework.resume()
    }
        
}
extension lugaresVC: UIAlertViewDelegate{
    func showAlert(){
        UIAlertView(title: "Ups",
                    message: "Consigue internet para una mejor experiencia",
            delegate: self,
            cancelButtonTitle: "Ok").show()
    }
}

