//
//  ViewModel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

public protocol AnyViewModel {
    var cellIdentifier: String { get }

    func configure<V: UICollectionViewCell>(view: V)
}

public protocol ViewModel: AnyViewModel {
    associatedtype View
    associatedtype Model

    var view: View? { get }
    var model: Model? { get }

    func configure(view: View?)
}

public extension ViewModel where Self: AnyViewModel {

    var cellIdentifier: String {
        String(describing: View.self)
    }

    func configure<V>(view: V) where V: UICollectionViewCell {
        guard let view = view as? View else { return }
        configure(view: view)
    }

}
