//
//  MessageCell.swift
//  BookClub
//
//  Created by Johann Kerr on 2/25/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    lazy var chatImageView: UIImageView = UIImageView()
    lazy var dateLabel: UILabel = UILabel()
    lazy var nameLabel: UILabel = UILabel()
    lazy var lastMessageLabel: UILabel = UILabel()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frame = UIScreen.mainScreen().bounds
        initialize()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse(){
        
    }
    func initialize() {
        
        self.chatImageView.layer.masksToBounds = false
        self.chatImageView.layer.cornerRadius = 25
        self.chatImageView.clipsToBounds = true
        self.chatImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.addSubview(self.chatImageView)
        
        
        self.nameLabel.textAlignment = .Left
        self.nameLabel.textColor = UIColor.blackColor()
        self.addSubview(self.nameLabel)
        
        self.lastMessageLabel.textAlignment = .Left
        self.lastMessageLabel.textColor = UIColor.lightGrayColor()
        self.addSubview(self.lastMessageLabel)
        
        self.dateLabel.textAlignment = .Right
        self.dateLabel.textColor = UIColor.lightGrayColor()
        self.dateLabel.font = UIFont(name: "Helvetica", size:10)
        self.addSubview(self.dateLabel)

        
        
    }
    override func updateConstraints(){
        createConstraints()
        super.updateConstraints()
    }
    
    
    func createConstraints(){
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
