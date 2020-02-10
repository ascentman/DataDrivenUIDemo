import UIKit

class EmptyStateViewController: UIViewController {

    struct Props {
        static let defaultValue = Props(didPressReloadButton: {})
        let didPressReloadButton: () -> Void
    }

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props
    }

    @IBAction func reloadButtonTouch(_ sender: Any) {
        props.didPressReloadButton()
    }
}
