//
//  ViewController.swift
//  InvestProject
//
//  Created by Tiana  on 22/10/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var titles = ["Monthly Dividends", "Yearly Dividends", "Quarterly Dividends"]
    var sectors = ["Technology", "Consumer Goods", "Health","Finance","Industrials","Mining"]
    var colors : [UIColor] = [.systemBlue,.systemIndigo,.magenta,.systemRed,.systemTeal,.systemOrange]
    var icon = ["cpu", "cart", "staroflife","creditcard","building","hammer"]
    var types = ["Fast Invest", "Balanced Bundle", "Slow & Steady","Clean & Green"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = createLayout()


    }

    func createLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout{(sectionIndex, enviroment) -> NSCollectionLayoutSection?  in
            switch sectionIndex  {
            case 0:
                //Header
                let size  = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
                let item = NSCollectionLayoutItem(layoutSize: size)
                item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 8, bottom: 10, trailing: 8)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                return section
            case 1:
                //Summary
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(240))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
                return section
                
            case 2:
                //Sectors
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(155))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 4, bottom: 10, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(155))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
            default:
               //Chip
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 4, bottom: 0, trailing: 4)

                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(65))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                // section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 20, trailing: 4)

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
            return titles.count
        case 1:
          return  1
        case 2:
           return  colors.count
        default:
            return types.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0,2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath)
            cell.layer.cornerRadius = 12.0
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath)
            cell.layer.cornerRadius = 12.0
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chipCell", for: indexPath)
            cell.layer.cornerRadius = 12.0
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let cell = cell as? HeaderCell
            cell?.backgroundColor = .systemIndigo
            let attributedTitle = NSMutableAttributedString(string: "\(titles[indexPath.row])\n\n", attributes: [
                       .foregroundColor: UIColor.white,
                       .font: UIFont.systemFont(ofSize: 12, weight: .bold)
                   ])
            attributedTitle.append( NSAttributedString(string: "£200 \n\n", attributes: [ .foregroundColor: UIColor.white,
                           .font: UIFont.systemFont(ofSize: 16, weight: .bold)]))
            attributedTitle.append(NSAttributedString(string: "£20 this month\n", attributes: [ .foregroundColor: UIColor.white,
                           .font: UIFont.systemFont(ofSize: 10, weight: .regular)]))
            cell?.titleView.attributedText = attributedTitle
        case 1:
            let cell = cell as? SummaryCell
            cell?.pieView.backgroundColor = .clear
            cell?.pieView.slices = [
                Slice(percent: 0.4, color: UIColor.systemIndigo),
                Slice(percent: 0.3, color: UIColor.systemBlue),
                Slice(percent: 0.3, color: UIColor.systemPurple)
            ]
            cell?.pieCenterTitle.center = (cell?.pieView.center)!
            cell?.pieView.animateChart()
        
        case 2:
            let cell = cell as? HeaderCell
            cell?.iconView.image = UIImage(systemName: "\(icon[indexPath.row])")
            cell?.backgroundColor = colors[indexPath.row]
            let attributedTitle = NSMutableAttributedString(string: "\n\(sectors[indexPath.row])\n", attributes: [
                       .foregroundColor: UIColor.white,
                       .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
                   ])
            attributedTitle.append(NSAttributedString(string: "20 items\n", attributes: [ .foregroundColor: UIColor.white,
                           .font: UIFont.systemFont(ofSize: 8, weight: .regular)]))
            cell?.titleView.attributedText = attributedTitle

        case 3:
            let cell = cell as? ChipCell
            cell?.layer.borderWidth = 0.4
            cell?.layer.borderColor = UIColor.systemGray.cgColor
            let attributedTitle = NSMutableAttributedString(string: "\(types[indexPath.row])\n", attributes: [
                       .foregroundColor: UIColor.label,
                       .font: UIFont.systemFont(ofSize: 10, weight: .bold)
                   ])
            attributedTitle.append( NSAttributedString(string: "0.2% per month", attributes: [ .foregroundColor: UIColor.label,
                           .font: UIFont.systemFont(ofSize: 8, weight: .regular)]))
            cell?.titleView.attributedText = attributedTitle
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            performSegue(withIdentifier: "goToDetail", sender: self)
        }
    }

}

