//
//  PokemonInfoCell.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 13/06/2021.
//

import UIKit

class PokemonInfoCell: UICollectionViewCell {
    
    class PaddingLabel: UILabel {
        override func drawText(in rect: CGRect) {
            let insets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
            super.drawText(in: rect.inset(by: insets))
        }
    }
    
    let titleLabel = PaddingLabel()
    let infoStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - private
private extension PokemonInfoCell {
    func setupView() {
        contentView.add(titleLabel)
        contentView.add(infoStackView)
        
        infoStackView.axis = .vertical
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 60.0),
            
            infoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
