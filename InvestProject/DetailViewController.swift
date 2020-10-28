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
    var images = ["tesla","APPLE","pg","amazon"]
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
        collectionView.contentInset = .zero
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = createLayout()

    }
    
    func createLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{(sectionIndex, enviroment) -> NSCollectionLayoutSection?  in
            switch sectionIndex  {
            case 0:
                //Header
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.visibleItemsInvalidationHandler = { items, offset, environment in
                    var t = CGAffineTransform(translationX: 0, y: offset.y < 0 ? offset.y : 0)
                    let scale = offset.y > 1 ? 1 : ( -offset.y / 150 ) + 1
                    t = t.scaledBy(x: scale, y: scale)
                    items.first?.transform = t
                }
                return section
                
            case 2:
                //Chart
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 4, bottom: 10, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
            default:
                //Info
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 4, bottom: 10, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
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
                       .font: UIFont.systemFont(ofSize: 14, weight: .bold)
                   ])
            
            cell?.titleView.attributedText = attributedTitle
            
            let attributedSubTitle =  NSMutableAttributedString(string: "Most popular", attributes: [ .foregroundColor: UIColor.white,
                           .font: UIFont.systemFont(ofSize: 10, weight: .medium)])
            cell?.subtitleView.attributedText = attributedSubTitle
            cell?.subtitleView.layer.cornerRadius = 5
            cell?.subtitleView.layer.masksToBounds = true
        case 1:
            let cell = cell as? ItemCell
            cell?.iconView.image = UIImage(named: images[indexPath.row])
            cell?.titleView.text = titles[indexPath.row]
        
        case 2:
            let cell = cell as? ChartCell
            
                cell?.chartView.play()
            

        case 3:
            let cell = cell as? InfoCell
            cell?.titleView.text = info[indexPath.row]
            cell?.valueTitle.text = ans[indexPath.row]
        default:
            return
        }
    }
}
