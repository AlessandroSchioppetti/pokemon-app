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
        view.backgroundColor = .red
        view.add(logoImageView)
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "pokemon_logo")
        
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
