//
//  ScamLoadingViewController.swift
//  ScamLoadingViewExample
//
//  Created by 曽和修平 on 2017/03/03.
//  Copyright © 2017年 ShuheiSowa. All rights reserved.
//

import UIKit

class ScamLoadingView {
    
    public let loadingViewController:UIAlertController
    private let percentageLabel = UILabel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    private let limitValue:Float
    private let arrivalTime:Float
    
    private var timer:Timer?
    private var currentTime:Float = 0.0
    private var completeHandler:(()->())?
    private var hasCompletedTimer = false
    
    public init(title:String,limitValue:Float,arrivalTime:Float) {
        loadingViewController = UIAlertController(title: title, message:"\n\n", preferredStyle: .alert)
        
        self.limitValue = limitValue
        self.arrivalTime = arrivalTime
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        loadingViewController.view.addSubview(progressView)
        
        percentageLabel.textAlignment = .center
        loadingViewController.view.addSubview(percentageLabel)
        setupConstraints()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(incrementProgress), userInfo: nil, repeats: true)
    }
    
    @objc private func incrementProgress(){
        progressView.progress += limitValue/(arrivalTime * 10.0)
        setPercentageLabel()
        
        currentTime += 0.1
        if currentTime > arrivalTime - 0.001{
            hasCompletedTimer = true
            executeCompleteHandler()
            if let t = timer{
                t.invalidate()
            }
        }
    }
    
    private func setupConstraints(){
        let views = ["progress":progressView,"percentagelabel":percentageLabel]
        let horizonFormat = "H:|-[progress]-|"
        let horizonConstraints = NSLayoutConstraint.constraints(withVisualFormat: horizonFormat, options: .alignAllTop, metrics: nil, views: views)
        
        let verticalFormat = "V:[progress]-10-|"
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: verticalFormat, options:.alignAllTop, metrics: nil, views: views)
        
        loadingViewController.view.addConstraints(horizonConstraints + verticalConstraints)
        
        let percentageLabelHorizonConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[percentagelabel]-|", options: .alignAllTop, metrics: nil, views: views)
        let percentageLabelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[percentagelabel]-25-|", options: .alignAllTop, metrics: nil, views: views)
        
        loadingViewController.view.addConstraints(percentageLabelHorizonConstraints + percentageLabelVerticalConstraints)
    }
    
    private func setPercentageLabel(){
        percentageLabel.text = String(format: "%.0f %", progressView.progress * 100.0) + "%"
    }
    private func executeCompleteHandler(){
        if hasCompletedTimer{
            if let handler = completeHandler{
                progressView.progress = 1.0
                setPercentageLabel()
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    handler()
                }
            }
        }
    }
    
    public func complete(handler: @escaping ()->()){
        completeHandler = handler
        executeCompleteHandler()
    }
    
    
}
