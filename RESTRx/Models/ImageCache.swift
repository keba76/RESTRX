//
//  ImageCache.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/4/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import UIKit

class ImageCache: ImageCaching {
    
    var cacheDictionary = Dictionary<String, UIImage>()
    func saveImageToCache(image: UIImage?, url: URL) {
        cacheDictionary[url.absoluteString] = image
    }
    func imageFromCacheWithUrl(url: URL) -> UIImage? {
        return cacheDictionary[url.absoluteString]
    }
}
