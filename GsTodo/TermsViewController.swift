//
//  TermsViewController.swift
//  GsTodo
//
//  Created by Kouichiro Furusho on 2021/07/31.
//  Copyright © 2021 yamamototatsuya. All rights reserved.
//

import UIKit
import WebKit

class TermsViewController: UIViewController {

    
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //表示したいwebページのURLを入れてローディング
        self.loadWebView("https://policies.google.com/terms?hl=ja")
        //スワイプで進む、戻るを有効にする
        self.wkWebView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }

    //wkWebViewの読み込み
    func loadWebView(_ urlString:String){
        //string型の引数の値をURL型にキャスト
        let myURL = URL(string: urlString)
        //URL型をURLRequest型にキャスト
        let myRequest = URLRequest(url: myURL!)
        //ロード
        self.wkWebView.load(myRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
