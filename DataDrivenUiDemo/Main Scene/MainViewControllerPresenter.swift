//
//  MainViewControllerPresenter.swift
//  DataDrivenUiDemo
//
//  Created by Anton Ogarkov on 5/7/19.
//  Copyright © 2019 Ogarkov. All rights reserved.
//

import Foundation

final class MainViewControllerPresenter {

    private let mainViewController: MainViewController
    private let onSystemItemSelect: (System.Item) -> Void

    var reloadCallback: () -> Void = { assertionFailure("Reload callback not set!") }

    init(viewController: MainViewController, onSystemItemSelect: @escaping (System.Item) -> Void) {
        self.mainViewController = viewController
        self.onSystemItemSelect = onSystemItemSelect
    }

    func present(isLoading: Bool, systems: [System]?) {
        if isLoading {
            mainViewController.render(props: .loading)
        } else {
            mainViewController.render(props: .init(systems: systems ?? [],
                                                   onSystemItemSelect: onSystemItemSelect,
                                                   reloadCallback: reloadCallback))
        }
    }
}

extension MainViewController.Props {

    init(systems: [System], onSystemItemSelect: @escaping (System.Item) -> Void, reloadCallback: @escaping () -> Void) {
        let sections = systems.map { system in
            return MainViewController.Data.Section(title: system.name, rows: system.items.map { item in
                return MainViewController.Data.Section.Row(title: item.name, onSelect: {
                    onSystemItemSelect(item)
                })
            })
        }

        self = .loaded(data: MainViewController.Data(sections: sections), reloadCallback: reloadCallback)
    }
}
