//
//  BookCollectionCell.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class BookCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BookCell"
    
    var bookImageView: UIImageView = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setNeedsUpdateConstraints()
        
    }
    func initialize(){
        bookImageView.backgroundColor = UIColor.greenColor()
        self.addSubview(self.bookImageView)
    }
    
    override func updateConstraints(){
        createConstraints()
        super.updateConstraints()
    }
    
    func createConstraints(){
        self.bookImageView.snp_makeConstraints{(make) -> Void in
            make.edges.equalTo(self)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
