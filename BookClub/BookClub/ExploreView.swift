//
//  ExploreView.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import SnapKit


class ExploreView: UIView {

    lazy var collectionView: UICollectionView = UICollectionView()
    lazy var searchBar: UISearchBar = UISearchBar()
    
    
    func initialize(){
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width/3 - 2,180)
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height), collectionViewLayout: layout)
        self.collectionView.registerClass(BookCollectionCell.classForCoder(), forCellWithReuseIdentifier: BookCollectionCell.reuseIdentifier)
        
        self.addSubview(searchBar)
        self.addSubview(collectionView)
        //self.addSubview(searchBar)
        
    }
    override init(frame: CGRect){
        super.init(frame:frame)
        self.initialize()
        //setNeedsUpdateConstraints()
        
        
    }
    override func updateConstraints(){
        self.createConstraints()
        super.updateConstraints()
        
    }
    
    func createConstraints(){
        
        
        self.searchBar.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self).offset(Constants.statusBarHeight + Constants.navBarHeight)
            make.width.equalTo(self)
        }
        self.collectionView.snp_makeConstraints{(make) -> Void in
            //make.edges.equalTo(self)
            make.top.equalTo(self.searchBar.snp_bottom)
            make.left.equalTo(self)
            make.width.equalTo(self)
            //make.width.equalTo(UIScreen.mainScreen().bounds.width)
            make.bottom.equalTo(self).offset(-Constants.tabBarHeight)
            
        }
        super.updateConstraints()
        
    }
    override func layoutSubviews() {
        createConstraints()
        super.layoutSubviews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    


}
