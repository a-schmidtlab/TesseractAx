import SwiftUI

struct MathFormula: View {
    enum FormulaType {
        case rotationMatrix
        case quaternion
        case projection
        case dimensionalMapping
        case vertexCount
    }
    
    let type: FormulaType
    let size: CGFloat
    
    // Calculate font size based on view size and formula type
    private func calculateFontSize(for size: CGSize) -> CGFloat {
        let baseSize = min(size.width, size.height)
        switch type {
        case .rotationMatrix:
            return baseSize * 0.12
        case .quaternion:
            return baseSize * 0.25
        case .projection:
            return baseSize * 0.25
        case .dimensionalMapping:
            return baseSize * 0.14
        case .vertexCount:
            return baseSize * 0.13
        }
    }
    
    var body: some View {
        Canvas { context, size in
            // Common styling
            let textColor = Color.cyan
            let fontSize = calculateFontSize(for: size)
            let font = Font.custom("Courier", size: fontSize).bold()
            
            switch type {
            case .rotationMatrix:
                // Draw 4x4 rotation matrix
                let matrix = [
                    ["cos θ", "0", "0", "-sin θ"],
                    ["0", "1", "0", "0"],
                    ["0", "0", "1", "0"],
                    ["sin θ", "0", "0", "cos θ"]
                ]
                
                // Draw brackets with gradient
                let bracketWidth = size.width * 0.05
                let bracketPath = Path { p in
                    // Left bracket
                    p.move(to: CGPoint(x: 0, y: 0))
                    p.addLine(to: CGPoint(x: bracketWidth, y: 0))
                    p.addLine(to: CGPoint(x: bracketWidth, y: size.height))
                    p.addLine(to: CGPoint(x: 0, y: size.height))
                    
                    // Right bracket
                    p.move(to: CGPoint(x: size.width, y: 0))
                    p.addLine(to: CGPoint(x: size.width - bracketWidth, y: 0))
                    p.addLine(to: CGPoint(x: size.width - bracketWidth, y: size.height))
                    p.addLine(to: CGPoint(x: size.width, y: size.height))
                }
                let gradient = Gradient(colors: [.blue, .cyan])
                context.stroke(
                    bracketPath,
                    with: .linearGradient(
                        gradient,
                        startPoint: CGPoint(x: 0, y: 0),
                        endPoint: CGPoint(x: size.width, y: size.height)
                    ),
                    lineWidth: 2
                )
                
                // Draw matrix elements
                let cellWidth = (size.width - 2 * bracketWidth) / 4
                let cellHeight = size.height / 4
                
                for (i, row) in matrix.enumerated() {
                    for (j, element) in row.enumerated() {
                        let x = bracketWidth + CGFloat(j) * cellWidth + cellWidth/2
                        let y = CGFloat(i) * cellHeight + cellHeight/2
                        
                        context.draw(Text(element).foregroundColor(textColor).font(font),
                                   at: CGPoint(x: x, y: y))
                    }
                }
                
            case .quaternion:
                // Draw quaternion formula with proper spacing
                let formula = "q = cos(θ/2) + v·sin(θ/2)"
                context.draw(Text(formula).foregroundColor(textColor).font(font),
                           at: CGPoint(x: size.width/2, y: size.height/2))
                
            case .projection:
                // Draw stereographic projection formula with better spacing
                let parts = ["P(x,y,z,w) = (", "x", "/(1-w), ", "y", "/(1-w), ", "z", "/(1-w))"]
                var xPos: CGFloat = size.width * 0.05
                let spacing = size.width * 0.9 / CGFloat(parts.count)
                
                for part in parts {
                    let text = Text(part).foregroundColor(textColor).font(font)
                    context.draw(text, at: CGPoint(x: xPos, y: size.height/2))
                    xPos += spacing
                }
                
            case .dimensionalMapping:
                // Draw dimensional mapping arrows with gradients
                let arrowLength = size.width * 0.4
                let spacing = size.height * 0.25
                let startX = size.width * 0.1
                let gradient = Gradient(colors: [.blue, .cyan])
                
                for i in 0..<3 {
                    let y = spacing + CGFloat(i) * spacing
                    
                    // Draw arrow with gradient
                    let arrowPath = Path { p in
                        p.move(to: CGPoint(x: startX, y: y))
                        p.addLine(to: CGPoint(x: startX + arrowLength, y: y))
                        // Arrow head
                        p.move(to: CGPoint(x: startX + arrowLength - 15, y: y - 8))
                        p.addLine(to: CGPoint(x: startX + arrowLength, y: y))
                        p.addLine(to: CGPoint(x: startX + arrowLength - 15, y: y + 8))
                    }
                    context.stroke(
                        arrowPath,
                        with: .linearGradient(
                            gradient,
                            startPoint: CGPoint(x: startX, y: y),
                            endPoint: CGPoint(x: startX + arrowLength, y: y)
                        ),
                        lineWidth: 2
                    )
                    
                    // Draw text with glow effect
                    let text = ["ℝ⁴ → ℝ⁴", "ℝ⁴ → ℝ³", "ℝ³ → ℝ²"][i]
                    let position = CGPoint(x: startX + arrowLength/2, y: y - 20)
                    
                    // Draw glow
                    context.draw(Text(text).foregroundColor(.blue.opacity(0.3)).font(font),
                               at: CGPoint(x: position.x + 1, y: position.y + 1))
                    // Draw main text
                    context.draw(Text(text).foregroundColor(textColor).font(font),
                               at: position)
                }
                
            case .vertexCount:
                // Draw vertex counting formulas with better spacing
                let formulas = [
                    "V = 2⁴ = 16 vertices",
                    "E = 32 edges",
                    "F = 24 faces",
                    "C = 8 cells"
                ]
                
                let spacing = size.height / CGFloat(formulas.count + 1)
                for (i, formula) in formulas.enumerated() {
                    let y = spacing * CGFloat(i + 1)
                    
                    // Draw glow
                    context.draw(Text(formula).foregroundColor(.blue.opacity(0.3)).font(font),
                               at: CGPoint(x: size.width/2 + 1, y: y + 1))
                    // Draw main text
                    context.draw(Text(formula).foregroundColor(textColor).font(font),
                               at: CGPoint(x: size.width/2, y: y))
                }
            }
        }
        .frame(height: size)
        .background(Color.black.opacity(0.2))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(LinearGradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.3)], 
                                     startPoint: .topLeading, 
                                     endPoint: .bottomTrailing),
                        lineWidth: 1)
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        MathFormula(type: .rotationMatrix, size: 200)
        MathFormula(type: .quaternion, size: 60)
        MathFormula(type: .projection, size: 60)
        MathFormula(type: .dimensionalMapping, size: 150)
        MathFormula(type: .vertexCount, size: 150)
    }
    .padding()
    .background(Color.black)
    .preferredColorScheme(.dark)
} 