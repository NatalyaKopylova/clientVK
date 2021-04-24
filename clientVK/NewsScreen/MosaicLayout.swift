//
//  MosaicLayout.swift
//  clientVK
//
//  Created by Natalia on 23.04.2021.
//

import UIKit

enum MosaicSegmentStyle {
    case fullWidth, fiftyFifty, twoThirdsOneThird, oneThirdTwoThirds
}

class MosaicLayout: UICollectionViewLayout {
    
    var contentBounds = CGRect.zero
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }

        // Reset cached information.
        cachedAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
    
        // For every item in the collection view:
        //  - Prepare the attributes.
        //  - Store attributes in the cachedAttributes array.
        //  - Combine contentBounds with attributes.frame.
        let count = collectionView.numberOfItems(inSection: 0)
        
        var currentIndex = 0
        
        var restFrame = collectionView.bounds
        var segmentRects = [CGRect]()
        var divideType = DivideType.horizontal
        
        while currentIndex < count {
            if (count - currentIndex) > 1 {
                let slices = divide(rect: restFrame, type: divideType)
                segmentRects.append(slices[0])
                restFrame = slices[1]
            }
            
            divideType = divideType == .horizontal ? .vertical : .horizontal
            currentIndex += 1
        }
        
        segmentRects.append(restFrame)
        
        // Create and cache layout attributes for calculated frames.
        for i in 0..<segmentRects.count {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.frame = segmentRects[i]
            
            cachedAttributes.append(attributes)
        }
    }
    
    override var collectionViewContentSize: CGSize {
            return contentBounds.size
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()

        // Find any cell that sits within the query rect.
        guard let lastIndex = cachedAttributes.indices.last,
              let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }

        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }

        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }
        return attributesArray
    }
    
    // Perform a binary search on the cached attributes array.
        func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
            if end < start { return nil }

            let mid = (start + end) / 2
            let attr = cachedAttributes[mid]

            if attr.frame.intersects(rect) {
                return mid
            } else {
                if attr.frame.maxY < rect.minY {
                    return binSearch(rect, start: (mid + 1), end: end)
                } else {
                    return binSearch(rect, start: start, end: (mid - 1))
                }
            }
        }
    
    private enum DivideType {
        case horizontal, vertical
    }
    
    private func divide(rect: CGRect, type: DivideType) -> [CGRect] {
        switch type {
        case .horizontal:
            let slices = rect.divided(atDistance: rect.width / 2, from: .minXEdge)
            return [slices.slice, slices.remainder]
        case .vertical:
            let slices = rect.divided(atDistance: rect.height / 2, from: .minYEdge)
            return [slices.slice, slices.remainder]
        }
    }
}
