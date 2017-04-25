//
//  ViewController.swift
//  KALCapitan_GiuaKy
//
//  Created by AnhKhoa on 4/25/17.
//  Copyright © 2017 AnhKhoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelDemo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        labelDemo.text = NSLocalizedString("name", comment: "Dat ten")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

