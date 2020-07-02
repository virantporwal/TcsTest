//
//  CustomImageView.swift
//  TCSTEst
//
//  Created by Virant Porwal on 01/07/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

// Store all images from server in chache and show that on imageView
class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            guard let httpResponse = respones as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return   print("Not a proper HTTPURLResponse or statusCode")
            }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
            
        }).resume()
    }
}

