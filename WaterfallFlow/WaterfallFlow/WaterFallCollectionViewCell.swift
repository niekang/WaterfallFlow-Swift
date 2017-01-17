
//
//  WaterFallCollectionViewCell.swift
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/16.
//  Copyright © 2017年 聂康 . All rights reserved.
//

import UIKit

class WaterFallCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let a = (CGFloat)(arc4random_uniform(255))/255.0
        label.backgroundColor = UIColor(hue: a, saturation: a, brightness: a, alpha: 1)
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        label.frame = bounds

    }
    
}
