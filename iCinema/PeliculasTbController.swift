//
//  PeliculasTbController.swift
//  iCinema
//
//  Created by Maria López Bartual on 4/4/18.
//  Copyright © 2018 ls31360. All rights reserved.
//

import UIKit

struct Pelicula{
    var id = ""
    var tipo = 0
    var titulo = ""
    var director = ""
    var genero = ""
    var estreno = 0
    var temporadas = 0
}
class PeliculasTbController: UITableViewController {    
    var tableArray = [Pelicula] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.parseJSON()
        
        self.setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableArray = [Pelicula] ()

        self.parseJSON()
        
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 60))
        let navItem = UINavigationItem(title: "Peliculas")
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addP))

        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(goSort))


        
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func addP() { // remove @objc for Swift 3
        print("iepo")
        
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
        
        let p = self.tableArray[indexPath.row]
        cell.textLabel?.text = p.titulo + " - " + p.genero + " | " + String(p.estreno)
        print(self.tableArray[indexPath.row].titulo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.elementoId = String(tableArray[indexPath.row].id)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func parseJSON() {
        let url = URL(string: "http://45.76.138.67/getPeliculas.php?tipo=1&direccion=1&order=0")
        
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
                
                self.tableArray.append(p)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        task.resume()
        
    }
}
