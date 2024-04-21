//
//  InventoryItemViewModel.swift
//  demoForVision
//
//  Created by Hitesh Thummar on 03/04/24.
//

import SwiftUI
import RealityKit
import Foundation

class InventoryItemViewModel: ObservableObject {
    @Published var modelName:String?
    @Published var entity:ModelEntity?

    
    func listenToItem(modelName:String) {
        Task { await self.fetchModel(modelName: modelName) }
    }
    
    @MainActor
    func fetchModel(modelName:String) async {
        do {
            let entity = try await ModelEntity(named:modelName)
            entity.name = modelName
            entity.generateCollisionShapes(recursive: true)
            entity.components.set(InputTargetComponent())
            self.entity = entity
        }catch{
            
        }
    }
    
}
