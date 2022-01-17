//
//  StandbyView.swift
//  CellularAutomata
//
//  Created by Natalie on 1/16/22.
//

import UIKit

class StandbyView: UIVisualEffectView {

    var text: String?
    
    let activitySpinner: UIActivityIndicatorView = {
       let spin = UIActivityIndicatorView()
        return spin
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    let blurEffect = UIBlurEffect(style: .regular)
    let vibrancy: UIVisualEffectView
    
    init(text: String){
        self.text = text
        self.vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        contentView.addSubview(vibrancy)
        contentView.addSubview(activitySpinner)
        contentView.addSubview(label)
        label.text = text
        activitySpinner.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            self.frame = CGRect(x: superview.frame.size.width/2 - width/2, y: super.frame.height/2 - height/2, width: width, height: height)
            vibrancy.frame = self.bounds
            let activitySpinnerSize: CGFloat = 40
            activitySpinner.frame = CGRect(x: 5,
                                            y: height / 2 - activitySpinnerSize / 2,
                                            width: activitySpinnerSize,
                                            height: activitySpinnerSize)
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activitySpinnerSize + 5,
                                 y: 0,
                                 width: width - activitySpinnerSize - 15,
                                 height: height)
            label.textColor = UIColor.gray
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func show() {
      self.isHidden = false
    }

    func hide() {
      self.isHidden = true
    }
}
