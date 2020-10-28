import UIKit

struct Section: Hashable {
    let id: String
    init(title: String = UUID().uuidString) {
        id = title
    }
}

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "sectionView"
    let label = UILabel()

    func setupHeader() {
        addSubview(label)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}
