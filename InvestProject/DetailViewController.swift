//
//  DetailViewController.swift
//  InvestProject
//
//  Created by Tiana  on 27/10/2020.
//

import UIKit

class NavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var titles = ["Tesla", "Apple", "P&G","Amazon"]
    var images = ["tesla","apple","pg","amazon"]
    var subtitle = ["Automotive","Technology","Consumer goods","Consumer goods"]
    var info = ["Risk level", "Average return"]
    var ans = ["🌶🌶🌶","1.5%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultStyle = UINavigationBarAppearance()
        defaultStyle.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = defaultStyle
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: SectionHeaderView.identifier, withReuseIdentifier: SectionHeaderView.identifier)
        collectionView.contentInset = .zero
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = createLayout()

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as! SectionHeaderView
        headerView.setupHeader()
        switch (indexPath.section) {
        case (1):
            headerView.label.text = "In this bundle"
        case (2):
            headerView.label.text = "Progress"
        case (3):
            headerView.label.text = "Details"
        default:
            headerView.label.text = ""
        }
        return headerView
    }

    
    func createLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{(sectionIndex, enviroment) -> NSCollectionLayoutSection?  in
            switch sectionIndex  {
            case 0:
                //Header
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.visibleItemsInvalidationHandler = { items, offset, environment in
                    var t = CGAffineTransform(translationX: 0, y: offset.y < 0 ? offset.y : 0)
//                    let scale = offset.y > 1 ? 1 : ( -offset.y / 150 ) + 1
//                    t = t.scaledBy(x: scale, y: scale)
                    items.first?.transform = t
                }
                return section
                
            case 1:
                //Sectors /chip
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4)

                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.identifier, alignment: .topLeading)
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 4)

                return section
                
            case 2:
                //Chart
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.identifier, alignment: .topLeading)
                section.boundarySupplementaryItems = [sectionHeader]
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
                return section
                
            
            default:
                //Info
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SectionHeaderView.identifier, alignment: .topLeading)
                section.boundarySupplementaryItems = [sectionHeader]
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15)
                return section
            }
        }
            return layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return titles.count
        case 2:
           return  1
        default:
            return 2
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailHeaderCell", for: indexPath)
           // cell.layer.cornerRadius = 12.0
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemsCell", for: indexPath)
            cell.layer.cornerRadius = 12.0
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chartCell", for: indexPath)
            cell.layer.cornerRadius = 12.0
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath)
            cell.layer.cornerRadius = 12.0
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let cell = cell as? DetailHeaderCell
            cell?.backgroundColor = .systemIndigo
            let attributedTitle = NSMutableAttributedString(string: "📱\nTech Bundle", attributes: [
                       .foregroundColor: UIColor.white,
                       .font: UIFont.systemFont(ofSize: 32, weight: .bold)
                   ])
            
            cell?.titleView.attributedText = attributedTitle
            
        case 1:
            let cell = cell as? ItemCell
            cell?.iconView.image = UIImage(named: images[indexPath.row])
            let attributedTitle = NSMutableAttributedString(string: "\(titles[indexPath.row])\n", attributes: [
                       .foregroundColor: UIColor.label,
                       .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
                   ])
            attributedTitle.append(NSAttributedString(string: "\(subtitle[indexPath.row])", attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .font: UIFont.systemFont(ofSize: 12, weight: .regular)
            ]))
            
            cell?.titleView.attributedText = attributedTitle
        
        case 2:
            let cell = cell as? ChartCell
            
                cell?.chartView.play()
            

        case 3:
            let cell = cell as? InfoCell
            let attributedTitle = NSMutableAttributedString(string: "\(info[indexPath.row])", attributes: [
                       .foregroundColor: UIColor.label,
                       .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
                   ])
            let attributedAns = NSMutableAttributedString(string: "\(ans[indexPath.row])", attributes: [
                       .foregroundColor: UIColor.systemGreen,
                       .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
                   ])
            
            cell?.titleView.attributedText = attributedTitle
            cell?.valueTitle.attributedText = attributedAns
        default:
            return
        }
    }
}
