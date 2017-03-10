//
//  ViewController.swift
//  ScamLoadingViewExample
//
//  Created by 曽和修平 on 2017/03/03.
//  Copyright © 2017年 ShuheiSowa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func executeOneShotProcess(_ sender: UIButton) {
        let scam = ScamLoadingView(title: "loading...", limitValue: 0.8, arrivalTime: 10.0)
        self.present(scam.loadingViewController, animated: true, completion: nil)
        
        scam.complete {
            scam.loadingViewController.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func executeTimeConsumingProcess(_ sender: UIButton) {
        let scam = ScamLoadingView(title: "loading...", limitValue: 0.8, arrivalTime: 1.0)
        self.present(scam.loadingViewController, animated: false, completion: nil)
        
        DispatchQueue.global(qos: .default).async {
            Thread.sleep(forTimeInterval: 10.0)
            DispatchQueue.main.async {
                scam.complete {
                    scam.loadingViewController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

