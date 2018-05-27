//
//  editViewController.swift
//  iCinema
//
//  Created by carles on 16/5/18.
//  Copyright © 2018 ls31360. All rights reserved.
//

import UIKit

class editViewController: UIViewController {
    @IBOutlet weak var txtTitulo: UITextField!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtEstrenoTemp: UITextField!
    @IBOutlet weak var txtDirector: UITextField!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var txtTemporadas: UITextField!
    
    
    @IBAction func setFav(_ sender: Any) {
        var lFav = "0"
        if(self.btnFav.tintColor == UIColor.blue){
            lFav = "0"
        }
        else{
            lFav = "1"
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let url = URL(string: "http://45.76.138.67/setFav.php?id=" + appDelegate.elementoId + "&favorito=" + lFav)
        print(url!)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("FAV OK")
            self.dismiss(animated: true)
            
        }
        task.resume()
    }
    @IBAction func eliminarClick(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let url = URL(string: "http://45.76.138.67/deleteElemento.php?id=" + appDelegate.elementoId)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("Delete OK")
            self.dismiss(animated: true)

        }
        task.resume()
        
        
    }
    @IBAction func btnCLICK(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var p = Pelicula();
        p.id = appDelegate.elementoId
        p.tipo = appDelegate.elementoTipo
        p.director = txtDirector.text!
        p.estreno = txtEstrenoTemp.text!
        p.temporadas = txtEstrenoTemp.text!
        p.genero = txtGenero.text!
        p.titulo = txtTitulo.text!
        
        let bUrl = "http://45.76.138.67/updateElemento.php?"
        
        let surl = "id=" + p.id + "&tipo=" + p.tipo + "&director=" + p.director + "&estreno=" + p.estreno + "&temporadas=" + p.temporadas + "&genero=" + p.genero + "&titulo=" + p.titulo
        
        // Remplazamos caracteres extraños URL
        let escapedUrl = surl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        print(bUrl + escapedUrl!)
        let url = URL(string: bUrl + escapedUrl!)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("Update OK")
            self.dismiss(animated: true)

        }
        task.resume()
        


    }
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if(appDelegate.elementoTipo == "0"){
            self.txtDirector.isHidden = true
            self.txtTemporadas.isHidden = false
        }
        else{
            self.txtDirector.isHidden = false
            self.txtTemporadas.isHidden = true
        }
        // Recuperamos elemento del servidor mediante ID
        getElementoFromUrl(id: appDelegate.elementoId)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    func getElementoFromUrl(id: String) {
        let url = URL(string: "http://45.76.138.67/getElemento.php?id=" + id)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in

            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [[String: Any]] else {
                print("Not containing JSON")
                return
            }

            
            print(json)
            for element in json{
                var p = Pelicula()
                p.titulo = element["titulo"] as! String
                p.tipo = element["tipo"] as! String
                p.director = element["director"] as! String
                p.genero = element["genero"] as! String
                p.id = element["id"] as! String
                p.estreno = element["estreno"] as! String
                p.temporadas = element["temporadas"] as! String
                p.favorito = element["favorito"] as! String

                // Actualizamos UI
                DispatchQueue.main.async {
                    self.txtTitulo?.text = p.titulo
                    self.txtDirector.text = p.director
                    self.txtGenero.text = p.genero
                    self.txtEstrenoTemp.text = p.estreno
                    self.txtTemporadas.text = p.temporadas
                    if(p.favorito == "1"){
                        self.btnFav.tintColor =   UIColor.blue
                    }
                    else{
                        self.btnFav.tintColor = UIColor.red
                    }
                }
            }
        }
        task.resume()
        
    }
}
