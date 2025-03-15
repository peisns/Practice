//
//  ViewController.swift
//  UINavigationController
//
//  Created by air on 3/15/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let baseViewController = storyboard.instantiateViewController(withIdentifier: "BaseViewController")
        let baseViewControllerWithNavi = UINavigationController(rootViewController: baseViewController)
        baseViewControllerWithNavi.modalPresentationStyle = .fullScreen
        present(baseViewControllerWithNavi, animated: false)
    }
}

class BaseViewController: UIViewController {
    
    @IBOutlet weak var isNavigationBarHiddenLabel: UILabel!
    @IBOutlet weak var navigationBarIsHiddenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "BaseViewController"
        view.backgroundColor = .systemGray6
        
    }
        
    
    @IBAction func isNavigationBarHiddenButtonClicked(_ sender: UIButton) {
        navigationController?.isNavigationBarHidden.toggle()
        isNavigationBarHiddenLabel.text = navigationController?.isNavigationBarHidden  == true ? "true" : "false"
        navigationBarIsHiddenLabel.text = navigationController?.navigationBar.isHidden == true ? "true" : "false"
        
    }
    
    @IBAction func navigationBarIsHiddenButtonClicked(_ sender: UIButton) {
        navigationController?.navigationBar.isHidden.toggle()
        navigationBarIsHiddenLabel.text = navigationController?.navigationBar.isHidden == true ? "true" : "false"
        isNavigationBarHiddenLabel.text = navigationController?.isNavigationBarHidden  == true ? "true" : "false"

    }
    
    @IBAction func setNavigtionBarHiddenTrueButtonClicked(_ sender: UIButton) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationBarIsHiddenLabel.text = navigationController?.navigationBar.isHidden == true ? "true" : "false"
        isNavigationBarHiddenLabel.text = navigationController?.isNavigationBarHidden  == true ? "true" : "false"
    }
    
    @IBAction func setNavigtionBarHiddenFalseButtonClicked(_ sender: UIButton) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationBarIsHiddenLabel.text = navigationController?.navigationBar.isHidden == true ? "true" : "false"
        isNavigationBarHiddenLabel.text = navigationController?.isNavigationBarHidden  == true ? "true" : "false"

    }
}

