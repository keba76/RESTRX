//
//  ViewModel.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/3/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class InstagramData: HTTPClient {
    var photoSmall: String?
    var photoStandart: String?
    var likes: Int?
    init(photoSm: String = "", likes: Int = 0, photoSt: String = "") {
        self.photoSmall = photoSm
        self.photoStandart = photoSt
        self.likes = likes
    }
    var cacheDictionary = Dictionary<String, UIImage>()
    func saveImageToCache(image: UIImage?, url: URL) {
        cacheDictionary[url.absoluteString] = image
    }
    func imageFromCacheWithUrl(url: URL) -> UIImage? {
        return cacheDictionary[url.absoluteString]
    }
    
}

class ViewModel {
    
    var searchText = Variable("")
    var token: String?
    let api: APInstagram
    var data: Driver<[InstagramData]>
    
    init?(api: APInstagram, token: String?) {
        self.api = api
        self.token = token
        data = self.searchText.asObservable()
        .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest {api.getData($0, token)}
        .asDriver(onErrorJustReturn : [])
    }
}
