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
    
    enum PokemonInfo: String {
        case types = "Types"
        case stats = "Stats"
    }
    
    var elements: [[AnyViewModel]] = []
    
    var collectionView: UICollectionView?
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 30.0
        layout.estimatedItemSize = CGSize(width: view.frame.width, height: 1_000)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
        scaffolding()
        setupCollectionDataSource()
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
    func setupCollectionDataSource() {
        let profileImageViewModel = ImageViewModel(model: ImageModel(image: getProfileImage(),
                                                                     height: 300,
                                                                     width: 300,
                                                                     cornerRadius: 150,
                                                                     borderWidth: 2.0,
                                                                     borderColor: ColorLayout.darkYellow))
        
        let typesViewModel = PokemonInfoViewModel(model: .init(title: PokemonInfo.types.rawValue,
                                                               info: pokemon.typeList))
        
        let statsViewModel = PokemonInfoViewModel(model: .init(title: PokemonInfo.stats.rawValue,
                                                               info: pokemon.statsList))
        
        elements[Sections.profileImage.rawValue] = [profileImageViewModel]
        elements[Sections.type.rawValue] = [typesViewModel]
        elements[Sections.stat.rawValue] = [statsViewModel]
        reloadData()
    }
    
    func getProfileImage() -> UIImage {
        let result = PokemonService.shared.readPkImages(from: URL.pokemonImages.appendingPathComponent(pokemon.name).appendingPathComponent("profileImages"))
        switch result {
        case .success(let images):
            return images.first ?? UIImage()
        case .failure(let error):
            showAlert(error)
            return UIImage()
        }
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }

        collectionView.backgroundColor = ColorLayout.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self)
        collectionView.register(PokemonInfoCell.self)

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
        
        let titleLabel = UILabel()
        titleLabel.configure(with: .init(text: pokemon.name, font: UIFont.systemFont(ofSize: 25, weight: .heavy), textColor: ColorLayout.baseTextColor, textAlignment: .center))
        
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = backButton
    }
    
    func scaffolding() {
        Sections.allCases.forEach { _ in self.elements.append([]) }
    }
    
    func showAlert(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 30, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDelegate
extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {}


