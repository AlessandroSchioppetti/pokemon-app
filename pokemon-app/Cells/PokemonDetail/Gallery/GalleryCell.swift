//
//  GalleryCell.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 13/06/2021.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    let titleLabel = PaddingLabel()
    var elements: [ImageViewModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    let cellHeight: CGFloat = 170
    var collectionView: UICollectionView?
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private
private extension GalleryCell {
    func setupView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }

        collectionView.backgroundColor = ColorLayout.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self)

        contentView.add(titleLabel)
        contentView.add(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50.0),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cellHeight),
            collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
        ])
    }
    
    func reloadData() {
        DispatchQueue.main.async { self.collectionView?.reloadData() }
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = elements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath)
        viewModel.configure(view: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}
