//
//  ImageCaching.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/4/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCaching {
    func saveImageToCache(image: UIImage?, url: URL)
    func imageFromCacheWithUrl(url: URL) -> UIImage?
}
