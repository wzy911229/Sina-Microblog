//
//  NewfeatureCollectionViewController.swift
//  Sina-Microblog
//
//  Created by wzy on 15/10/14.
//  Copyright © 2015年 wzy. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class NewfeatureViewController: UICollectionViewController {
    
    private let imageCount = 4
    private let layout = NewLayout()
    
    // MARK: - 生命周期方法
    init() {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(NewfeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        
        return cell
    }


}


 class NewLayout :UICollectionViewFlowLayout {
  
    // 或者可以直接在init方法中初始化布局,在viewdidload方法中设置collection
    override func prepareLayout() {
        // 1.设置布局
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        // 2.设置collectionView
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        
    }
}

class NewfeatureCell: UICollectionViewCell {
    
    
    
    
    
    
}