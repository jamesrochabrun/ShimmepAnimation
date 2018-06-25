//
//  ViewController.swift
//  ShimmerAnimation
//
//  Created by James Rochabrun on 6/24/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shimmeredLabel: UILabel! {
        didSet {
            shimmeredLabel.textColor = UIColor(white: 1, alpha: 0.15)
        }
    }
    
    @IBOutlet weak var shimmeTopLabel: UILabel!
    
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shim()
        setUpDisplayLink()
    }
    
    private func shim() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shimmeTopLabel.frame
        
        // angle 45 degrees
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        shimmeTopLabel.layer.mask = gradientLayer
        // animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -shimmeTopLabel.frame.width
        animation.duration = 2
        animation.toValue = shimmeTopLabel.frame.width
        animation.repeatCount = Float.infinity
        gradientLayer.add(animation, forKey: "test")
    }
    
    var startValue: Double = 90
    let endValue: Double = 100
    let animationStartDate = Date()
    let animationDuration: Double = 3.5
    
    lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink.init(target: self, selector: #selector(handleUpdate))
        return displayLink
    }()
    
    private func setUpDisplayLink() {
        displayLink.add(to: .main, forMode: .defaultRunLoopMode)
    }
    
    @objc func handleUpdate() {
    
//        let seconds = Date().timeIntervalSince1970
//        print(seconds)
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        guard elapsedTime < animationDuration else {
            self.counterLabel.text = "\(endValue)"
            displayLink.invalidate()
            return
        }
        
        let percentage = elapsedTime / animationDuration
        let value = startValue + percentage * (endValue - startValue)
        self.counterLabel.text = "\(value)"
    }
}








