//
//  ConfigureSettingsInformationView.swift
//  CellularAutomata
//
//  Created by Natalie on 1/16/22.
//

import Foundation
import UIKit

public class ConfigureSettingsInformationView: UIViewController {
    
    var ruleLabelText = " "
    var primaryColorText = " "
    var secondaryColorText = " "
    
    let fontAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "KohinoorBangla-Semibold", size: 18),
        .backgroundColor: UIColor.clear,
        .foregroundColor: UIColor.white
    ]
    
    var primaryColor: UIColor = .white
    var secondaryColor: UIColor = .white
    
    let ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "Rule in use: "
        return label
    }()
    
    let primaryColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Primary color: "
        return label
    }()
    
    let secondaryColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Secondary color: "
        return label
    }()
    
    let primarySwatch = UILabel()
    let secondarySwatch = UILabel()
    
    public func setUp(){
        view.backgroundColor = .lightGray
        ruleLabel.attributedText = NSAttributedString(string: ruleLabel.text! + ruleLabelText, attributes: fontAttributes)
        primaryColorLabel.attributedText = NSAttributedString(string: primaryColorLabel.text! + primaryColorText, attributes: fontAttributes)
        secondaryColorLabel.attributedText = NSAttributedString(string: secondaryColorLabel.text! + secondaryColorText, attributes: fontAttributes)
        primarySwatch.backgroundColor = primaryColor
        secondarySwatch.backgroundColor = secondaryColor
        view.addSubview(secondarySwatch)
        view.addSubview(primarySwatch)
        view.addSubview(ruleLabel)
        view.addSubview(primaryColorLabel)
        view.addSubview(secondaryColorLabel)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ruleLabel.frame = CGRect(x: 10, y: 10, width: view.width, height: view.height/4)
        primaryColorLabel.frame = CGRect(x: 10, y: view.height/4 + 20, width: view.width/2 - 10, height: view.height/4)
        secondaryColorLabel.frame = CGRect(x: view.width/2, y: primaryColorLabel.frame.minY, width: view.width/2 - 10, height: view.height/4)
        primarySwatch.frame = CGRect(x: view.width/6, y: view.height/2, width: view.width/5, height: view.width/5)
        secondarySwatch.frame = CGRect(x: view.width * 4/6, y: view.height/2, width: view.width/5, height: view.width/5)
    }
}
