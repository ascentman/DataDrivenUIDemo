import UIKit

class SelectorViewController: UIViewController {

    struct Props {
        static let defaultValue = Props(tabs: [])

        struct Tab {
            let title: String
            let onSelect: ()->()
        }

        let tabs: [Tab]
    }

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props

        for (index, tab) in props.tabs.enumerated() {
            segmentedControl.setTitle(tab.title, forSegmentAt:index)
        }
    }

    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func didSelectSegment(_ sender: Any) {
        props.tabs[segmentedControl.selectedSegmentIndex].onSelect()
    }
}
