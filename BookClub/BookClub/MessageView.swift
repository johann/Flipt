//
//  MessageView.swift
//  BookClub
//
//  Created by Johann Kerr on 2/25/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    lazy var tableView: UITableView = UITableView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initialize()
        
        self.frame = UIScreen.mainScreen().bounds
        setNeedsUpdateConstraints()
    }
    
    
    convenience init() {
        self.init(frame:CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        createConstraints()
        super.updateConstraints()
    }
    
    func initialize() {
        
        // Add Subviews and Attributes Here
        
        addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
    }
    
    func createConstraints() {
        
        // Set Constraints Here
        
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.width.top.equalTo(self)
            make.bottom.equalTo(self).offset(-Constants.tabBarHeight)
        }
    }

}
