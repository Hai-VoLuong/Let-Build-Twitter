//
//  DataSourceController.swift
//  Twitter
//
//  Created by MAC on 1/14/18.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSourceController: DatasourceController {
    
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Apologies something went wrong. Please try again later..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // update ui when xoay Điện thoại
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(errorMessageLabel)
        errorMessageLabel.fillSuperview()
        
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        setupNavigationBarItems()
        Service.sharedInstance.fetchHomeFeed { (homeDataSource, error) in
            if let _ = error {
                self.errorMessageLabel.isHidden = false
                return
            }
            self.datasource = homeDataSource
        }
    }
    
    // MARK: - Collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Cell View Size
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let user = self.datasource?.item(indexPath) as? User {
            
            // let's estimate bio text
            let approximateWithOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
            let size = CGSize(width: approximateWithOfBioTextView, height: 1000)
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            
            let estimateFrame = NSString(string: user.bioText)
                .boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            return CGSize(width: view.frame.width, height: estimateFrame.height + 86)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    // MARK: - Header View Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 50)
    }
    
    // MARK: - Footer View Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .zero
        }
        return CGSize(width: view.frame.width, height: 64)
    }
}
