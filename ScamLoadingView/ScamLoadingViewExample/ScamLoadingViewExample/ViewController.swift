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
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let scam = ScamLoadingView(title: "loading...", limitValue: 0.8, arrivalTime: 10.0)
        self.present(scam.loadingViewController, animated: true, completion: nil)
        scam.complete {
            print("execute complete handler!")
//            scam.loadingViewController.dismiss(animated: true, completion: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

