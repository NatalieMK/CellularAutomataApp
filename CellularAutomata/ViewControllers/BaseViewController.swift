//
//  BaseViewController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/12/22.
//

import UIKit

class BaseViewController: UIViewController {

    var patternView = SimulationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let patternNav = UINavigationController(rootViewController: patternView)
        patternNav.title = "Simulator"
        addChild(patternNav)
        view.addSubview(patternNav.view)
        patternNav.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    


}


    
    
    
    
