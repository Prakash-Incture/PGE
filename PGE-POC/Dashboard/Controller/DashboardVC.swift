//
//  DashboardVC.swift
//  PGE-POC
//
//  Created by PremKumar on 06/05/20.
//  Copyright © 2020 incture. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var userImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let headerArray = ["Electrical", "Gas", "Sub Station"]
    let dashboardViewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
       // userImgView.layer.cornerRadius = userImgView.frame.width/2
        //        collectionView.register(UINib(nibName: "CommonCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CommonCollectionCell")
        //        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        
        //        let alignLeftAttribute = LeftAlignedCollectionViewFlowLayout()
        //        collectionView.collectionViewLayout = alignLeftAttribute
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func searchBtnTapped(_ sender: Any) {
        navigateToListVC()
    }
}
extension DashboardVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headerArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        cell.titleLbl.text = headerArray[indexPath.row]
        cell.imgVw.image = UIImage(named: headerArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 200
        case .pad:
            return 350
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            CategorySigleton.shared.categoryName = DashboardSections.Material
            navigateToListVC()
        case 1:
            CategorySigleton.shared.categoryName = DashboardSections.Tools
            navigateToListVC()
        case 2:
            CategorySigleton.shared.categoryName = DashboardSections.Meter
            navigateToListVC()
        case 3:
            CategorySigleton.shared.categoryName = DashboardSections.Report
        default:
            debugPrint("Nothing to do")
        }
    }
}
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dashboardViewModel.getSectionTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionData = dashboardViewModel.getData(section: dashboardViewModel.getSectionTitles[section])
        return sectionData.dataModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonCollectionCell", for: indexPath) as? CommonCollectionCell{
            
            let sectionData = dashboardViewModel.getData(section: dashboardViewModel.getSectionTitles[indexPath.section])
            cell.titleLbl.text = (sectionData.dataModel?[indexPath.row])?.title ?? ""
            cell.imgView.image = UIImage(named: (sectionData.dataModel?[indexPath.row])?.img ?? "")
            
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView{
                headerView.titleLbl.text = dashboardViewModel.getSectionTitles[indexPath.section].rawValue
                return headerView
            }else{
                return UICollectionReusableView()
            }
        default:
            assert(false, "Unexpected element kind")
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3-16, height: collectionView.frame.width/3-16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToListVC()
    }
    
    private func navigateToListVC(){
        //IncidentsViewController
        //RequestListVC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "RequestListVC")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}

