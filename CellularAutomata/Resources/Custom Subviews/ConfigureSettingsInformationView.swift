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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let primaryColorLabel: UILabel = {
        let label = UILabel()
        label.text = "Primary color: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondaryColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Secondary color: "
        return label
    }()
    
    let primarySwatch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondarySwatch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func setUp(){
        view.backgroundColor = .lightGray
        ruleLabel.attributedText = NSAttributedString(string: "Rule in use: " + ruleLabelText, attributes: fontAttributes)
        secondaryColorLabel.attributedText = NSAttributedString(string: secondaryColorLabel.text!, attributes: fontAttributes)
        primaryColorLabel.attributedText = NSAttributedString(string: primaryColorLabel.text!, attributes: fontAttributes)
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
        view.autoLayoutBasedOnView(view: ruleLabel, topOffset: 10, bottomOffset: nil, leadingOffset: 10, trailingOffset: 10)
        view.autoLayoutBasedOnAnchors(view: primaryColorLabel, newTopAnchor: ruleLabel.bottomAnchor, newBottomAnchor: nil, newLeftAnchor: ruleLabel.leftAnchor, newRightAnchor: ruleLabel.rightAnchor, padding: 10)
        view.autoLayoutBasedOnAnchors(view: secondaryColorLabel, newTopAnchor: ruleLabel.bottomAnchor, newBottomAnchor: nil, newLeftAnchor: view.centerXAnchor, newRightAnchor: nil, padding: 10)
        
        view.autoLayoutBasedOnView(view: primarySwatch, topOffset: 100, bottomOffset: 10, leadingOffset: nil, trailingOffset: nil)
        view.autoLayoutBasedOnAnchors(view: primarySwatch, newTopAnchor: primaryColorLabel.bottomAnchor, newBottomAnchor: nil, newLeftAnchor: nil, newRightAnchor: view.centerXAnchor, padding: 10)
        primarySwatch.widthAnchor.constraint(equalTo: primarySwatch.heightAnchor).isActive = true
        
        view.autoLayoutBasedOnView(view: secondarySwatch, topOffset: 100, bottomOffset: 10, leadingOffset: nil, trailingOffset: 10)
        view.autoLayoutBasedOnAnchors(view: secondarySwatch, newTopAnchor: secondaryColorLabel.bottomAnchor, newBottomAnchor: nil, newLeftAnchor: nil, newRightAnchor: nil, padding: 10)
        secondarySwatch.widthAnchor.constraint(equalTo: secondarySwatch.heightAnchor).isActive = true
    }
}
