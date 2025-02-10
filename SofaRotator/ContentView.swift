//
//  ContentView.swift
//  SofaRotator
//
//  Created by Axel Schmidt on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation: Double = 0
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                TesseractView(rotationAngle: rotation)
                    .frame(width: min(geometry.size.width, geometry.size.height) * 0.95,
                           height: min(geometry.size.width, geometry.size.height) * 0.95)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
        .onReceive(timer) { _ in
            // Continuous smooth rotation using sine function
            rotation += 0.005
            // No need to reset, let it continue
        }
    }
}

#Preview {
    ContentView()
}
