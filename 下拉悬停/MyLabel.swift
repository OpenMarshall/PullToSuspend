//
//  MyLabel.swift
//  下拉悬停
//
//  Created by 徐开源 on 16/3/25.
//  Copyright © 2016年 徐开源. All rights reserved.
//

import UIKit

class MyLabel: UILabel {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = UIColor.whiteColor()
        self.textAlignment = .Center
        self.text = "0"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
