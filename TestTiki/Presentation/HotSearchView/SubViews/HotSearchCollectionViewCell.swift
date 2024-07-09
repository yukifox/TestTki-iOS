//
//  HotSearchCollectionViewCell.swift
//  TestTiki
//
//  Created by Huy Trần on 8/7/24.
//
import UIKit

class HotSearchCollectionViewCell: UICollectionViewCell {
    static let minimumWidth: CGFloat = 96
    static let sizeIcon = 60
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
        return containerView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = Color.white
        titleLabel.clipsToBounds = true
        titleLabel.numberOfLines = 2
        titleLabel.backgroundColor = UIColor.green
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = UIConstraints.View.cornerRadius
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Color.white
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(icon)
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        icon.snp.makeConstraints {
            $0.size.equalTo(HotSearchCollectionViewCell.sizeIcon)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(icon.snp.bottom).offset(UIConstraints.leftPadding)
            $0.leading.trailing.equalToSuperview().inset(UIConstraints.betweenPadding)
            $0.bottom.equalToSuperview().inset(UIConstraints.betweenPadding)
        }
        
    }
    
    func setupData(data: HotsearchModel) {
        if let title = data.name {
            let components = title.components(separatedBy: .whitespacesAndNewlines)
            let words = components.filter { !$0.isEmpty }
            if words.count > 1,
               (title.widthOfString(usingFont: UIFont.systemFont(ofSize: 14, weight: .medium)) + UIConstraints.betweenPadding) < HotSearchCollectionViewCell.minimumWidth {
                var newTitle = title
                let indexValue = title.index(title.startIndex, offsetBy: words.first!.count)
                newTitle.replaceSubrange(indexValue...indexValue, with: "\n")
                titleLabel.text = newTitle
            } else {
                titleLabel.text = data.name
            }
        }
        icon.setImageURLString(data.icon)
        if let color = data.color {
            titleLabel.backgroundColor = hexStringToUIColor(hex: color)
        }
    }
    
    private func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
