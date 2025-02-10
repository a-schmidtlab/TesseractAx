import SwiftUI

struct TesseractView: View {
    var rotationAngle: Double
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width/2, y: size.height/2)
            let scale = min(size.width, size.height) * 0.8
            
            // Create inner cube vertices (smaller scale for w coordinate)
            let innerCube = [
                project(x: -0.5, y: -0.5, z: -0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 0.5, y: -0.5, z: -0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 0.5, y: 0.5, z: -0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: -0.5, y: 0.5, z: -0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: -0.5, y: -0.5, z: 0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 0.5, y: -0.5, z: 0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 0.5, y: 0.5, z: 0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: -0.5, y: 0.5, z: 0.5, w: 0.5, angle: rotationAngle, scale: scale, center: center)
            ]
            
            // Create outer cube vertices
            let outerCube = [
                project(x: -1, y: -1, z: -1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 1, y: -1, z: -1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 1, y: 1, z: -1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: -1, y: 1, z: -1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: -1, y: -1, z: 1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 1, y: -1, z: 1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: 1, y: 1, z: 1, w: -0.5, angle: rotationAngle, scale: scale, center: center),
                project(x: -1, y: 1, z: 1, w: -0.5, angle: rotationAngle, scale: scale, center: center)
            ]
            
            // Draw all lines with consistent thickness
            let lineWidth: CGFloat = 2
            
            // Draw connections between cubes
            for i in 0..<8 {
                let path = Path { p in
                    p.move(to: innerCube[i])
                    p.addLine(to: outerCube[i])
                }
                context.stroke(path, with: .color(.blue.opacity(0.8)), lineWidth: lineWidth)
            }
            
            // Draw outer cube
            drawCube(context: context, vertices: outerCube, opacity: 0.8, lineWidth: lineWidth)
            
            // Draw inner cube
            drawCube(context: context, vertices: innerCube, opacity: 0.8, lineWidth: lineWidth)
        }
    }
    
    private func project(x: Double, y: Double, z: Double, w: Double, angle: Double, scale: Double, center: CGPoint) -> CGPoint {
        // First rotate in XY plane
        let (rotX1, rotY1) = rotatePoint(x: x, y: y, angle: angle)
        
        // Then rotate in XZ plane
        let (rotX2, rotZ1) = rotatePoint(x: rotX1, y: z, angle: sin(angle * 0.5))
        
        // Finally rotate in YZ plane
        let (rotY2, _) = rotatePoint(x: rotY1, y: rotZ1, angle: cos(angle * 0.3))
        
        // 4D to 3D projection with w-coordinate
        let distance = 5.0
        let w4 = w * sin(angle * 0.5) // Use sine for smooth w coordinate animation
        let perspective = 1.0 / (distance - w4)
        
        // Apply perspective projection
        let projectedX = rotX2 * perspective
        let projectedY = rotY2 * perspective
        
        return CGPoint(
            x: center.x + projectedX * scale,
            y: center.y + projectedY * scale
        )
    }
    
    private func rotatePoint(x: Double, y: Double, angle: Double) -> (Double, Double) {
        let cosA = cos(angle)
        let sinA = sin(angle)
        return (
            x * cosA - y * sinA,
            x * sinA + y * cosA
        )
    }
    
    private func drawCube(context: GraphicsContext, vertices: [CGPoint], opacity: Double, lineWidth: CGFloat) {
        let edges = [
            (0, 1), (1, 2), (2, 3), (3, 0),  // Front face
            (4, 5), (5, 6), (6, 7), (7, 4),  // Back face
            (0, 4), (1, 5), (2, 6), (3, 7)   // Connecting edges
        ]
        
        for edge in edges {
            let path = Path { p in
                p.move(to: vertices[edge.0])
                p.addLine(to: vertices[edge.1])
            }
            context.stroke(path, with: .color(.blue.opacity(opacity)), lineWidth: lineWidth)
        }
    }
}

#Preview {
    TesseractView(rotationAngle: 0)
        .frame(width: 300, height: 300)
        .background(Color.black)
} 
