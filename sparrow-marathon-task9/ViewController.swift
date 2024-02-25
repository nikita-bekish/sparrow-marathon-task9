//
//  ViewController.swift
//  sparrow-marathon-task9
//
//  Created by Nikita Bekish on 25.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = SnappingCollectionViewLayout()
        
        layout.itemSize = CGSize(width: 300, height: 500)
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 32)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()

    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: - Private methods

    private func setupUI() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.decelerationRate = .fast
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {}

class SnappingCollectionViewLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
