//
//  ViewController.swift
//  ProgressButton
//
//  Created by buildbook on 3/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressButton: ProgressButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressButton.progressBar.progress = 0.4
    }


}

