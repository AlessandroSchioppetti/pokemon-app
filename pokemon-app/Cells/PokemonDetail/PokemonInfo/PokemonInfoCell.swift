//
//  PokemonInfoCell.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 13/06/2021.
//

import UIKit

class PokemonInfoCell: UICollectionViewCell {
    let titleLabel = PaddingLabel()
    let infoStackView = UIStackView()
    
    let labelHeight: CGFloat = 50.0
    
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
            titleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            infoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
