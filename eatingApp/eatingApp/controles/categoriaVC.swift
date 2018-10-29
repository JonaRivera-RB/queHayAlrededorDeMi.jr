//
//  ViewController.swift
//  eatingApp
//
//  Created by misael rivera on 26/12/17.
//  Copyright © 2017 misael rivera. All rights reserved.
//

import UIKit
import CoreLocation

class categoriaVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet weak var tablaCategorias: UITableView!
    @IBOutlet weak var buscador:UISearchBar!
    
    var direcciones = [""]
    var nombres = [""]
    var latitudP = 0.0
    var Longitud1 = 0.0
    var palabraAbuscar = ""
    var ejemplobuscar = [String]()
    var buscando = false
    
 var locationManager:CLLocationManager = CLLocationManager()
var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            if let cordenadasPersona = locationManager.location?.coordinate
            {
                latitudP = cordenadasPersona.latitude
                Longitud1 = cordenadasPersona.longitude
                print("latitud y longitud 1 \(latitudP),\(Longitud1)")
            }
        }
        
        tablaCategorias.dataSource = self
        tablaCategorias.delegate = self
        tablaCategorias.layer.cornerRadius = 5.0
        
        buscador.delegate = self
        buscador.returnKeyType = UIReturnKeyType.done
        
        cargarlogo()
        recargar()
    }
    
    func recargar() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "jale para actualizar")
        refreshControl.tintColor = #colorLiteral(red: 0, green: 0.5919514298, blue: 0.92571944, alpha: 1)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tablaCategorias.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: Any) {
        if latitudP == 0.0 {
            if let cordenadasPersona = self.locationManager.location?.coordinate
            {
                latitudP = cordenadasPersona.latitude
                Longitud1 = cordenadasPersona.longitude
            }
        }
        refreshControl.endRefreshing()
    }
   
    func cargarlogo()
    {
        let logo = UIImage(named: "phood_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return DataService.ejemplo.obtenerCategoria().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let celda = tableView.dequeueReusableCell(withIdentifier: "categoriaCell") as? CategoriasCell {
            
            let categoria = DataService.ejemplo.obtenerCategoria()[indexPath.row]
            celda.actualizarVistas(categoria: categoria)
            return celda
        } else {
            return CategoriasCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoria = DataService.ejemplo.obtenerCategoria()[indexPath.row]
        performSegue(withIdentifier: "productoVC", sender: categoria)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            let alert = UIAlertController(title: "Ups", message: "creo que se te olvido poner lo que quieres buscar 🤕", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else
        {
            let categoria = Categoria(titulo: "PERSONALIZADA", imagenNombre: "hamburguesa.png")
            var palabra = searchBar.text!
            palabra = palabra.replacingOccurrences(of: " ", with: "+")
            palabraAbuscar = palabra
            performSegue(withIdentifier: "productoVC", sender: categoria)
            searchBar.text = ""
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let lugaresVC = segue.destination as? lugaresVC {
            assert(sender as? Categoria != nil)
            lugaresVC.initCordenadas(latitud2: latitudP, longitud2: Longitud1, palabra2: palabraAbuscar)
            lugaresVC.initProducto(categoria: sender as! Categoria)
            print("adentro--")
        }
    }
}
