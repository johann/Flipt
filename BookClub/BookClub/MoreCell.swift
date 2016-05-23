//
//  MoreCell.swift
//  BookClub
//
//  Created by Johann Kerr on 2/27/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {
    
    
    static let reuseIdentifier = "MoreCell"
    
    lazy var btnLabel = UILabel()
    lazy var moreImage = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frame = UIScreen.mainScreen().bounds
        initialize()
        setNeedsUpdateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(){
        addSubview(btnLabel)
        addSubview(moreImage)
        
    }

}
