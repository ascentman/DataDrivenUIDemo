import UIKit

class MainTableViewController: UITableViewController {

    struct Props {
        let items: [Item]

        struct Item {
            let title: String

            let onSelectAction: () -> Void
        }

        static let defaultValue = Props(items: [])
    }

    private var props = Props.defaultValue

    func render(props: Props) {
        self.props = props

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        guard props.items.count > indexPath.row else {
            return cell
        }

        cell.textLabel?.text = props.items[indexPath.row].title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.items[indexPath.row].onSelectAction()
    }
}
