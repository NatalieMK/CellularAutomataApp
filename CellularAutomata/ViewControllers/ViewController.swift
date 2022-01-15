//
//  ViewController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/13/22.
//

import UIKit


class ViewController: UIViewController{
    
    // ConfigureController variables
    var positiveColor: UIColor!
    var negativeColor: UIColor!
    var rounds: Int!
    
    
    var ruleControl = RuleController()
    var pattern = Pattern()
    var patterns: [Pattern] = []
    
    let configureLabel: UILabel = {
        let label = UILabel()
        label.text = "Simulation Settings => "
        return label
    }()
    
    let configureController = ConfigureViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openConfig))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureController.configureDelegate = self
        view.addSubview(configureLabel)
    }
    
    @objc func openConfig(){
        let configure = ConfigureViewController()
        configure.configureDelegate = self
        present(configure, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLabel.frame = CGRect(x: 150, y: 30, width: 300, height: 100)
    }
    
    func formatSimulator(){
        patterns = []
        let simView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        pattern = ruleControl.padPattern(pattern: Pattern(), count: rounds)
        pattern = ruleControl.markPattern(pattern: pattern, markedIndex: pattern.cells.count.middleValue)
        if (rounds != 0){
        for i in 0...(rounds - 1) {
            patterns.append(ruleControl.advanceByNumberOfStates(count: i, pattern: pattern))
        }
        }
        
        simView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        simView.backgroundColor = negativeColor
        simView.dataSource = self
        simView.delegate = self
        simView.frame = view.frame
        configureLabel.isHidden = true
        view.addSubview(simView)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pattern.cells.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = view.frame.width/CGFloat(pattern.cells.count)
        let cellHeight: CGFloat = (view.frame.height - 100)/CGFloat(rounds)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rounds ?? 0
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

extension ViewController: ConfigureViewControllerDelegate {
    func didSelectColor(pColor: UIColor, nColor: UIColor) {
        positiveColor = pColor
        negativeColor = nColor
    }
    
    func didSelectRounds(numberOfRounds: Int) {
        rounds = numberOfRounds
    }
    
    func didTapCreate() {
        formatSimulator()
    }
    
}



