//
//  APInstagram.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/3/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class APInstagram {
    
    func getData(_ tag: String, _ id: String?) -> Observable<[InstagramData]> {
        guard !tag.isEmpty, id != nil, let url = URL(string: "https://api.instagram.com/v1/tags/\(tag.removeSpace())/media/recent?access_token=\(id!)") else {return Observable.just([])}
        return URLSession.shared
            .rx.json(url: url)
            .retry(3)
            .map {
                var api = [InstagramData]()
                if let dict = $0 as? Dictionary<String, AnyObject> {
                    if let item = dict["data"] as? [Dictionary<String, AnyObject>] {
                        item.forEach {
                            guard let image = $0["images"] as? Dictionary<String, AnyObject>,
                                let likes = $0["likes"] as? Dictionary<String, AnyObject> else { return }
                            if let small = image["thumbnail"] as? Dictionary<String, AnyObject>,
                                let like = likes["count"] as? Int,
                                let standart = image["standard_resolution"] as? Dictionary<String, AnyObject> {
                                if let url1 = small["url"] as? String,
                                    let url2 = standart["url"] as? String {
                                    api.append(InstagramData(photoSm: url1, likes: like, photoSt: url2))
                                }
                            }
                        }
                    }
                }
                print("HARMAN: \(api)")
                return api
        }
    }
}
