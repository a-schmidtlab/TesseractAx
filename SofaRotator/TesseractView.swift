/*
 * TesseractView.swift
 * SofaRotator
 *
 * Created by Axel Schmidt on 10.02.25.
 * Copyright © 2025 Axel Schmidt. All rights reserved.
 */

import SwiftUI

/// Hauptansicht für die Tesseract-Visualisierung (Main view for tesseract visualization)
struct TesseractView: View {
    var rotationAngle: Double
    
    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width/2, y: size.height/2)
            let scale = min(size.width, size.height) * 6.0
            
            // Erzeuge Vertices mit verbesserter 4D-Perspektive
            let innerCube = createVertices(scale: 0.5, w: 0.5, angle: rotationAngle, viewScale: scale, center: center)
            let outerCube = createVertices(scale: 1.0, w: -0.5, angle: rotationAngle, viewScale: scale, center: center)
            
            // Zeichne mit tiefenbasierter Transparenz (Draw with depth-based opacity)
            drawConnections(context: context, from: innerCube, to: outerCube)
            drawCube(context: context, vertices: outerCube)
            drawCube(context: context, vertices: innerCube)
        }
    }
    
    /// Erzeugt die Eckpunkte für einen Würfel im 4D-Raum
    /// - Parameters:
    ///   - scale: Skalierungsfaktor für die Größe
    ///   - w: Position in der vierten Dimension
    ///   - angle: Rotationswinkel
    ///   - viewScale: Ansichtsskalierung
    ///   - center: Bildschirmmittelpunkt
    private func createVertices(scale: Double, w: Double, angle: Double, viewScale: Double, center: CGPoint) -> [(point: CGPoint, depth: Double)] {
        // Würfeleckpunkte im 3D-Raum
        let vertices = [
            (-scale, -scale, -scale), (scale, -scale, -scale),
            (scale, scale, -scale), (-scale, scale, -scale),
            (-scale, -scale, scale), (scale, -scale, scale),
            (scale, scale, scale), (-scale, scale, scale)
        ]
        
        return vertices.map { (x, y, z) in
            let projected = project4D(
                x: x, y: y, z: z, w: w,
                xwAngle: angle,
                yzAngle: angle * 0.7,  // Goldener Schnitt Approximation
                xyAngle: angle * 0.5,
                zwAngle: angle * 0.3,
                scale: viewScale,
                center: center
            )
            return (point: projected.point, depth: projected.depth)
        }
    }
    
    /// Projektionsberechnung für 4D → 2D Transformation
    private func project4D(
        x: Double, y: Double, z: Double, w: Double,
        xwAngle: Double, yzAngle: Double, xyAngle: Double, zwAngle: Double,
        scale: Double, center: CGPoint
    ) -> (point: CGPoint, depth: Double) {
        // Rotationen in verschiedenen 4D-Ebenen (Drehungen)
        var (rotX, rotW) = rotate2D(x: x, y: w, angle: xwAngle)
        var (rotY, rotZ) = rotate2D(x: y, y: z, angle: yzAngle)
        (rotX, rotY) = rotate2D(x: rotX, y: rotY, angle: xyAngle)
        (rotZ, rotW) = rotate2D(x: rotZ, y: rotW, angle: zwAngle)
        
        // Stereographische Projektion: 4D → 3D (Raumprojektion)
        let distance = 5.0
        let w1 = 1.0 / (distance - rotW)
        let projX = rotX * w1
        let projY = rotY * w1
        let projZ = rotZ * w1
        
        // Perspektivische Projektion: 3D → 2D mit Tiefeneffekt
        let viewDistance = 4.0
        let perspective = 1.0 / (viewDistance - projZ)
        let screenX = projX * perspective
        let screenY = projY * perspective
        
        return (
            point: CGPoint(
                x: center.x + screenX * scale,
                y: center.y + screenY * scale
            ),
            depth: perspective
        )
    }
    
    /// Rotationsmatrix für 2D-Ebene (Drehmatrix)
    private func rotate2D(x: Double, y: Double, angle: Double) -> (Double, Double) {
        let cosA = cos(angle)
        let sinA = sin(angle)
        return (
            x * cosA - y * sinA,
            x * sinA + y * cosA
        )
    }
    
    /// Zeichnet Verbindungslinien zwischen inneren und äußeren Würfelpunkten
    private func drawConnections(context: GraphicsContext, from: [(point: CGPoint, depth: Double)], to: [(point: CGPoint, depth: Double)]) {
        for i in 0..<8 {
            let path = Path { p in
                p.move(to: from[i].point)
                p.addLine(to: to[i].point)
            }
            
            // Berechne Transparenz basierend auf Tiefe
            let avgDepth = (from[i].depth + to[i].depth) / 2
            let opacity = calculateOpacity(depth: avgDepth)
            
            // Farbverlauf basierend auf Tiefe
            let gradient = Gradient(colors: [
                Color.blue.opacity(opacity * 0.8),
                Color.cyan.opacity(opacity * 0.6)
            ])
            
            context.stroke(
                path,
                with: .linearGradient(
                    gradient,
                    startPoint: from[i].point,
                    endPoint: to[i].point
                ),
                lineWidth: 2.0
            )
        }
    }
    
    /// Zeichnet einen Würfel mit tiefenbasierter Transparenz
    private func drawCube(context: GraphicsContext, vertices: [(point: CGPoint, depth: Double)]) {
        let edges = [
            (0, 1), (1, 2), (2, 3), (3, 0),  // Vorderseite
            (4, 5), (5, 6), (6, 7), (7, 4),  // Rückseite
            (0, 4), (1, 5), (2, 6), (3, 7)   // Verbindungskanten
        ]
        
        for edge in edges {
            let path = Path { p in
                p.move(to: vertices[edge.0].point)
                p.addLine(to: vertices[edge.1].point)
            }
            
            let avgDepth = (vertices[edge.0].depth + vertices[edge.1].depth) / 2
            let opacity = calculateOpacity(depth: avgDepth)
            
            let gradient = Gradient(colors: [
                Color.blue.opacity(opacity),
                Color.cyan.opacity(opacity * 0.8)
            ])
            
            context.stroke(
                path,
                with: .linearGradient(
                    gradient,
                    startPoint: vertices[edge.0].point,
                    endPoint: vertices[edge.1].point
                ),
                lineWidth: 2.0
            )
        }
    }
    
    /// Berechnet die Transparenz basierend auf der Tiefe
    private func calculateOpacity(depth: Double) -> Double {
        return min(max(0.2 + depth * 2, 0.2), 1.0)
    }
}

#Preview {
    TesseractView(rotationAngle: 0)
        .frame(width: 300, height: 300)
        .background(Color.black)
} 
