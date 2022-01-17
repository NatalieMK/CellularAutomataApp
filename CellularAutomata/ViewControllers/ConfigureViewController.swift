//
//  ConfigureViewController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/13/22.
//

import UIKit

protocol ConfigureViewControllerDelegate {
    func didSelectColor(pColor: UIColor, nColor: UIColor)
    func didSelectRule(rule: String)
    func didTapCreate(patternArray: [Pattern])
}

class ConfigureViewController: UIViewController, UIColorPickerViewControllerDelegate {

    var configureDelegate: ConfigureViewControllerDelegate!
    
    // View controllers:
    let positive = UIColorPickerViewController()
    let negative = UIColorPickerViewController()
    let spinner = StandbyView(text: "Generating")
    
    var ruleControl = RuleController()
    var pattern = Pattern()
    var patterns: [Pattern] = []
    
    var rules = ["Rule 30", "Rule 90", "Rule 110"]
    
    // MARK: - UI Components
    let ruleSegments: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Rule 30", "Rule 90", "Rule 110"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    let markLocationSegments: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Left", "Center", "Right"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let positiveColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Primary Color", for: .normal)
        button.addTarget(self, action: #selector(choosePositive), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let roundsLabel: UILabel = {
        let label = UILabel()
        label.text = "Run for"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roundsLabelTwo: UILabel = {
        let label = UILabel()
        label.text = "Rounds"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Note: Larger numbers of rounds may take longer to generate."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    let roundsPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = nil
        picker.translatesAutoresizingMaskIntoConstraints = false
       return picker
    }()
    
    let negativeColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Secondary Color", for: .normal)
        button.addTarget(self, action: #selector(chooseNegative), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        roundsPicker.delegate = self
        roundsPicker.dataSource = self
        ruleSegments.selectedSegmentIndex = 0
        
        view.addSubview(goButton)
        view.addSubview(positiveColorPickerButton)
        view.addSubview(roundsPicker)
        view.addSubview(roundsLabel)
        view.addSubview(roundsLabelTwo)
        view.addSubview(negativeColorPickerButton)
        view.addSubview(spinner)
        view.addSubview(ruleSegments)
        
        spinner.center = view.center
        
        spinner.hide()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        warningLabel.frame = CGRect(x: 10, y: spinner.top - 100, width: view.width - 10, height: 100)
        autoLayoutConstraints()
    }
    
    @objc func didTapButton(){
        spinner.show()
        var rounds = roundsPicker.selectedRow(inComponent: 0)
        if rounds > 40 {
            view.addSubview(warningLabel)
        }
        configureDelegate.didSelectColor(pColor: positive.selectedColor, nColor: negative.selectedColor)
        let ruleIndex = ruleSegments.selectedSegmentIndex
        configureDelegate.didSelectRule(rule: rules[ruleIndex])
        DispatchQueue.global().async {
            self.calculatePatterns(rounds: rounds, rule: ruleIndex)
            DispatchQueue.main.async { [self] in
                self.configureDelegate.didTapCreate(patternArray: self.patterns)
         
                dismiss(animated: false, completion: nil)
        }
        }
    }
    
    func calculatePatterns(rounds: Int, rule: Int){
        patterns = []
        pattern.padPattern(count: rounds)
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: pattern.cells.count.middleValue)
        switch (rule){
            // Rule 90 chosen
        case 1:
            if rounds != 0 {
                for i in 0 ... (rounds - 1){
                    patterns.append(ruleControl.updateByNumberOfStates(count: i, pattern: pattern, rule: ruleControl.rule90(cell:)))
                }
            }
            // Rule 110 chosen
        case 2:
            if rounds != 0{
                for i in 0 ... (rounds - 1){
                    patterns.append(ruleControl.updateByNumberOfStates(count: i, pattern: pattern, rule: ruleControl.rule110(cell:)))
                }
            }
            // Rule 30 by default
        default:
            if (rounds != 0){
                for i in 0...(rounds - 1) {
                    patterns.append(ruleControl.updateByNumberOfStates(count: i, pattern: pattern, rule: ruleControl.rule30(cell:)))
                }
            }
        }
    }
    
    @objc func choosePositive(){
        positive.delegate = self
        present(positive, animated: true)
    }
    
    @objc func chooseNegative(){
        negative.delegate = self
        present(negative, animated: true)
    }
}

extension ConfigureViewController {
    
    func autoLayoutConstraints(){
        // Top of view
        
        view.autoLayoutBasedOnView(view: ruleSegments, topOffset: 50, bottomOffset: nil, leadingOffset: 10, trailingOffset: 10)
        
        view.autoLayoutBasedOnView(view: positiveColorPickerButton, topOffset: nil, bottomOffset: nil, leadingOffset: 10, trailingOffset: nil)
        view.autoLayoutBasedOnAnchors(view: positiveColorPickerButton, newTopAnchor: nil, newBottomAnchor: nil, newLeftAnchor: nil, newRightAnchor: view.centerXAnchor, padding: 0)
        positiveColorPickerButton.bottomAnchor.constraint(equalTo: goButton.topAnchor, constant: -100).isActive = true
        view.autoLayoutBasedOnView(view: negativeColorPickerButton, topOffset: nil, bottomOffset: nil, leadingOffset: nil, trailingOffset: 10)
        view.autoLayoutBasedOnAnchors(view: negativeColorPickerButton, newTopAnchor: nil, newBottomAnchor: positiveColorPickerButton.bottomAnchor, newLeftAnchor: positiveColorPickerButton.rightAnchor, newRightAnchor: nil, padding: 0)
        
        view.autoLayoutBasedOnView(view: roundsLabel, topOffset: nil, bottomOffset: 50 + goButton.height *  2, leadingOffset: 50, trailingOffset: nil)
        view.autoLayoutBasedOnAnchors(view: roundsPicker, newTopAnchor: nil, newBottomAnchor: goButton.topAnchor, newLeftAnchor: roundsLabel.rightAnchor, newRightAnchor: roundsLabelTwo.leftAnchor, padding: 0)
        view.autoLayoutBasedOnView(view: roundsLabelTwo, topOffset: nil, bottomOffset: 50 + goButton.height * 2, leadingOffset: nil, trailingOffset: 50)
        roundsPicker.heightAnchor.constraint(equalToConstant: 99).isActive = true
        
        view.autoLayoutBasedOnView(view: goButton, topOffset: nil, bottomOffset: 50, leadingOffset: 10, trailingOffset: 10)
        // Bottom of view
    }
}

extension ConfigureViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
}
