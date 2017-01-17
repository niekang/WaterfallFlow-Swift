//
//  ViewController.swift
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/16.
//  Copyright © 2017年 聂康 . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var colletionView :UICollectionView = {
        let layout = WaterfallFlowLayout()
        layout.delegate = self
        let tempCollectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        tempCollectionView.dataSource = self
        tempCollectionView.backgroundColor = UIColor.yellow
        tempCollectionView.register(WaterFallCollectionViewCell.self, forCellWithReuseIdentifier: "WaterFall")
        return tempCollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(colletionView)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaterFall", for: indexPath) as! WaterFallCollectionViewCell
        cell.label.text = String(format: "%d", indexPath.row)
        
        return cell
    }
    
}

extension ViewController: WaterfallFlowLayoutDelegate {
    func waterfallFlowLayout(waterfallFlowLayout: WaterfallFlowLayout, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(60)+30)
    }
    
    func columeInWaterfallFlowLayout(waterfallFlowLayout: WaterfallFlowLayout) -> Int {
        return 3
    }
    
    func lineSpaceInWaterFallFlowLayout(waterfallFlowLayout: WaterfallFlowLayout) -> CGFloat {
        return 10
    }
    
    func itemSpaceInWaterFallFlowLayout(waterfallFlowLayout: WaterfallFlowLayout) -> CGFloat {
        return 10
    }
    
    func edgeInsetsInWaterFallFlowLayout(waterfallFlowLayout: WaterfallFlowLayout) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


