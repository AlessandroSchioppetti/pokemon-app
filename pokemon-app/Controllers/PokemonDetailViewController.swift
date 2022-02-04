//
//  PokemonDetailViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

class PokemonDetailViewController: CollectionViewController {
    let pokemon: Pokemon
    
    enum Sections: Int, CaseIterable {
        case profileImage
        case type
        case stat
        case gallery
        
        var title: String {
            switch self {
            case .type:
                return "Types"
            case .stat:
                return "Stats"
            case .gallery:
                return "Gallery"
            default:
                return ""
            }
        }
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
    
    // MARK: CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 30, left: 0, bottom: 0, right: 0)
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
        
        let typesViewModel = PokemonInfoViewModel(model: .init(title: Sections.type.title,
                                                               info: pokemon.typeList))
        
        let statsViewModel = PokemonInfoViewModel(model: .init(title: Sections.type.title,
                                                               info: pokemon.statsList))
        
        let imageModelList: [ImageModel] = getGalleryImages().map { ImageModel(image: $0,
                                                                               height: 120,
                                                                               width: 120,
                                                                               cornerRadius: 60,
                                                                               borderWidth: 1,
                                                                               borderColor: ColorLayout.darkYellow) }
        let galleryViewModel = GalleryViewModel(model: .init(titleName: Sections.gallery.title,
                                                             imageModelList: imageModelList))
        
        elements[Sections.profileImage.rawValue] = [profileImageViewModel]
        elements[Sections.type.rawValue] = [typesViewModel]
        elements[Sections.stat.rawValue] = [statsViewModel]
        elements[Sections.gallery.rawValue] = [galleryViewModel]
        reloadData()
    }
    
    func getProfileImage() -> UIImage {
        let result = PokemonService.shared.readPkImages(from: URL.pokemonImages.appendingPathComponent(pokemon.name).appendingPathComponent(Dir.profileImage.rawValue))
        switch result {
        case .success(let images):
            return images.first ?? UIImage()
        case .failure(let error):
            showAlert(error)
            return UIImage()
        }
    }
    
    func getGalleryImages() -> [UIImage] {
        let result = PokemonService.shared.readPkImages(from: URL.pokemonImages.appendingPathComponent(pokemon.name).appendingPathComponent(Dir.galleryImages.rawValue))
        switch result {
        case .success(let images):
            return images
        case .failure(let error):
            showAlert(error)
            return []
        }
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = ColorLayout.backgroundColor
        collectionView.register(ImageCell.self)
        collectionView.register(PokemonInfoCell.self)
        collectionView.register(GalleryCell.self)
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
    
    // MARK: objc
    @objc
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}


