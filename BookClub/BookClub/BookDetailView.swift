//
//  BookDetailView.swift
//  BookClub
//
//  Created by Johann Kerr on 2/28/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class BookDetailView: UIView {
    
    lazy var bookImageView: UIImageView = UIImageView()
    lazy var bookTitleLabel: UILabel = UILabel()
    lazy var authorLabel: UILabel = UILabel()
    lazy var publicationLabel: UILabel = UILabel()
    lazy var pageNumberLabel: UILabel = UILabel()
    lazy var topDivider: UIImageView = UIImageView()
    lazy var middleDivider: UIImageView = UIImageView()
    lazy var bottomDivider: UIImageView = UIImageView()
    lazy var bookDescriptionLabel: UILabel = UILabel()
    lazy var bookDescriptionTextView: UITextView = UITextView()
    lazy var bookOwnedByLabel: UILabel = UILabel()
    lazy var profImageView: UIImageView = UIImageView()
    lazy var ownerLabel: UILabel = UILabel()
    lazy var disclosureIndicator: UIImageView = UIImageView()
    lazy var messageOwnerBtn: UIButton = UIButton()
    
    
    func initialize(){
        self.backgroundColor = UIColor.whiteColor()
        
        bookImageView.backgroundColor = Constants.appColor
        bookTitleLabel.text = "Book Title"
        authorLabel.text = "Author Name"
        publicationLabel.text = "August 12"
        pageNumberLabel.text = "23"
        
        
        
        bookDescriptionLabel.text = "Book Description"
        
        bookOwnedByLabel.text = "This Book is owned By"
        
        topDivider.image = UIImage(named:"dividerHandSmall")
        middleDivider.image = UIImage(named:"dividerHandSmall")
        bottomDivider.image = UIImage(named:"dividerHandSmall")
        
        
        bookDescriptionTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet magna a libero congue hendrerit at ut tellus. Nullam facilisis quis sapien id sagittis. Duis condimentum metus ut erat pulvinar sollicitudin. In hac habitasse platea dictumst. "//Lorem Ipsum
        
        bookDescriptionTextView.userInteractionEnabled = false
        bookDescriptionTextView.textAlignment = NSTextAlignment.Left
        
        bookDescriptionTextView.textColor = UIColor.lightGrayColor()
        ownerLabel.text = "Author Person"
        messageOwnerBtn.titleLabel!.text = "Message Owner"
        
        profImageView.backgroundColor = Constants.appColor
        profImageView.layer.cornerRadius = 45/2
        
        self.messageOwnerBtn.backgroundColor = Constants.appColor
        self.messageOwnerBtn.setTitle("Message Owner", forState: .Normal)
        self.messageOwnerBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.messageOwnerBtn.layer.cornerRadius = 10
        
        self.addSubview(bookImageView)
        self.addSubview(bookTitleLabel)
        self.addSubview(authorLabel)
        self.addSubview(publicationLabel)
        self.addSubview(pageNumberLabel)
        self.addSubview(topDivider)
        self.addSubview(bookDescriptionLabel)
        self.addSubview(bookDescriptionTextView)
        self.addSubview(bookOwnedByLabel)
        self.addSubview(middleDivider)
        self.addSubview(profImageView)
        self.addSubview(ownerLabel)
        self.addSubview(bottomDivider)
        self.addSubview(messageOwnerBtn)
        
        
//        self.addSubview(middleDivider)
//        self.addSubview(bottomDivider)
//        self.addSubview(bookDescriptionLabel)
//        self.addSubview(bookDescriptionTextView)
//        self.addSubview(bookOwnedByLabel)
//        self.addSubview(profImageView)
//        self.addSubview(ownerLabel)
//        self.addSubview(disclosureIndicator)
//        self.addSubview(messageOwnerBtn)
        
    }
    
    override init(frame: CGRect){
        super.init(frame:frame)
        self.initialize()
        setNeedsUpdateConstraints()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints(){
        self.createConstraints()
        super.updateConstraints()
        
    }
    
    func createConstraints(){
        self.bookImageView.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self).offset(Constants.statusBarHeight + Constants.navBarHeight + 10)
            make.left.equalTo(self).offset(15)
            make.width.equalTo(60)
            make.height.equalTo(90)
        }
        self.bookTitleLabel.snp_makeConstraints{(make) -> Void in
            make.left.equalTo(bookImageView.snp_right).offset(25)
            make.top.equalTo(self.bookImageView)
            make.right.equalTo(self).offset(-Constants.padding)
        
            
        }
        self.authorLabel.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.bookTitleLabel.snp_bottom)
            make.left.equalTo(self.bookImageView.snp_right).offset(25)
        }
        self.publicationLabel.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.authorLabel.snp_bottom).offset(13)
            make.left.equalTo(self.bookImageView.snp_right).offset(25)
        }
        
        self.topDivider.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.publicationLabel.snp_bottom).offset(40)
            make.width.equalTo(self)
        }
        self.bookDescriptionLabel.snp_makeConstraints{(make) -> Void in
            make.left.equalTo(self).offset(Constants.padding)
            make.top.equalTo(self.topDivider.snp_bottom).offset(Constants.padding)
            
            
        }
        self.bookDescriptionTextView.snp_makeConstraints{(make) -> Void in
            make.left.equalTo(self).offset(Constants.padding)
            make.right.equalTo(self).offset(-Constants.padding)
            make.top.equalTo(self.bookDescriptionLabel.snp_bottom)
            make.height.equalTo(100)
            
           
            
        }
        self.bookOwnedByLabel.snp_makeConstraints{(make) -> Void in
            make.left.equalTo(self).offset(Constants.padding)
            make.top.equalTo(self.bookDescriptionTextView.snp_bottom).offset(10)
            
        }

        self.middleDivider.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.bookOwnedByLabel.snp_bottom).offset(Constants.padding)
            make.width.equalTo(self)
            
        }
        self.profImageView.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.middleDivider).offset(Constants.padding)
            make.left.equalTo(self).offset(Constants.padding)
            make.width.height.equalTo(45)
        }
        self.ownerLabel.snp_makeConstraints{(make) -> Void in
            make.left.equalTo(self.profImageView.snp_right).offset(15)
            // make.top.equalTo(self.bookImageView)
            make.centerY.equalTo(self.profImageView)
        }

        self.bottomDivider.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(self.profImageView.snp_bottom).offset(Constants.padding)
            make.width.equalTo(self)
            
        }

        self.messageOwnerBtn.snp_makeConstraints{(make) -> Void in
            make.top.equalTo(bottomDivider.snp_bottom).offset(45)
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        super.updateConstraints()
        
    }
    override func layoutSubviews() {
        createConstraints()
        super.layoutSubviews();
    }
    
    
    
    
    



}
