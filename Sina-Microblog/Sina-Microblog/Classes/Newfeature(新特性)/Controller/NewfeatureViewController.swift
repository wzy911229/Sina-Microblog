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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewfeatureCell
        cell.imageIndex = indexPath.item
        
        return cell
    }
    
    //注意:这里的indexPath和cell不是当前页
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
     let path = collectionView.indexPathsForVisibleItems().last!
        let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureCell

        if path.item == (imageCount - 1)
        {
           cell.startBtnAnimation()
        }
        
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
    
    
    // 根据图片索引设置图片
    var imageIndex: Int = 0{
        didSet{
            let image = UIImage(named: "new_feature_\(imageIndex + 1)")
            imageView.image = image
            
            
        }
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
        setup()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    //MARK: - 外部控制方法
    
    func startBtnAnimation(){
        startBtn.hidden = false
        startBtn.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startBtn.userInteractionEnabled = false
        
        // 1. usingSpringWithDamping 0.0-1.0 0最弹
        // 2. initialSpringVelocity 初始速度，如果使用 0，近似于重力加速度
        // 3. http://www.tuicool.com/articles/ZR7nYv
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startBtn.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startBtn.userInteractionEnabled = true
        })

    }
    //MARK: - 内部控制方法
    private func setup() {
        addSubview(imageView)
        addSubview(startBtn)
        
      startBtn.addTarget(self, action: Selector("startBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        
        imageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0.0)
        }
        startBtn.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp_bottom).offset(-160)
        }
    
    }
    
 
    private func startBtnClick() {
        
    }
    //MARK: - 懒加载
    private lazy var imageView :UIImageView = UIImageView()
    private lazy var startBtn :UIButton = {
        
        let btn = UIButton()
        btn.hidden = true
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        return btn

    }()
  
    
}