//
//  ContentView.swift
//  SofaRotator
//
//  Created by Axel Schmidt on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation: Double = 0
    // Increase frame rate to 120 fps for smoother animation
    let timer = Timer.publish(every: 1/120, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                // Center the tesseract and make it fill most of the screen
                TesseractView(rotationAngle: rotation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onReceive(timer) { _ in
            // Adjust rotation speed for smooth movement
            rotation += 0.02
        }
    }
}

#Preview {
    ContentView()
}
