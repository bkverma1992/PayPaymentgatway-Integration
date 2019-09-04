//
//  ViewController.swift
//  PayU
//
//  Created by Yugasalabs-28 on 18/06/2019.
//  Copyright © 2019 Yugasalabs-28. All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation

class ViewController: UIViewController,UIWebViewDelegate {

    var seconf = SecondVC()
    
    var merchantKey = "BDzKfBM4"
    var salt = "oejnQR6HaP"
    var PayUBaseUrl = "https://secure.payu.in"
    var SUCCESS_URL = "https://www.payumoney.com/payments/guestcheckout/#/success"
    var FAILED_URL = "https://www.PayUmoney.com/mobileapp/PayUmoney/failure.php"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var request = NSMutableURLRequest()

    @IBOutlet var webView: UIWebView!
    
    @IBOutlet var amountTF: UITextField!
    @IBAction func paymentBTN(_ sender: Any) {
        
        
         usingcontrollerPayUMoney()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.webView.delegate = self
    //    self.payPayment()

}
    func cancelTransaction( action : UIAlertAction)
    {
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func payPayment() {
        
        var i = arc4random()
        
        let amount = "1"
        let productInfo = "Transport"
        let firstName = "Ashish"
        let email = "ashish@yugasa.com"
        let phone = "8800977115" //8800977115
        let sUrl = "https://www.google.com"
        let fUrl = "https://www.bing.com"
        let service_provider = "payu_paisa"
        let strHash:String = self.sha1(toEncrypt: String.localizedStringWithFormat("%d%@", i, NSDate()));
        let r1 = strHash.range(of: strHash)!
        
        // String range to NSRange:
        let n1 = NSRange(r1, in: strHash)
        print((strHash as NSString).substring(with: n1)) //
        
        // NSRange back to String range:
        let r2 = Range(n1, in: strHash)!
        print(strHash.substring(with: r2))
        let rangeOfHello = Range(n1, in: strHash)!
        let txnid1 = strHash.substring(with: rangeOfHello)
        let hashValue = String.localizedStringWithFormat("%@|%@|%@|%@|%@|%@|||||||||||%@",merchantKey,txnid1,amount,productInfo,firstName,email,salt)
        
        let hash = self.sha1(toEncrypt: hashValue)
        
        let postStr = "txnid="+txnid1+"&key="+merchantKey+"&amount="+amount+"&productinfo="+productInfo+"&firstname="+firstName+"&email="+email+"&phone="+phone+"&surl="+sUrl+"&furl="+fUrl+"&hash="+hash+"&service_provider="+service_provider
        //+"&merchantid="+"6746610"
        let url = NSURL(string: String.localizedStringWithFormat("%@/_payment", PayUBaseUrl))
        
        print("check my url", url as Any, postStr)
        
        let request = NSMutableURLRequest(url: url! as URL)
        
        do {
            
            let postLength = String.localizedStringWithFormat("%lu",postStr.count)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Current-Type")
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.httpBody = postStr.data(using: String.Encoding.utf8)
            webView.loadRequest(request as URLRequest)
        } catch {
            print(error)
            
        }
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        let requestURL = self.webView.request?.url
        let requestString:String = (requestURL?.absoluteString)!
        if (requestString == SUCCESS_URL) {
            print("success payment done")
        }
        else if (requestString == FAILED_URL) {
            print("payment failure")
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("double failure")
    }
    
    func sha1(toEncrypt: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = toEncrypt.data(using: String.Encoding.utf8) {
            let value =  data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
            
        }
        var digestHex = ""
        for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
   
    func usingcontrollerPayUMoney()
    {
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC

        PayUServiceHelper.sharedManager().getPayment(secondViewController, "ashish@yugasa.com", "8800977115", "Ashish", amountTF.text,"test" ,didComplete: { (dict, error) in
            if let error = error {
                print("Error")
            }else {
                print("Sucess")
            }
        }) { (error) in
            print("Payment Process Breaked")
        }
        
        self.navigationController!.pushViewController(secondViewController, animated: true)
    }
}

