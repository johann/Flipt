//
//  MoreView.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit



class MoreView: UIView {
    
    
    lazy var tableView: UITableView = UITableView()
    lazy var logoutBtn: UIButton = UIButton()
    
    
    
    
    func initialize(){
        self.addSubview(tableView)
        self.addSubview(logoutBtn)
        
        tableView.registerClass(MoreCell.classForCoder(), forCellReuseIdentifier: MoreCell.reuseIdentifier)
        
        
        
       
    }
    override init(frame: CGRect){
        super.init(frame:frame)
        initialize()
        setNeedsUpdateConstraints()
        
        
    }
    
    override func updateConstraints(){
        createConstraints()
        super.updateConstraints()
    }
    
    convenience init(){
        self.init(frame:CGRectZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints(){
        
    }
    
    
    

    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
