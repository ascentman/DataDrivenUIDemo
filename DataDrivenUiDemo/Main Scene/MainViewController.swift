import UIKit

extension MainTableViewController.Props {
    init(with section: MainViewController.Data.Section) {
        items = section.rows.map { row in
            return MainTableViewController.Props.Item(title: row.title, onSelectAction: row.onSelect)
        }
    }
}

class MainViewController: UIViewController {
    @IBOutlet weak var loadingContainerView: UIView!
    @IBOutlet weak var emptyStateContainerView: UIView!

    var mainTableViewController: MainTableViewController?
    var selectorViewController: SelectorViewController?
    var emptyStateViewController: EmptyStateViewController?

    enum Props {
        static let defaultValue = Props.loading

        case loading
        case loaded(data: Data, reloadCallback: () -> Void)
    }

    struct Data {
        let sections: [Section]

        struct Section {
            let title: String
            let rows: [Row]

            struct Row {
                let title: String
                let onSelect: () -> Void
            }
        }
    }

    private var props = Props.defaultValue

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Systems"
        self.render(props: props)
    }

    func reloadHaystackData() {
        emptyStateContainerView.isHidden = true
        loadingContainerView.isHidden = false
    }

    func render(props: Props) {
        self.props = props

        if self.isViewLoaded {
            self.emptyStateContainerView.isHidden = true
            self.loadingContainerView.isHidden = true

            switch props {
            case .loading:
                self.loadingContainerView.isHidden = false
            case .loaded(data: let data, reloadCallback: let reloadCallback):
                self.emptyStateContainerView.isHidden = !data.sections.isEmpty

                let tabs = data.sections.map({ section in
                    return SelectorViewController.Props.Tab(title: section.title, onSelect: { [weak self] in
                        self?.sectionSelected(section: section)
                    })
                })

                let selectorProps = SelectorViewController.Props(tabs: tabs)
                selectorViewController?.render(props: selectorProps)

                if let firstSection = data.sections.first {
                    let props = MainTableViewController.Props.init(with: firstSection)
                    mainTableViewController?.render(props: props)
                }
                emptyStateViewController?.render(props: EmptyStateViewController.Props(didPressReloadButton: { [weak self] in
                    self?.reloadHaystackData()
                    reloadCallback()
                }))
            }

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        switch segue.identifier {
        case "embedSelectorView":
            selectorViewController = segue.destination as? SelectorViewController
        case "embedTableView":
            mainTableViewController = segue.destination as? MainTableViewController
        case "embedEmptyStateView":
            emptyStateViewController = segue.destination as? EmptyStateViewController
        default:
            return
        }
    }

    private func didSelectItem(withName: String) {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }

    private func sectionSelected(section: Data.Section) {
        let props = MainTableViewController.Props(with: section)
        mainTableViewController?.render(props: props)
    }
}
