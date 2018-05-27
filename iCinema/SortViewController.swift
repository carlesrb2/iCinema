//
//  SortViewController.swift
//  iCinema
//
//  Created by carles on 22/5/18.
//  Copyright © 2018 ls31360. All rights reserved.
//

import UIKit

class SortViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        if(appDelegate.favFilter == "favorito"){
            self.btnFav.tintColor = UIColor.blue
        }
        else{
            self.btnFav.tintColor = UIColor.red
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var btnFav: UIButton!
    @IBAction func setFav(_ sender: Any) {
        if(appDelegate.favFilter == "favorito"){
            appDelegate.favFilter = "1"
        }
        else{
            appDelegate.favFilter = "favorito"
        }
        self.dismiss(animated: true)

    }
    @IBAction func btnAnyAscClick(_ sender: Any) {
        appDelegate.sortType = "2"
        appDelegate.sortDir = "1"

        self.dismiss(animated: true)

    }
    @IBAction func btnNombreDescClick(_ sender: Any) {
        appDelegate.sortType = "1"
        appDelegate.sortDir = "0"

        self.dismiss(animated: true)

    }
    @IBAction func btnNombreAscClick(_ sender: Any) {
        appDelegate.sortType = "1"
        appDelegate.sortDir = "1"

        self.dismiss(animated: true)

    }
    @IBAction func btnAnyDescClick(_ sender: Any) {
        appDelegate.sortType = "2"
        appDelegate.sortDir = "0"

        self.dismiss(animated: true)

    }
    @IBAction func btnGeneroDescClick(_ sender: Any) {
        appDelegate.sortType = "3"
        appDelegate.sortDir = "0"

        self.dismiss(animated: true)

    }
    @IBAction func btnGeneroAscClick(_ sender: Any) {
        appDelegate.sortType = "3"
        appDelegate.sortDir = "1"

        self.dismiss(animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
