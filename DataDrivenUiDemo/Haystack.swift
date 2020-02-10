import Foundation

struct System {
    let id: String
    let name: String
    let items: [Item]
    struct Item {
        let name: String
        let configurations: [Configuration]
        struct Configuration {
            let name: String
            let value: String
        }
    }
}

protocol HaystackDelegate: class {
    func dataLoaded(systems: [System])
}

class Haystack {
    
    weak var delegate: HaystackDelegate?

    func loadSystems() {

        let tomHeating = System.Item(name: "Heating", configurations: [
            System.Item.Configuration(name: "Indoor Temperature", value: "+22.3C"),
            System.Item.Configuration(name: "Outdoor Temperature", value: "-3.5C"),
            System.Item.Configuration(name: "Hot Water Temperature", value: "+65.3C")
            ])
        let tomCooling = System.Item(name: "Cooling", configurations: [
            System.Item.Configuration(name: "Indoor Temperature", value: "+22.3C"),
            System.Item.Configuration(name: "Outdoor Temperature", value: "-3.5C"),
            System.Item.Configuration(name: "Fan speed", value: "+65.3C")
            ])
        let tomPool = System.Item(name: "Pool", configurations: [
            System.Item.Configuration(name: "Water Temperature", value: "+22.3C"),
            System.Item.Configuration(name: "Water level", value: "2m"),
            System.Item.Configuration(name: "Sun level", value: "damn hot")
            ])
        let tomSystem = System(id: "Tom's System", name: "Tom's System", items: [tomHeating, tomCooling, tomPool])

        let vladimirNuclearReactor = System.Item(name: "Nuclear Reactor", configurations: [
            System.Item.Configuration(name: "Core Temperature", value: "+22 000.3C"),
            System.Item.Configuration(name: "Outdoor Temperature", value: "-3.5C"),
            System.Item.Configuration(name: "Vapor Temperature", value: "+443.8C"),
            System.Item.Configuration(name: "Output Power", value: "over 9000 MW")
            ])
        let vladimirSystem = System(id: "Vladimir's System", name: "Vladimir's System", items: [vladimirNuclearReactor])

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.delegate?.dataLoaded(systems: [tomSystem, vladimirSystem])
        }
    }
}
