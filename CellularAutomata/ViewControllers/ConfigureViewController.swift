//
//  ConfigureViewController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/13/22.
//

import UIKit

protocol ConfigureViewControllerDelegate {
    func didSelectColor(pColor: UIColor, nColor: UIColor)
    func didSelectRounds(numberOfRounds: Int)
    func didTapCreate()
}

class ConfigureViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    var configureDelegate: ConfigureViewControllerDelegate!
    
    let positive = UIColorPickerViewController()
    let negative = UIColorPickerViewController()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(runSimulator), for: .touchUpInside)
        return button
    }()
    
    let positiveColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Primary Color", for: .normal)
        button.addTarget(self, action: #selector(choosePositive), for: .touchUpInside)
        return button
    }()
    
    let roundsLabel: UILabel = {
        let label = UILabel()
        label.text = "Run for"
        return label
    }()
    
    let roundsLabelTwo: UILabel = {
        let label = UILabel()
        label.text = "Rounds"
        return label
    }()
    
    let roundsPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
       return picker
    }()
    
    let negativeColorPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemCyan
        button.setTitle("Secondary Color", for: .normal)
        button.addTarget(self, action: #selector(chooseNegative), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        roundsPicker.delegate = self
        roundsPicker.dataSource = self
        view.addSubview(goButton)
        view.addSubview(positiveColorPickerButton)
        view.addSubview(roundsPicker)
        view.addSubview(roundsLabel)
        view.addSubview(roundsLabelTwo)
        view.addSubview(negativeColorPickerButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        goButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        positiveColorPickerButton.frame = CGRect(x: 100, y:300, width: 200, height: 50)
        negativeColorPickerButton.frame = CGRect(x: 100, y:500, width: 200, height: 50)
        roundsPicker.frame = CGRect(x: 100, y: 600, width: 100, height: 50)
        roundsLabel.frame = CGRect(x: 50, y:600, width: 100, height: 50)
        roundsLabelTwo.frame = CGRect(x: 200, y: 600, width: 100, height: 50)
    }
    
    @objc func runSimulator(){
        configureDelegate.didSelectColor(pColor: positive.selectedColor, nColor: negative.selectedColor)
        configureDelegate.didSelectRounds(numberOfRounds: roundsPicker.selectedRow(inComponent: 0))
        configureDelegate.didTapCreate()
        dismiss(animated: false, completion: nil)
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
