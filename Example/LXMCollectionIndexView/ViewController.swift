//
//  ViewController.swift
//  LXMCollectionIndexView
//
//  Created by billthas@gmail.com on 06/11/2018.
//  Copyright (c) 2018 billthas@gmail.com. All rights reserved.
//

private let kScreenBounds: CGRect = UIScreen.main.bounds
private let kScreenWidth: CGFloat = kScreenBounds.width
private let kScreenHeight: CGFloat = kScreenBounds.height

import UIKit
import LXMCollectionIndexView

class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: kScreenWidth, height: 44)
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
                layout.sectionHeadersPinToVisibleBounds = true
            }
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: TestCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TestCell.reuseIdentifier)
            collectionView.register(UINib.init(nibName: TestSectionHeaderView.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TestSectionHeaderView.reuseIdentifier)
            collectionView.backgroundColor = UIColor.orange
            
            if #available(iOS 11.0, *) {
                collectionView.contentInsetAdjustmentBehavior = .never
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    fileprivate var indexArray = ["A", "B", "C", "D", "E", "F", "G",
                                  "H", "I", "J", "K", "L", "M", "N",
                                  "O", "P", "Q", "R", "S", "T",
                                  "U", "V", "W", "X", "Y", "Z", "#"]
    
    
    fileprivate var indexView: LXMCollectionIndexView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let indexView = LXMCollectionIndexView(collectionView: collectionView)
        indexView.dataSource = indexArray
        self.indexView = indexView
        self.view.addSubview(indexView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return indexArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCell.reuseIdentifier, for: indexPath) as! TestCell
        cell.titleLabel.text = "\(indexArray[indexPath.section]) index:\(indexPath.section)-\(indexPath.item)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TestSectionHeaderView.reuseIdentifier, for: indexPath) as! TestSectionHeaderView
        sectionHeader.titleLabel.text = indexArray[indexPath.section]
        return sectionHeader
    }
    
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.indexArray.count > 0 {
            self.indexArray.removeLast()
            self.indexView?.dataSource = self.indexArray
            self.collectionView.reloadData()
        }
        
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 30)
    }
}
