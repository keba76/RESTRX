//
//  ExplorePhotoCell.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/2/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExplorePhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesOfCount: UILabel!
    
    let dis = DisposeBag()
    
    var instagViewModel: InstagramData? {
        didSet {
            guard let photo = instagViewModel?.photoSmall else { return }
            let url = URL(string: photo)
            let a = instagViewModel!.rx_image(url: url!)
            a.asObservable().bindTo(imageView.rx.image).addDisposableTo(dis)
            likesOfCount.text = "❤️ \((instagViewModel?.likes)!) likes"
        }
    }    
}
extension HTTPClient {
    func rx_image(url: URL) -> Driver<UIImage?> {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return rx_image(url: url, cache: appDelegate.data)
    }
}

