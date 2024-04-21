//
//  InventoryItemView.swift
//  demoForVision
//
//  Created by Hitesh Thummar on 03/04/24.
//

import RealityKit
import SwiftUI

struct InventoryItemView: View {
    
    @EnvironmentObject var navVM: NavigationViewModel
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = InventoryItemViewModel()
    // 3d rotation
    @State var angle: Angle = .degrees(0)
    @State var startAngle: Angle?
    
    @State var axis: (CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero)
    @State var startAxis: (CGFloat, CGFloat, CGFloat)?
    
    // ScaleEffect
    @State var scale: Double = 2
    @State var startScale: Double?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RealityView { _ in }
              update: { content in
                  
                  if let entity = vm.entity{
                      content.add(entity)
                  }
              }
              .rotation3DEffect(angle, axis: axis)
              .scaleEffect(scale)
              .simultaneousGesture(DragGesture()
                .onChanged({ value in
                    if let startAngle, let startAxis {
                        let _angle = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2)) + startAngle.degrees
                        let axisX = ((-value.translation.height + startAxis.0) / CGFloat(_angle))
                        let axisY = ((value.translation.width + startAxis.1) / CGFloat(_angle))
                        angle = Angle(degrees: Double(_angle))
                        axis = (axisX, axisY, 0)
                    } else {
                        startAngle = angle
                        startAxis = axis
                    }
                }).onEnded({ _ in
                    startAngle = angle
                    startAxis = axis
                }))
              .simultaneousGesture(MagnifyGesture()
                .onChanged { value in
                    if let startScale {
                        scale = max(1, min(3, value.magnification * startScale))
                    } else {
                        startScale = scale
                    }
                }
                .onEnded { _ in
                    startScale = scale
                }
              )
              .zIndex(1)
        }
        .onAppear {
            guard let item = navVM.selectedItem else { return }
            vm.listenToItem(modelName: item)
        }
    }
}

#Preview {
    @StateObject var navVM = NavigationViewModel(selectedItem: "Pilar")
    return InventoryItemView().environmentObject(navVM)
}
