//
//  PokemonDetailViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    let pokemon: Pokemon
    
    enum Sections: Int, CaseIterable {
        case profileImage
        case type
        case stat
        case gallery
    }
    
    var elements: [[AnyViewModel]] = []
    
    var collectionView: UICollectionView?
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 1_000)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
        scaffolding()
    }
    
    public init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private
private extension PokemonDetailViewController {
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }

        collectionView.backgroundColor = ColorLayout.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PokemonCell.self)

        view.add(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigation() {
        
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "img_arrow_left"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(backButtonPressed))
        backButton.tintColor = ColorLayout.black
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func scaffolding() {
        Sections.allCases.forEach { _ in self.elements.append([]) }
    }
    
    // MARK: objc
    @objc
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension PokemonDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = elements[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath)
        viewModel.configure(view: cell)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {}


