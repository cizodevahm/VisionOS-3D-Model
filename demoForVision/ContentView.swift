//
//  ContentView.swift
//  demoForVision
//
//  Created by Hitesh Thummar on 02/04/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var dataArr:[String] = ["flower_tulip","robot_walk_idle","sneaker_airforce","sneaker_pegasustrail","teapot","toy_biplane_idle","toy_car","toy_drummer_idle"]
    
    @EnvironmentObject var navVM: NavigationViewModel
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 350))], spacing: 20) {
                ForEach(dataArr,id: \.self) { item in
                    HStack{
                        Button(action: {
                            navVM.selectedItem = item
                            openWindow(id: "item")
                            
                        }, label: {
                            Model3D(named: item) { model in
                                model
                                    .resizable()
                                    .aspectRatio(contentMode:.fit)
                                
                            } placeholder: {
                                
                            }.frame(width: 160, height: 160)
                                .padding(.bottom, 32)
                            
                            Text(item)
                        })
                        .buttonStyle(.borderless)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}


class NavigationViewModel: ObservableObject {
    @Published var selectedItem: String?
    @Published var selectedModel:ModelEntity?
    
    init(selectedItem: String? = nil,selectedModel: ModelEntity? = nil) {
        self.selectedItem = selectedItem
        self.selectedModel = selectedModel
    }
}

