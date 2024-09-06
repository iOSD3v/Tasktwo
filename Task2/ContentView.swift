//
//  ContentView.swift
//  Task2
//
//  Created by Fahimah on 8/28/24.
//

import SwiftUI

struct Config: Codable {
    var value: SwitchValue
    var toggle: Bool
}

struct Item: Identifiable, Codable {
    var id: Int
    var config: Config
    var title: String
    var description: String
}

enum SwitchValue: String, CaseIterable, Codable, Identifiable {
    var id: Self { self }
    case zero
    case one
    case two
}

struct State: Codable {
    
    var items: [Item]
}

class ItemsConfigs: ObservableObject {
    @AppStorage("items21") var items: [Item] = []
    
    
    func addItem() {
        self.items.append(
            Item(id: items.count + 1, config: Config(value: .one, toggle: false), title: "item 1", description: "description 1"))
        self.objectWillChange.send()
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        if let data  = try? JSONDecoder().decode([Element].self, from: rawValue.data(using: .utf8)!) {
            self = data
        } else {
            self = []
        }
        
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self), let result = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return result
    }
}

struct ItemsView: View {
    @EnvironmentObject var itemConfigs: ItemsConfigs
    var body: some View {
        VStack {
            Button {
                itemConfigs.addItem()
            } label: {
                Text("add")
            }
            
            List($itemConfigs.items) { item in
                HStack {
                    Picker("title", selection: item.config.value) {
                        ForEach(SwitchValue.allCases) { value in
                            Text(value.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented)
                    Toggle(isOn: item.config.toggle) {
                        Text(item.title.wrappedValue + "\(item.config.toggle.wrappedValue)")
                    }
                }
            }
        }
        
    }
}
