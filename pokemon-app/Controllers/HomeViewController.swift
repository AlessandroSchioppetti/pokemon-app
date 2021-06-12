//
//  HomeViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }
}

private extension HomeViewController {
    func setupView() {
        view.backgroundColor = ColorLayout.backgroundColor
        
        
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = ColorLayout.lightRed
        let logo = UIImage(named: "pokemon_logo.png")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}
