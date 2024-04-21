//
//  demoForVisionApp.swift
//  demoForVision
//
//  Created by Hitesh Thummar on 02/04/24.
//

import SwiftUI

@main
struct demoForVisionApp: App {
    
    @StateObject var navVM = NavigationViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(navVM)
        }
        WindowGroup(id: "item") {
            InventoryItemView().environmentObject(navVM)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1, in: .meters)
        
//        ImmersiveSpace(id: "ImmersiveSpace") {
//            ImmersiveView()
//        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
