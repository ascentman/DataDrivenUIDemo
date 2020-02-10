import UIKit

class DetailsTableViewController: UITableViewController {

    var props: Props = .initial
    struct Props {
        let title: String
        let items: [Item]

        struct Item {
            let name: String
            let description: String
        }

        static let initial: Props = Props(title: "",
                                          items: [])
    }

    func render(props: Props) {
        self.props = props
        self.title = props.title
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
        let item = self.props.items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.description
        return cell
    }
}
