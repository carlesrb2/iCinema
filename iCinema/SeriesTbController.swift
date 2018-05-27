//
//  SeriesTbController.swift
//  iCinema
//
//  Created by Maria López Bartual on 4/4/18.
//  Copyright © 2018 ls31360. All rights reserved.
//

import UIKit

class SeriesTbController: UITableViewController {
    var tableArray = [Pelicula] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creamos el nav
        self.setNavigationBar()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.elementoTipo = "0"
        
        tableArray = [Pelicula] ()
        
        // Recuperamos JSON con las peliculas y cargamos el tableV
        self.peliculasFromUrl()
        
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 60))
        let navItem = UINavigationItem(title: "Series")
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addP))
        
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goSort))
        
        
        
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
   
    @objc func addP() { // remove @objc for Swift 3
        print("add")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.elementoId = "0"
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "editController") as! editViewController
        self.present(next, animated: true, completion: nil)
    }
    
    
    @objc func goSort() { // remove @objc for Swift 3
        print("sort")
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "sortViewController") as! SortViewController
        self.present(next, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        if(indexPath.row == 0){
            return cell
        }
        else{
            let p = self.tableArray[indexPath.row - 1]
            cell.textLabel?.text = p.titulo + " - " + p.genero + " | " + String(p.estreno)
            print(self.tableArray[indexPath.row].titulo)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.elementoId = String(tableArray[indexPath.row - 1].id)
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "editController") as! editViewController
        self.present(next, animated: true, completion: nil)
    }
    
    
    func peliculasFromUrl() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let url = URL(string: "http://45.76.138.67/getPeliculas.php?tipo=0&direccion=" + appDelegate.sortDir + "&order=" + appDelegate.sortType + "&favorito=" + appDelegate.favFilter)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [[String: Any]] else {
                print("Not containing JSON")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                return
            }
            
            //if let array = json[0] as? [String:String] {
            //  self.tableArray = array["titulo"]
            //}
            
            print(json)
            for element in json{
                var p = Pelicula()
                p.titulo = element["titulo"] as! String
                p.director = element["director"] as! String
                p.genero = element["genero"] as! String
                p.id = element["id"] as! String
                p.estreno = element["estreno"] as! String
                
                self.tableArray.append(p)
            }
            let p = Pelicula()
            
            // Hack rapido para solucionar primera fila oculta bajo el nav
            self.tableArray.append(p)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
        
    }
    
}
