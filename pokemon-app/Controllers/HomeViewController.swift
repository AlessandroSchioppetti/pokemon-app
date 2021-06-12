//
//  HomeViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var elements: [PokemonViewModel] = []
    var pokemonList: [Pokemon] = []
    
    var collectionView: UICollectionView?
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: 150)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        readPokemon()
    }
}

// MARK: - private
private extension HomeViewController {
    func readPokemon() {
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
        elements = pkList.map {
            let url = URL.pokemonImages.appendingPathComponent($0.name).appendingPathComponent("profileImages")
            let result = PokemonService.shared.readPkImages(from: url)
            switch result {
            case .success(let images):
                return PokemonViewModel(model: .init(name: $0.name, image: images.first))
            case .failure(let error):
                showAlert(error)
                return PokemonViewModel(model: .init(name: $0.name, image: UIImage(named: "not_found")))
            }
        }
        reloadData()
    }
    
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
        navigationController?.navigationBar.barTintColor = ColorLayout.lightRed
        let logo = UIImage(named: "pokemon_logo.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func showAlert(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = elements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath)
        viewModel.configure(view: cell)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let name = elements[indexPath.row].model?.name,
              let index = pokemonList.firstIndex(where: { $0.name == name }) else { return }
        navigationController?.pushViewController(PokemonDetailViewController(pokemon: pokemonList[index]), animated: true)
    }
}
