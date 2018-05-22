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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAnyAscClick(_ sender: Any) {
        appDelegate.sortType = "3"
        self.dismiss(animated: true)

    }
    @IBAction func btnNombreDescClick(_ sender: Any) {
        appDelegate.sortType = "2"
        self.dismiss(animated: true)

    }
    @IBAction func btnNombreAscClick(_ sender: Any) {
        appDelegate.sortType = "1"
        self.dismiss(animated: true)

    }
    @IBAction func btnAnyDescClick(_ sender: Any) {
        appDelegate.sortType = "4"
        self.dismiss(animated: true)

    }
    @IBAction func btnGeneroDescClick(_ sender: Any) {
        appDelegate.sortType = "6"
        self.dismiss(animated: true)

    }
    @IBAction func btnGeneroAscClick(_ sender: Any) {
        appDelegate.sortType = "5"
        self.dismiss(animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
