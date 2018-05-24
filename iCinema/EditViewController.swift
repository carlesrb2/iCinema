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
    
    @IBAction func eliminarClick(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let url = URL(string: "http://45.76.138.67/deleteElemento.php?id=" + appDelegate.elementoId)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("Delete OK")
            
        }
        task.resume()
        
        
        self.dismiss(animated: true)
    }
    @IBOutlet weak var txtDirector: UITextField!
    @IBAction func btnCLICK(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var p = Pelicula();
        p.id = appDelegate.elementoId
        p.tipo = appDelegate.elementoTipo
        p.director = "test"
        p.estreno = "2000"
        p.temporadas = "0"
        p.genero = "teest"
        
        let url = URL(string: "http://45.76.138.67/updateElemento.php?id=" + p.id + "&tipo=" + p.tipo + "&director=" + p.director + "&estreno=" + p.estreno + "&temporadas=" + p.temporadas + "&genero=" + p.genero)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            print("Update OK")
            
        }
        task.resume()
        

        self.dismiss(animated: true)

    }
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
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
                p.director = element["director"] as! String
                p.genero = element["genero"] as! String
                p.id = element["id"] as! String
                
                // Actualizamos UI
                DispatchQueue.main.async {
                    self.txtTitulo?.text = p.titulo
                    self.txtDirector.text = p.director

                }
            }
        }
        task.resume()
        
    }
}
