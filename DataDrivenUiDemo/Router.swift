import UIKit

final class Router {

    private let navigationController = UINavigationController()
    private let haystack = Haystack()
    private var mainViewController: MainViewController?
    private var mainViewControllerPresenter: MainViewControllerPresenter?
    private var mainViewControllerInteractor: MainViewControllerInteractor?

    var rootViewController: UIViewController {
        return navigationController
    }

    // MARK: - Public

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            return
        }
        mainViewController = mainVC
        let presenter = MainViewControllerPresenter(viewController: mainVC) { [weak self] (item) in
            self?.showDetailsForSystemItem(item: item)
        }

        mainViewControllerInteractor = MainViewControllerInteractor(presenter: presenter, haystack: haystack)
        mainViewControllerPresenter = presenter
        mainViewControllerInteractor?.start()

        navigationController.pushViewController(mainVC, animated: false)
    }

    private func showDetailsForSystemItem(item: System.Item) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsController = storyboard.instantiateViewController(withIdentifier: "DetailsTableViewController") as? DetailsTableViewController else {
            return
        }

        detailsController.render(props: DetailsTableViewController.Props(with: item))

        navigationController.pushViewController(detailsController, animated: true)
    }
}

extension DetailsTableViewController.Props {

    init(with systemItem: System.Item) {
        self.items = systemItem.configurations.map {
            return DetailsTableViewController.Props.Item(name: $0.name, description: $0.value)
        }
        self.title = systemItem.name
    }
}
