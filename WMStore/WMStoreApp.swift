//
//  WMStoreApp.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import SwiftUI
import SwiftData

@main
struct WMStoreApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
            }
        }
        .modelContainer(for: Cart.self)
    }
}
