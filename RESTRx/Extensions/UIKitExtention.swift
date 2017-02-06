//
//  UIKitExtention.swift
//  RxTableSome
//
//  Created by Ievgen Keba on 1/30/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import class UIKit.UITableViewCell
import class UIKit.UITableView
import class UIKit.UICollectionViewCell
import class UIKit.UICollectionView
import struct Foundation.IndexPath

//protocol ReusableView: class {
//    static var reuseIdentifier: String {get}
//}
//
//extension ReusableView {
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}
//
//extension UITableViewCell: ReusableView {
//}
//extension UICollectionViewCell: ReusableView {
//    
//}
//extension UICollectionView {
//    
//    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
//            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
//        }        
//        return cell
//    }
//}
