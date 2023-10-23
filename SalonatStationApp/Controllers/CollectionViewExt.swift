//
//  CollectionViewExt.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/21/23.
//

import UIKit

//MARK: - Pending requests
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pendingRequests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  PendingRequestsCell.identifier, for: indexPath) as? PendingRequestsCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(model: pendingRequests[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return setCollectionViewSize(collectionView: collectionView, collectionViewLayout: collectionViewLayout, itemInOneLine: 1.1, height: pendingRequestsCollectionView.bounds.height)
    }
    
    func setCollectionViewSize(collectionView: UICollectionView, collectionViewLayout: UICollectionViewLayout, itemInOneLine: CGFloat, height: CGFloat) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout

        let itemSpacing: CGFloat = 10
        let itemInOneLine: CGFloat = itemInOneLine

        let width = collectionView.frame.width - itemSpacing * (itemInOneLine - 1 )
        layout.minimumLineSpacing = itemSpacing

        return CGSize(width: width / itemInOneLine, height: height)
    }
    
}
