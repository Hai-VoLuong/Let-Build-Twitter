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
            if let error = error {
                self.errorMessageLabel.isHidden = false
                if let apiError = error as? APIError<Service.JSONError> {
                    if apiError.response?.statusCode != 200 {
                        self.errorMessageLabel.text = "Status code was not 200"
                    }
                }
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
        
        if indexPath.section == 0 {
            guard let user = self.datasource?.item(indexPath) as? User else { return .zero }
            let estimateHeight = estimateHeightForText(user.bioText)
            return CGSize(width: view.frame.width, height: estimateHeight + 86)
        } else if indexPath.section == 1 {
            guard let tweet = datasource?.item(indexPath) as? Tweet else { return .zero }
            let estimateHeight = estimateHeightForText(tweet.message)
            return CGSize(width: view.frame.width, height: estimateHeight + 86)
        }
        return CGSize(width: view.frame.width, height: 200)
    }
    
    private func estimateHeightForText(_ text: String) -> CGFloat {
        let approximateWithOfBioTextView = view.frame.width - 12 - 50 - 12 - 2
        let size = CGSize(width: approximateWithOfBioTextView, height: 1000)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
        
        let estimateFrame = NSString(string: text)
            .boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimateFrame.height
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
