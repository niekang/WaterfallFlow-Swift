//
//  WaterfallFlowLayout.swift
//  WaterfallFlow
//
//  Created by 聂康  on 2017/1/16.
//  Copyright © 2017年 聂康 . All rights reserved.
//

import UIKit

@objc protocol WaterfallFlowLayoutDelegate:NSObjectProtocol {
    
    func waterfallFlowLayout(waterfallFlowLayout:WaterfallFlowLayout,  heightForRowAt indexPath: IndexPath) -> CGFloat
    
    @objc optional func columeInWaterfallFlowLayout(waterfallFlowLayout:WaterfallFlowLayout) -> Int
    
    @objc optional func lineSpaceInWaterFallFlowLayout(waterfallFlowLayout:WaterfallFlowLayout) -> CGFloat
    
    @objc optional func itemSpaceInWaterFallFlowLayout(waterfallFlowLayout:WaterfallFlowLayout) -> CGFloat
    
    @objc optional func edgeInsetsInWaterFallFlowLayout(waterfallFlowLayout:WaterfallFlowLayout) -> UIEdgeInsets
}

class WaterfallFlowLayout: UICollectionViewLayout {
    
    weak var delegate:WaterfallFlowLayoutDelegate?
    
    var contentHeight:CGFloat = 0
    
    var attrsHeightArray:[CGFloat] = []
    
    lazy var attributesArray:[UICollectionViewLayoutAttributes] = {
        var array = [UICollectionViewLayoutAttributes]()
        return array
    }()
    
    private func columeCount() -> Int{
        var columeCount = delegate?.columeInWaterfallFlowLayout?(waterfallFlowLayout: self);
        if columeCount == nil {
            columeCount = 3
        }
        return columeCount!
    }
    
    private func lineSpace() -> CGFloat{
        var lineSpace = delegate?.lineSpaceInWaterFallFlowLayout?(waterfallFlowLayout: self)
        if lineSpace == nil {
            lineSpace = 0
        }
        return lineSpace!
    }
    
    private func itemSpace() -> CGFloat{
        var itemSpace = delegate?.itemSpaceInWaterFallFlowLayout?(waterfallFlowLayout: self)
        if itemSpace == nil {
            itemSpace = 0
        }
        return itemSpace!
    }
    
    private func edgeInsets() -> UIEdgeInsets{
        var edgeInsets = delegate?.edgeInsetsInWaterFallFlowLayout?(waterfallFlowLayout: self)
        if edgeInsets == nil {
            edgeInsets = UIEdgeInsets.zero
        }
        return edgeInsets!
    }
    
    override func prepare() {
        super.prepare()
        let items = collectionView?.numberOfItems(inSection: 0)
        
        contentHeight = 0
        attributesArray.removeAll()
        attrsHeightArray.removeAll()
        
        if let itemsCount = items {
            for i in 0..<itemsCount {
                attrsHeightArray.insert(edgeInsets().top, at: i)
            }
            for i in 0..<itemsCount {
                let indexPath = IndexPath(item: i, section: 0)
                let attrs = layoutAttributesForItem(at: indexPath)
                attributesArray.insert(attrs!, at: i)
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let edge = edgeInsets()
        let colume = CGFloat(columeCount())
        let columeSpace = itemSpace()
        let rowSpace = lineSpace()
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let width = collectionView?.frame.size.width
        let attrsWidth = (width!-edge.left-edge.right-(colume-1)*columeSpace)/colume
        var minIndex:Int = 0
        var attrsY = attrsHeightArray[0]
        for i in 1..<Int(colume) {
            if attrsY > attrsHeightArray[i]{
                attrsY = attrsHeightArray[i]
                minIndex = i
            }
        }
        let attrsX = edge.left + CGFloat(minIndex) * (attrsWidth + columeSpace)

        if attrsY != edge.top {
            attrsY += rowSpace
        }
        
        attrs.frame = CGRect(x: attrsX, y: attrsY, width: attrsWidth, height:(delegate?.waterfallFlowLayout(waterfallFlowLayout: self, heightForRowAt: indexPath))!)
        
        if indexPath.row == 2 {
            print(attrs)
        }
        attrsHeightArray[minIndex] = attrs.frame.maxY
        
        if contentHeight < attrs.frame.maxY{
            contentHeight = attrs.frame.maxY;
        }
        return attrs;
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: 0, height: contentHeight+10)
        }
    }

}
