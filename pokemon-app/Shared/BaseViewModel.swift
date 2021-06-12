//
//  BaseViewModel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

open class BaseViewModel<V: UIView, M>: ViewModel {
    public typealias ViewType = V

    public weak var view: V?
    public var model: M?

    public init(model: M?) {
        self.model = model
    }

    public final func configure(view: V?) {
        self.view = view
        self.configure()
    }

    // MARK: ViewModel to override
    open func configure() {
    }
}
