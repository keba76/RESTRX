//
//  ExploreVC.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/2/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import SimpleAuth
import RxSwift
import RxCocoa

class ExploreVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var token: String?
    var viewModel: ViewModel?
    let api = APInstagram()
    let dis = DisposeBag()
    
    let leftAndRightPeddings: CGFloat = 32.0
    let numberOfItemsPerRow: CGFloat = 3.0
    let heightAdjusment: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "PepsiHalftime"
        
        self.navigationItem.titleView = searchBar
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: (collectionView.frame.maxX - leftAndRightPeddings)/numberOfItemsPerRow, height: (collectionView.frame.maxX - leftAndRightPeddings)/numberOfItemsPerRow + heightAdjusment)
        
        if let tokenID = UserDefaults.standard.object(forKey: "accessToken") as? String {
            self.token = tokenID
            load()
        } else {
            SimpleAuth.authorize("instagram", options: [:]) { (responseObject, error) -> Void in
                guard let response = responseObject as? [String : AnyObject],
                    let token = response["credentials"] as? [String : AnyObject],
                    let accessToken = token["token"] as? String
                    else { return }
                self.token = accessToken
                self.load()
                UserDefaults.standard.set(accessToken, forKey: "accessToken")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    func load() {
        if let viewMod = ViewModel(api: api, token: token) {
            searchBar.rx.text.orEmpty.bindTo(viewMod.searchText).addDisposableTo(dis)
            
            viewMod.data.asDriver().drive(collectionView.rx.items(cellIdentifier: "ExplorePhotoCell", cellType: ExplorePhotoCell.self)) { (int , data, cell) in
                cell.instagViewModel = data
                }.addDisposableTo(dis)
        }
        
        
        collectionView.rx.modelSelected(InstagramData.self).subscribe(onNext: { image in
            let viewController = DetailPhotoVC()
            viewController.modalPresentationStyle = .custom
            viewController.transitioningDelegate = self
            viewController.photo = image.photoStandart
            self.present(viewController, animated: true, completion: nil)
        }).addDisposableTo(dis)
    }
}
extension ExploreVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}




