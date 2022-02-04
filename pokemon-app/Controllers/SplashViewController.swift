//
//  SplashViewController.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

class SplashViewController: UIViewController {
    let goToHome: () -> Void
    private let logoImageView = UIImageView()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    init(goToHome: @escaping () -> Void) {
        self.goToHome = goToHome
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadDataIfNeeded()
    }
}

// MARK: - private
private extension SplashViewController {
    func setupView() {
        view.backgroundColor = ColorLayout.lightRed
        view.add(logoImageView)
        view.add(indicator)
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "pokemon_logo")
        
        indicator.style = .large
        indicator.color = ColorLayout.lightBlue
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            indicator.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadDataIfNeeded() {
        if FileManager.default.fileExists(atPath: URL.applicationSupportDirectory.appendingPathComponent("Images").path) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.goToHome()
            }
        } else {
            loadData()
        }
    }
    
    func loadData() {
        indicator.startAnimating()
        PokemonService.shared.getAndSavePokemon { [weak self] error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.goToHome()
            }
        }
    }
}
