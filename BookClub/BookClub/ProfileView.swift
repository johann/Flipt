//
//  ProfileView.swift
//  BookClub
//
//  Created by Johann Kerr on 2/25/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    lazy var profileImage: UIImageView = UIImageView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var locationLabel: UILabel = UILabel()
    lazy var followingLabel: UILabel = UILabel()
    lazy var followerLabel: UILabel = UILabel()
    lazy var booksLabel: UILabel = UILabel()
    lazy var followingNumLabel: UILabel = UILabel()
    lazy var followerNumLabel: UILabel = UILabel()
    lazy var booksNumLabel: UILabel = UILabel()
    lazy var collectionView: UICollectionView = UICollectionView()
    
    
    func initialize(){
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width/3 - 2,180)
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height), collectionViewLayout: layout)
        self.collectionView.registerClass(BookCollectionCell.classForCoder(), forCellWithReuseIdentifier: BookCollectionCell.reuseIdentifier)
        
        
        self.nameLabel.textAlignment = .Center
        self.locationLabel.textAlignment = .Center
        self.booksLabel.textAlignment = .Center
        
        self.profileImage.backgroundColor = Constants.appColor
        self.profileImage.layer.cornerRadius = 37
        self.profileImage.clipsToBounds = true
        self.nameLabel.textColor = Constants.appColor
        self.nameLabel.text = "Johann Kerr"
        self.locationLabel.text = "New York City, NY"
        self.followingNumLabel.text = "0"
        self.followerNumLabel.text = "0"
        self.booksNumLabel.text = "0"
        
        self.followingLabel.text = "Following"
        self.followerLabel.text = "Followers"
        self.booksLabel.text = "Books"
        
        self.followingNumLabel.textColor = Constants.appColor
        self.followerNumLabel.textColor = Constants.appColor
        self.booksNumLabel.textColor = Constants.appColor
        self.collectionView.backgroundColor = UIColor.greenColor()
        self.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(locationLabel)
        self.addSubview(followingLabel)
        self.addSubview(followerLabel)
        self.addSubview(followingNumLabel)
        self.addSubview(followerNumLabel)
        self.addSubview(booksNumLabel)
        self.addSubview(booksLabel)
        self.addSubview(collectionView)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.initialize()
        //setNeedsUpdateConstraints()
    }
    
    
    override func updateConstraints() {
        self.createConstraints()
        super.updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints(){
        
        self.profileImage.snp_makeConstraints{(make) -> Void in
            make.width.equalTo(75)
            make.height.equalTo(75)
            make.top.equalTo(self).offset(55)
            make.centerX.equalTo(self)
            
        }
//        
        self.nameLabel.snp_makeConstraints{(make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self.profileImage.snp_bottom).offset(25)
            make.width.equalTo(self)
        }
        self.locationLabel.snp_makeConstraints{(make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self.nameLabel.snp_bottom)
            make.width.equalTo(self)
        }
        self.followerNumLabel.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.locationLabel.snp_bottom).offset(35)
            make.centerX.equalTo(self)
        }
        self.followingNumLabel.snp_makeConstraints{(make) -> Void in
            make.left.equalTo(self).offset(50)
            //make.right.equalTo(self.followerNumLabel.snp_left).offset(150)
            make.top.equalTo(self.locationLabel.snp_bottom).offset(35)
            
        }
        self.booksNumLabel.snp_makeConstraints{(make) -> Void in
//            make.left.equalTo(self.followerNumLabel.snp_right).offset(-150)
            make.right.equalTo(self).offset(-50)
            make.top.equalTo(self.locationLabel.snp_bottom).offset(35)
        }
//
        self.followingLabel.snp_makeConstraints{(make) -> Void in
            make.centerX.equalTo(followingNumLabel)
            make.top.equalTo(self.followingNumLabel.snp_bottom)
            
        }
        self.followerLabel.snp_makeConstraints{(make) -> Void in
            make.centerX.equalTo(followerNumLabel)
            make.top.equalTo(self.followerNumLabel.snp_bottom)
        }
//        self.followingLabel.snp_makeConstraints{(make) -> Void in
//            
//        }
        self.booksLabel.snp_makeConstraints{(make) -> Void in
            make.centerX.equalTo(booksNumLabel)
            make.top.equalTo(self.booksNumLabel.snp_bottom)
        }
        
        self.collectionView.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.followerLabel.snp_bottom).offset(15)
            //make.left.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.bottom.equalTo(self).offset(-Constants.tabBarHeight)
        }
//
//
        
        super.updateConstraints()
        
    }
    override func layoutSubviews() {
        createConstraints()
        super.layoutSubviews();
    }



}
