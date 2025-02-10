//
//  ContentView.swift
//  SofaRotator
//
//  Created by Axel Schmidt on 10.02.25.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation: Double = 0
    @State private var showingInfo = false
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                // Center the tesseract and make it fill most of the screen
                TesseractView(rotationAngle: rotation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Keep the info button in the top-right corner
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { showingInfo = true }) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(.cyan.opacity(0.6))
                                .padding()
                        }
                        .accessibilityLabel("Information about the Tesseract")
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $showingInfo) {
                TesseractInfoView()
            }
        }
        .onReceive(timer) { _ in
            rotation += 0.005
        }
    }
}

#Preview {
    ContentView()
}
