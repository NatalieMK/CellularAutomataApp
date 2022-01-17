//
//  ViewController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/13/22.
//

import UIKit

class SimulationViewController: UIViewController {
    
    // ConfigureController variables
    var positiveColor = UIColor.lightGray
    var negativeColor = UIColor.lightGray
    var ruleName: String = ""

    var ruleControl = RuleController()
    var pattern = Pattern()
    var patterns: [Pattern] = []
    
    let simView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let configureController = ConfigureViewController()
    let configureInformation = ConfigureSettingsInformationView()
    
    let fontAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont(name: "KohinoorBangla-Semibold", size: 18),
        .backgroundColor: UIColor.clear,
        .foregroundColor: UIColor.gray
    ]
    
    let configureLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openConfig))
        configureLabel.attributedText = NSAttributedString(string: "Create Simulation ->", attributes: fontAttributes)
        formatSimulator()
        configureLabel.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureController.configureDelegate = self
        view.addSubview(configureLabel)
        view.addSubview(configureInformation.view)
    }
    
    @objc func openConfig(){
        let configure = ConfigureViewController()
        configure.configureDelegate = self
        present(configure, animated: true)
    }
    
    func layoutViewControllers(){
        configureInformation.view.translatesAutoresizingMaskIntoConstraints = false
        view.autoLayoutBasedOnView(view: configureInformation.view, topOffset: 100, bottomOffset: nil, leadingOffset: 10, trailingOffset: 10)
        
        configureInformation.view.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureLabel.frame = CGRect(x: 140, y: 20, width: 300, height: 100)
        layoutViewControllers()
    }
    
    func formatSimulator(){
        pattern = Pattern()
        let simView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        pattern.padPattern(count: patterns.count)
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: pattern.cells.count.middleValue)
        simView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        simView.dataSource = self
        simView.delegate = self
        simView.backgroundColor = negativeColor
        simView.frame = CGRect(x: 10, y: 300, width: view.width - 20, height: view.width - 30)
        simView.translatesAutoresizingMaskIntoConstraints = false

        configureLabel.isHidden = true
        configureInformation.primaryColor = positiveColor
        configureInformation.secondaryColor = negativeColor
        configureInformation.ruleLabelText = ruleName
        configureInformation.setUp()
        view.addSubview(simView)
    }
}
    
extension SimulationViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pattern.cells.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.width/CGFloat(pattern.cells.count)
        let cellHeight: CGFloat = 2 * collectionView.height/CGFloat(pattern.cells.count)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return patterns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if (patterns[indexPath.section].cells[indexPath.row].currentCellState){
            cell.backgroundColor = positiveColor
        } else {
        cell.backgroundColor = negativeColor
        }
        return cell
    }
}

extension SimulationViewController: ConfigureViewControllerDelegate {
    
    func didSelectRule(rule: String) {
        ruleName = rule
    }
    
    func didSelectColor(pColor: UIColor, nColor: UIColor) {
        positiveColor = pColor
        negativeColor = nColor
    }

    func didTapCreate(patternArray: [Pattern]) {
        patterns = patternArray
        formatSimulator()
    }
}



