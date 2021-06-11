//
//  SplashViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

protocol SplashViewControllerDelegate: class {
    func didFinishLoading()
}

class SplashViewController: UIViewController {
    weak var delegate: SplashViewControllerDelegate?
    
    let logoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - private
private extension SplashViewController {
    func setupView() {
        view.backgroundColor = ColorLayout.lightRed
        view.add(logoImageView)
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "pokemon_logo")
        
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
