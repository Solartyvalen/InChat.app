//
//  Extinsion .swift
//  InChat
//
//  Created by Mac on 12.10.2023.
//

import UIKit

var imageCache = [String: UIImage]()

extension UIImageView {
    
    func loadImage(with urlString: String) {
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let  url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Faild to load image: ", err.localizedDescription)
                return
            }
            
            guard let imageData = data else {return}
            
            let profileImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = profileImage
            
            DispatchQueue.main.async {
                self.image = profileImage
            }
        }.resume()
    }
}
