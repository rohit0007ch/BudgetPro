//
//  File.swift
//  BudgetPro
//
//  Created by ROHIT on 28/10/25.
//

import UIKit

class CarouselFlowLayout: UICollectionViewFlowLayout {

    let activeDistance: CGFloat = 200
    let zoomFactor: CGFloat = 0.25

    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 20   // spacing between cards
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        // Center first and last cells
        let insetX = (collectionView.bounds.width - itemSize.width) / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        collectionView.decelerationRate = .fast
    }

    // Add zoom effect for nearby cells
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesArray = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else { return nil }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let centerX = visibleRect.midX

        for attributes in attributesArray {
            let distance = abs(attributes.center.x - centerX)
            let normalized = distance / activeDistance
            let zoom = 1 + zoomFactor * (1 - min(normalized, 1))
            attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
            attributes.alpha = 1 - min(normalized, 1) * 0.4
        }

        return attributesArray
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // 🧠 Snapping behavior — ensures one card per slide
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint)
    -> CGPoint {

        guard let collectionView = collectionView else { return proposedContentOffset }
        let collectionViewSize = collectionView.bounds.size
        let proposedRect = CGRect(x: proposedContentOffset.x,
                                  y: 0,
                                  width: collectionViewSize.width,
                                  height: collectionViewSize.height)

        guard let attributesArray = super.layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }

        let centerX = proposedContentOffset.x + collectionViewSize.width / 2
        var closest = CGFloat.greatestFiniteMagnitude

        for attributes in attributesArray {
            let distance = attributes.center.x - centerX
            if abs(distance) < abs(closest) {
                closest = distance
            }
        }

        return CGPoint(x: proposedContentOffset.x + closest, y: proposedContentOffset.y)
    }
}

