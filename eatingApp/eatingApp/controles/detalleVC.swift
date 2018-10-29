//
//  detalleVC.swift
//  eatingApp
//
//  Created by misael rivera on 10/01/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import SafariServices

class detalleVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate {
    
    private (set) public var idplace:String = ""
    private (set) public var nombrelugar:String = ""
    private (set) public var pagina:String = ""
    private (set) public var paginaW:String = ""
    private (set) public var numero:String = ""
    private (set) public var numeroTel:String = ""
    private (set) public var latitud1:Double = 0.0
    private (set) public var longitud1:Double = 0.0
    private (set) public var urlfoto:URL!
    private (set) public var direccion:String = ""
    private (set) public var valoracion:Float = 0.0
    private (set) public var horariosV = [String]()
    private (set) public var reviewsNombre = [String]()
    private (set) public var reviewsfecha = [String]()
    private (set) public var reviewsDice = [String]()
    private (set) public var horariosMandar:String = ""
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var tablaReview: UITableView!
    @IBOutlet weak var llamarconf: UIButton!
    @IBOutlet weak var paginaconf: UIButton!
    @IBOutlet weak var direccionconf: UIButton!
    @IBOutlet weak var horariosConfg: UIButton!
    @IBOutlet weak var valoracionconf: UILabel!
    @IBOutlet weak var lblhorarios: UILabel!
    
    @IBOutlet weak var imagenmod: UIImageView!
    @IBOutlet weak var centerPop: NSLayoutConstraint!
    
    
    @IBOutlet weak var estrella1: UIImageView!
    @IBOutlet weak var estrella2: UIImageView!
    @IBOutlet weak var estrella3: UIImageView!
    @IBOutlet weak var estrella4: UIImageView!
    @IBOutlet weak var estrella5: UIImageView!
    
    
    var activityindicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarlogo()
        activarIndicador()
        tablaReview.dataSource = self
        tablaReview.delegate = self
        
        valoracionconf.text = String(valoracion)
        
        if direccion.isEmpty == true {
            direccionconf.setTitle("  Sin direccion", for: UIControl.State.normal)
        }
        else
        {
            direccionconf.setTitle("  \(direccion)", for: UIControl.State.normal)
        }
        
        estrellasAsigar(valoracion: valoracion)
        
        estrella1.image = UIImage(named: estrellai)
        estrella2.image = UIImage(named: estrella2i)
        estrella3.image = UIImage(named: estrella3i)
        estrella4.image = UIImage(named: estrella4i)
        estrella5.image = UIImage(named: estrella5i)
        
        if DataService.ejemplo.obtenerReviews.isEmpty == true {
            activityindicator.startAnimating()
        }
        
        imagen.kf.setImage(with: urlfoto)
        let url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(idplace)&key=AIzaSyD4aBuZnkQ5E3hjA1gZFjz4sBWXBnvX-e4"
        let urlObjeto = URL(string: url)
        let homework = URLSession.shared.dataTask(with: urlObjeto!)
        {
            datos,respuesta,error in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    let getResultados = json["result"] as? [String:Any]
                    if let getNumero = getResultados!["formatted_phone_number"] as? String
                    {
                        self.numero = getNumero
                    }
                    if let paginaWeb = getResultados!["website"] as? String
                    {
                        self.pagina = paginaWeb
                    }
                    if let horarios = getResultados!["opening_hours"] as? [String:Any]
                    {
                        if let obtenerHorarios = horarios["weekday_text"] as? [String]
                        {
                            var numero  = 0
                            for _ in obtenerHorarios {
                                
                                self.horariosV.append(obtenerHorarios[numero])
                                numero = numero + 1
                            }
                        }
                    }
                    if let obtenerReviews = getResultados!["reviews"] as? [Any]
                    {
                        for int in obtenerReviews {
                            let firsObject  = int as? [String:Any]
                            let obtNombre  = [firsObject!["author_name"] as! String]
                            let obtFecha = [firsObject!["relative_time_description"] as! String]
                            let obtReview = [firsObject!["text"] as! String]
                            
                            self.reviewsNombre.append(contentsOf: obtNombre)
                            self.reviewsfecha.append(contentsOf: obtFecha)
                            self.reviewsDice.append(contentsOf: obtReview)
                        }
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        print("adentro")
                        self.lblNombre.text = self.nombrelugar
                        self.paginaW = self.pagina
                        if self.paginaW.isEmpty == true {
                            self.paginaconf.setTitle(" Sin pagina web", for: UIControl.State.normal)
                        }
                        else {
                            self.paginaconf.setTitle("  \(self.paginaW)", for: UIControl.State.normal)
                        }
                        
                        let numeronuevo = self.numero.replacingOccurrences(of: " ", with: "")
                        let numeronuevo2 = numeronuevo.replacingOccurrences(of: "01", with: "")
                            self.numeroTel = numeronuevo2
                        if self.numeroTel.isEmpty == true {
                            self.llamarconf.setTitle("  Sin numero", for: UIControl.State.normal)
                        }
                        else {
                            self.llamarconf.setTitle("  \(self.numeroTel)", for: UIControl.State.normal)
                        }
                        var numero = 0
                        for _ in self.horariosV {
                            self.lblhorarios.text?.append(self.horariosV[numero])
                            self.lblhorarios.text?.append("\n")
                            numero = numero + 1
                        }
                        var numero2 = 0
                        if DataService.ejemplo.obtenerReviews.isEmpty == false {
                            DataService.ejemplo.obtenerReviews.removeAll()
                        }
                       // DataService.ejemplo.obtenerReviews.removeAll()
                        for _ in self.reviewsNombre {
                            DataService.ejemplo.obtenerReviews.append(reviews(nombreAutor: self.reviewsNombre[numero2], fechaReview: self.reviewsfecha[numero2], reviewDice: self.reviewsDice[numero2]))
                            numero2 = numero2 + 1
                        }
                        
                        print(self.reviewsNombre)
                        self.tablaReview.reloadData()
                        self.activityindicator.stopAnimating()
                    })

                }catch {
            }
            }
        
    }
        homework.resume()
    }
    func cargarlogo()
    {
        let logo = UIImage(named: "phood_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func initDetalles(producto: producto){
        latitud1 = producto.latitud
        longitud1 = producto.longitud
        idplace = producto.idplace
        nombrelugar = producto.nombre
        urlfoto = producto.imagenLugar
        direccion = producto.direccion
        valoracion = producto.valoracion
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DataService.ejemplo.obtenerReviews.count)
        return DataService.ejemplo.obtenerReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let celdas = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as? reviewCell {
            let review = DataService.ejemplo.obtenerReviews[indexPath.row]
            celdas.actualizarVista(reviews: review)
            return celdas
        } else {
            return reviewCell()
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
    @IBAction func abrirweb(_ sender: Any) {
        if paginaW != "" {
            let safari = SFSafariViewController(url: NSURL(string: paginaW)! as URL)
            safari.view.tintColor = UIColor(red: 248/255.0, green: 47/255.0, blue: 38/255.0, alpha:1.0)
            safari.delegate = self
            present(safari, animated: true, completion: nil)
            
            /*let url = NSURL(string: paginaW)!
             UIApplication.shared.open(url as URL)*/
        }
        else {
            let alerta  = UIAlertController(title: "Ups", message: "Al parecer este negocio no cuenta con pagina web", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
    }
    @IBAction func horariosPop(_ sender: Any) {
        centerPop.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.tablaReview.isUserInteractionEnabled = false
            self.llamarconf.isUserInteractionEnabled = false
            self.paginaconf.isUserInteractionEnabled = false
            self.direccionconf.isUserInteractionEnabled = false
            self.imagenmod.alpha = 0.5
            self.tablaReview.alpha = 0.5
        }
    }
    
    @IBAction func esconderHorario(_ sender: Any) {
        centerPop.constant = 500
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.imagenmod.alpha = 1
            self.tablaReview.alpha = 1
            self.tablaReview.isUserInteractionEnabled = true
            self.llamarconf.isUserInteractionEnabled = true
            self.paginaconf.isUserInteractionEnabled = true
            self.direccionconf.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func botonllamar(_ sender: Any) {
        
         call()
    }
    
    @IBAction func llegar(_ sender: Any) {
        performSegue(withIdentifier: "showMapa", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let lugar = segue.destination as? mapKitVc {
           lugar.latitud = latitud1
            lugar.longitud = longitud1
            lugar.nombre = nombrelugar
        }//producto: sender as! producto
    }
    
     func call() {
        
        if numeroTel != "" {
        guard let number = URL(string: "tel://"+numeroTel)
            else {return}
        UIApplication.shared.open(number)
        } else {
            let alerta = UIAlertController(title:"Ups",message:"al parecer este negocio no cuenta con numero telefonico",preferredStyle: UIAlertController.Style.alert)
            alerta.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            present(alerta, animated: true, completion: nil)
            
        }
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
}
