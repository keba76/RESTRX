//
//  DetailPhotoVC.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/5/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class DetailPhotoVC: UIViewController {
    
    var photo: String?
    var imageView: UIImageView?
    var animator: UIDynamicAnimator?
    let dis = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        self.imageView = UIImageView(frame: CGRect(origin: CGPoint.init(x: self.view.bounds.minX, y: self.view.bounds.minY - self.view.bounds.maxY), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.width + 40)))
        self.view.addSubview(imageView!)
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: photo!)!))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.imageView?.image = UIImage(data: $0)
            }).addDisposableTo(dis)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailPhotoVC.close))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        let snap = UISnapBehavior(item: self.imageView!, snapTo: self.view.center)
        self.animator?.addBehavior(snap)
        
    }
    func close() {
        self.animator?.removeAllBehaviors()
        let snap = UISnapBehavior(item: self.imageView!, snapTo: CGPoint(x: CGFloat(self.view.bounds.midX), y: CGFloat(self.view.bounds.maxY + 220)))
        
        self.animator?.addBehavior(snap)
        self.dismiss(animated: true, completion: nil)
    }
}
