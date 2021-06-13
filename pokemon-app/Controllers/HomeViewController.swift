//
//  HomeViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

class HomeViewController: CollectionViewController {
    
    var pokemonList: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionDataSource()
    }
    
    // MARK: - collectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = elements[indexPath.section][indexPath.row] as? PokemonViewModel,
              let name = viewModel.model?.name,
              let index = pokemonList.firstIndex(where: { $0.name == name }) else { return }
        navigationController?.pushViewController(PokemonDetailViewController(pokemon: pokemonList[index]), animated: true)
    }
}

// MARK: - private
private extension HomeViewController {
    func setupCollectionDataSource() {
        let result = PokemonService.shared.readPokemon()
        switch result {
        case .success(let pokemonList):
            self.pokemonList = pokemonList
            generateViewModel(from: pokemonList)
        case .failure(let error):
            showAlert(error)
        }
    }
    
    func generateViewModel(from pkList: [Pokemon]) {
        elements = [pkList.map {
            let url = URL.pokemonImages.appendingPathComponent($0.name).appendingPathComponent(Dir.profileImage.rawValue)
            let result = PokemonService.shared.readPkImages(from: url)
            switch result {
            case .success(let images):
                return PokemonViewModel(model: .init(name: $0.name, image: images.first))
            case .failure(let error):
                showAlert(error)
                return PokemonViewModel(model: .init(name: $0.name, image: UIImage()))
            }
        }]
        reloadData()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = ColorLayout.backgroundColor
        collectionViewLayout.itemSize = CGSize(width: view.frame.width, height: 150)
        collectionView.register(PokemonCell.self)
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = ColorLayout.lightRed
        let logo = UIImage(named: "pokemon_logo.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}
