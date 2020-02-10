//
//  MainViewControllerInteractor.swift
//  DataDrivenUiDemo
//
//  Created by Anton Ogarkov on 5/7/19.
//  Copyright © 2019 Ogarkov. All rights reserved.
//

import UIKit

final class MainViewControllerInteractor {

    private let presenter: MainViewControllerPresenter
    private let haystack: Haystack

    init(presenter: MainViewControllerPresenter, haystack: Haystack) {
        self.presenter = presenter
        self.haystack = haystack

        self.presenter.reloadCallback = {
            haystack.loadSystems()
        }
        
        haystack.delegate = self
    }

    func start() {
         haystack.loadSystems()
         presenter.present(isLoading: true, systems: nil)
    }
}

extension MainViewControllerInteractor: HaystackDelegate {

    // MARK: - HaystackDelegate

    func dataLoaded(systems: [System]) {
        presenter.present(isLoading: false, systems: systems)
    }
}
