//
//  HTTPClient.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/4/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol HTTPClient: ImageCaching{
}
extension HTTPClient {
    func rx_image(url: URL, cache: ImageCaching) -> Driver<UIImage?> {
        let dis = DisposeBag()
        return Observable.create({ (observer) -> Disposable in
            if let image = cache.imageFromCacheWithUrl(url: url) {
                observer.onNext(image)
                observer.onCompleted()
            } else {
                let a = URLSession.shared.rx.data(request: URLRequest(url: url))
                a.subscribe(onNext: { data in
                    let image = UIImage(data: data)
                    cache.saveImageToCache(image: image, url: url)
                    observer.onNext(image)
                    observer.onCompleted()
                }).addDisposableTo(dis)
            }
            return Disposables.create()
        }).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)).asDriver(onErrorJustReturn: nil)
    }
}
