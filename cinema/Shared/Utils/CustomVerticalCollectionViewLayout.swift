//
//  CustomVerticalCollectionViewLayout.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 09/12/20.
//

import Foundation
import UIKit

class CustomVerticalCollectionViewLayout: UICollectionViewFlowLayout {
    var maxWidth: CGFloat?
    let itemSpacing: CGFloat = 5
    var layoutInfo = [IndexPath: UICollectionViewLayoutAttributes]()
    var xPosition: CGFloat = 5
    var yPosition: CGFloat = 0

    override var collectionViewContentSize: CGSize {
        let collectionViewWidth = self.collectionView!.frame.width
        return CGSize(width: collectionViewWidth, height: self.yPosition + self.minimumInteritemSpacing)
    }

    override init() {
        super.init()
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        let width =  self.maxWidth ?? 200
        self.estimatedItemSize = CGSize(width: width, height: width)
        self.minimumInteritemSpacing = self.itemSpacing
        self.minimumLineSpacing = self.itemSpacing
        self.scrollDirection = .vertical
    }

    override func prepare() {
        self.calculateValues()
        let numberOfItems = self.collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0 ..< numberOfItems {
            let indexPath = IndexPath(row: i, section: 0)
            if self.layoutInfo[indexPath] == nil {
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                itemAttributes.frame = self.frameForItemAtIndexPath(indexPath)
                self.layoutInfo[indexPath] = itemAttributes
            }
        }
    }

    private func calculateValues() {
        guard self.maxWidth == nil else { return }
        let frameWidth = self.collectionView!.frame.width
        self.maxWidth = (frameWidth - self.itemSpacing * 3) / 2
    }

    func frameForItemAtIndexPath(_ indexPath: IndexPath) -> CGRect {
        let validation = indexPath.row % 2 == 0
        let height = self.maxWidth! * 2
        let frame = CGRect(x: self.xPosition, y: self.yPosition, width: self.maxWidth!, height: height)
        self.xPosition = validation ? self.itemSpacing : (self.maxWidth! + (self.minimumInteritemSpacing * 2))
        self.yPosition = validation && indexPath.row != 0 ? self.yPosition + height + self.minimumInteritemSpacing :  self.yPosition

        return frame
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.layoutInfo[indexPath]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        for (_, attributes) in self.layoutInfo {
            if rect.intersects(attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        return allAttributes
    }
}
