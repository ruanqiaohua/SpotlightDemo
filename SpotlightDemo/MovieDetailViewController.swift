//
//  MovieDetailViewController.swift
//  SpotlightDemo
//
//  Created by 阮巧华 on 2017/3/7.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var webUrl:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if webUrl != nil {
            let request = URLRequest(url:webUrl!)
            webView.loadRequest(request)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
