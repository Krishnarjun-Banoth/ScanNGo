//
//  HomeViewController.swift
//  ScanAndGo
//
//  Created by Krishnarjun Banoth on 02/08/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AlertDisplayer {

    @IBOutlet weak var scannerView: QRScannerView! {
            didSet {
                scannerView.delegate = self
            }
        }
        @IBOutlet weak var scanButton: UIButton! {
            didSet {
                scanButton.setTitle("STOP", for: .normal)
            }
        }
        
        var qrData: QRData? = nil {
            didSet {
                if let qrData = qrData {
                    navigationToDetailedView(with: qrData)
                }
            }
        }
        
        override func viewDidLoad() {
            self.navigationItem.title = "SCAN and GO"
            super.viewDidLoad()
        }
        
     
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
           
            if !scannerView.isRunning {
                scannerView.startScanning()
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            if !scannerView.isRunning {
                scannerView.stopScanning()
            }
        }

        @IBAction func scanButtonAction(_ sender: UIButton) {
            scannerView.isRunning ? scannerView.stopScanning() : scannerView.startScanning()
            let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
            sender.setTitle(buttonTitle, for: .normal)
            
            //Manually preparing the data for testing purpose: needs to be removed for production app
            
            let data = QRData(codeString: "", title: "Stunning mobile", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/3/33/Tourism_in_London795.jpg", pricePerQuantity: 135)
            self.qrData = data
            
        }
    }



    extension HomeViewController: QRScannerViewDelegate {
        func qrScanningDidStop() {
            let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
            scanButton.setTitle(buttonTitle, for: .normal)
        }
        
        func qrScanningDidFail() {
             let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert: UIAlertAction!) in
                                    self.dismiss(animated: false, completion: nil)
                                })
            displayAlert(with: "Error", message: "Scanning Failed. Please try again", actions: [okAction])
        }
        
        func qrScanningSucceededWithCode(_ str: String?) {
            self.qrData = QRData(codeString: str ?? "", title: "", imgUrl: "")
        }
        
    }


    extension HomeViewController {
        func navigationToDetailedView(with data: QRData) {
                    if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductDetailsVC") as? ProductDetailsVC {
                        vc.productData = self.qrData
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
            }
    }

