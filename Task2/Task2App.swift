//
//  Task2App.swift
//  Task2
//
//  Created by Fahimah on 8/28/24.
//

import SwiftUI
import Combine

@main
struct Task2App: App {
    @StateObject var itemConfigs = ItemsConfigs()
    
    
    var body: some Scene {
        WindowGroup {
            ItemsView().environmentObject(itemConfigs)
        }
    }
}
