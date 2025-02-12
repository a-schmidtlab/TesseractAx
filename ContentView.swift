import SwiftUI

struct ContentView: View {
    @State private var rotation: Double = 0
    let timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    
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
            rotation += 0.005
        }
    }
}

#Preview {
    ContentView()
} 