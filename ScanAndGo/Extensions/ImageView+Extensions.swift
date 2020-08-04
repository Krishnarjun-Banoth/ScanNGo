

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    public func imageFromURL(urlString: String) {
        let url = URL(string: urlString)
        if url == nil {
            self.image = UIImage.init(named: "default")
            return
        }
        self.image = nil
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }
        print(urlString)
        self.image = UIImage.init(named: "default")
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let image = UIImage(data: data!) {
                    print("Image Downloaded")
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            })
            
        }).resume()
    }
}

