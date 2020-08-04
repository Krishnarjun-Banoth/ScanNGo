//
//  ProductDetailsVC.swift
//  ScanAndGo
//
//  Created by Krishnarjun Banoth on 02/08/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    var productData: QRData?
    
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        processData()
    }
    
    func processData() {
        guard let data = productData else{ return }
           
        productImg.imageFromURL(urlString: data.imgUrl)
        productName.text = data.title
        priceLbl.text = "$" + String(data.pricePerQuantity)
        
    }
}
