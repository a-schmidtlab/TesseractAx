import SwiftUI

struct DimensionalProgressionView: View {
    let size: CGFloat
    
    var body: some View {
        Canvas { context, size in
            // Point with glow
            context.fill(Path(ellipseIn: CGRect(x: size.width * 0.1 - 2, y: size.height * 0.4 - 2, width: 8, height: 8)), 
                        with: .color(.blue.opacity(0.3)))
            context.fill(Path(ellipseIn: CGRect(x: size.width * 0.1, y: size.height * 0.4, width: 4, height: 4)), 
                        with: .color(.cyan))
            
            // Line with gradient
            let linePath = Path { p in
                p.move(to: CGPoint(x: size.width * 0.2, y: size.height * 0.4))
                p.addLine(to: CGPoint(x: size.width * 0.35, y: size.height * 0.4))
            }
            let lineGradient = Gradient(colors: [Color.blue, Color.cyan])
            context.stroke(
                linePath,
                with: .linearGradient(
                    lineGradient,
                    startPoint: CGPoint(x: size.width * 0.2, y: size.height * 0.4),
                    endPoint: CGPoint(x: size.width * 0.35, y: size.height * 0.4)
                ),
                lineWidth: 3
            )
            
            // Square with gradient edges
            let squarePath = Path { p in
                p.move(to: CGPoint(x: size.width * 0.45, y: size.height * 0.3))
                p.addLine(to: CGPoint(x: size.width * 0.55, y: size.height * 0.3))
                p.addLine(to: CGPoint(x: size.width * 0.55, y: size.height * 0.5))
                p.addLine(to: CGPoint(x: size.width * 0.45, y: size.height * 0.5))
                p.closeSubpath()
            }
            let squareGradient = Gradient(colors: [Color.blue, Color.cyan])
            context.stroke(
                squarePath,
                with: .linearGradient(
                    squareGradient,
                    startPoint: CGPoint(x: size.width * 0.45, y: size.height * 0.3),
                    endPoint: CGPoint(x: size.width * 0.55, y: size.height * 0.3)
                ),
                lineWidth: 2.5
            )
            
            // Cube with enhanced perspective
            let cubeSize: CGFloat = size.width * 0.15
            let cubeOffset: CGFloat = size.width * 0.7
            let perspective: CGFloat = 0.4
            
            // Front face with gradient
            let frontPath = Path { p in
                p.move(to: CGPoint(x: cubeOffset, y: size.height * 0.5))
                p.addLine(to: CGPoint(x: cubeOffset + cubeSize, y: size.height * 0.5))
                p.addLine(to: CGPoint(x: cubeOffset + cubeSize, y: size.height * 0.3))
                p.addLine(to: CGPoint(x: cubeOffset, y: size.height * 0.3))
                p.closeSubpath()
            }
            let cubeGradient = Gradient(colors: [Color.blue, Color.cyan])
            context.stroke(
                frontPath,
                with: .linearGradient(
                    cubeGradient,
                    startPoint: CGPoint(x: cubeOffset, y: size.height * 0.3),
                    endPoint: CGPoint(x: cubeOffset + cubeSize, y: size.height * 0.3)
                ),
                lineWidth: 2.5
            )
            
            // Back edges with glow
            let backPath = Path { p in
                p.move(to: CGPoint(x: cubeOffset, y: size.height * 0.3))
                p.addLine(to: CGPoint(x: cubeOffset + cubeSize * perspective, y: size.height * 0.2))
                p.move(to: CGPoint(x: cubeOffset + cubeSize, y: size.height * 0.3))
                p.addLine(to: CGPoint(x: cubeOffset + cubeSize + cubeSize * perspective, y: size.height * 0.2))
                p.move(to: CGPoint(x: cubeOffset + cubeSize * perspective, y: size.height * 0.2))
                p.addLine(to: CGPoint(x: cubeOffset + cubeSize + cubeSize * perspective, y: size.height * 0.2))
            }
            
            context.stroke(backPath, with: .color(.blue.opacity(0.6)), lineWidth: 1.5)
        }
        .frame(width: size, height: size * 0.6)
        .background(Color.black.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct LatexStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Courier", size: 14))
            .padding(16)
            .background(Color(white: 0.1))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
            )
            .shadow(color: .blue.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct RotationMatrixView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("4D Rotation Matrix (XW-plane):")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("""
            ⎛ cos θ    0      0    -sin θ ⎞
            ⎜   0      1      0      0    ⎟
            ⎜   0      0      1      0    ⎟
            ⎝ sin θ    0      0    cos θ  ⎠
            """)
            .font(.custom("Courier", size: 16))
            .tracking(2)
            .foregroundColor(.cyan)
            .padding(20)
            .background(Color(white: 0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing),
                            lineWidth: 1)
            )
            .shadow(color: .blue.opacity(0.2), radius: 8, x: 0, y: 4)
        }
    }
}

struct IntroductionSection: View {
    var body: some View {
        Group {
            Text("Welcome to a New Dimension")
                .font(.system(.title, design: .rounded))
                .foregroundColor(.cyan)
            
            Text("""
            Have you ever wondered what it would be like to have an extra dimension? We live in a world with three dimensions – up/down, left/right, and forward/backward. Every movement you make, every object you see, exists within these three dimensions. But what if there was more?

            Think about this: If you draw a square on a piece of paper, that's a two-dimensional shape. Now, if you pull that square up off the paper, you create a cube – a three-dimensional shape. The cube is what you get when you extend a square into a new dimension.

            Consider, then, the profound question that follows: What happens when you extend a cube into a fourth dimension? This is precisely what we are going to explore. The shape you get is called a tesseract, and while we cannot physically see it (just as a flat paper creature could not see a full cube), we can understand it through its three-dimensional shadow – which is what you are seeing in this visualization.

            It is akin to being a detective, piecing together clues about something we cannot directly see. Just as we can understand a cube by looking at its shadows or its flat drawings, we can understand a tesseract by watching how it casts its three-dimensional shadow as it rotates through four-dimensional space.

            What makes this deeply compelling is that it challenges our everyday experience. When you see the tesseract rotating, you are witnessing something truly remarkable – a glimpse into a reality that exists mathematically but lies just beyond our physical senses. It is a window into a world where new kinds of movement are possible, where inside and outside take on new meanings, and where our usual rules about space need to be reimagined.

            As we explore deeper, we will uncover:
            • How mathematicians first discovered and understood the fourth dimension
            • What new types of movement become possible in four dimensions
            • How we can use mathematics to "see" what we cannot physically observe
            • Why understanding higher dimensions matters in modern science

            It is natural if this seems mind-bending at first. Even professional mathematicians needed time to wrap their heads around these concepts. The key is to let your imagination work alongside the mathematics, building a bridge between what we can see and what we can understand.

            Are you prepared to begin this journey into the fourth dimension?
            """)
            .font(.system(.body, design: .rounded))
        }
    }
}

struct DimensionalAnalysisSection: View {
    var body: some View {
        Group {
            Text("Dimensional Analysis")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(.cyan)
            
            Text("Consider the progression of dimensions:")
                .foregroundColor(.gray)
            
            DimensionalProgressionView(size: 300)
                .padding(.vertical)
            
            Text("""
            𝟎𝐃 Point:      {•}
            𝟏𝐃 Line:       [−−−]      2¹ vertices
            𝟐𝐃 Square:     □          2² vertices
            𝟑𝐃 Cube:       ▣          2³ vertices
            𝟒𝐃 Tesseract:  ⧈          2⁴ vertices
            """)
            .font(.custom("Courier", size: 14))
            .modifier(LatexStyle())
        }
    }
}

struct HistoricalSection: View {
    var body: some View {
        Group {
            Text("A Journey Through Time")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(.cyan)
            
            Text("""
            Let me tell you a fascinating story about how we came to understand the fourth dimension. It's a tale of mathematical courage, where brilliant minds dared to think beyond what they could see or touch.

            Back in 1844, a mathematician named Arthur Cayley was playing with patterns in numbers. He developed something called matrix algebra – think of it as a way to organize numbers in boxes that follow special rules. At the time, he probably didn't realize he was building the perfect tool for understanding rotations in higher dimensions.

            Then comes Charles Howard Hinton in 1888. Hinton was a remarkable character who believed that humans could actually train themselves to visualize the fourth dimension. He gave us the word 'tesseract' and wrote stories about what life might be like in four-dimensional space. He was so passionate about this idea that he created wooden models and color-coding systems to help people understand four-dimensional geometry.

            But here's where it gets really interesting. In the early 1900s, Alicia Boole Stott (daughter of the famous logician George Boole) made an incredible breakthrough. Without any formal mathematical training, she developed an intuitive understanding of four-dimensional geometry that surpassed many professional mathematicians. She figured out how to "slice" four-dimensional objects in a way that helped people understand them, much like how we can understand a cube by looking at its square cross-sections.

            Then Einstein came along in 1915 and changed everything. He showed us that time itself could be thought of as a fourth dimension, different from but mathematically related to our three spatial dimensions. Suddenly, the abstract mathematics of four-dimensional geometry had a profound physical meaning.

            The most beautiful part of this story is how each of these thinkers approached the challenge differently:
            • Cayley through pure mathematics
            • Hinton through visualization and imagination
            • Boole Stott through intuition and models
            • Einstein through physics and spacetime

            They all found their own paths to the same truth, showing us that there are many ways to understand complex ideas. It's like they were all climbing the same mountain from different sides, each finding their own route to the summit.
            """)
            .foregroundColor(.gray)
        }
    }
}

struct TechnicalSection: View {
    var body: some View {
        Group {
            Text("The Magic Behind the Scenes")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(.cyan)
            
            Text("""
            Now, let me show you something really cool about how we make this four-dimensional object dance on your screen. It's like being a magician, but instead of hiding the tricks, I'm going to show you exactly how we do it!

            First, we use something called quaternions. Don't let the fancy name scare you – they're actually a beautiful way to handle rotations. Imagine you're trying to tell someone how to rotate an object. You could give them a sequence of steps: "First rotate this way, then that way..." But quaternions let us describe any rotation in one elegant package:
            """)
            .foregroundColor(.gray)
            
            MathFormula(type: .quaternion, size: 60)
                .padding(.vertical)
            
            Text("""
            This formula is like a recipe for rotation. The 'cos' and 'sin' parts ensure the rotation is smooth, just like the gentle motion of a pendulum. The 'v' part tells us which way we're rotating.

            But here's where it gets really interesting. To show this four-dimensional object on your screen, we need to do something clever. We need to transform our four-dimensional coordinates into something your eyes can understand. It's like being a four-dimensional artist trying to paint on a three-dimensional canvas:
            """)
            .foregroundColor(.gray)
            
            MathFormula(type: .dimensionalMapping, size: 150)
                .padding(.vertical)
            
            Text("""
            Each arrow in this diagram represents a transformation, like a series of magical lenses that each show us a different view of our four-dimensional friend. The first lens takes our four-dimensional object and prepares it for projection. The second lens squeezes it into three dimensions, and the final lens flattens it onto your screen.

            And here's a fun fact about our tesseract: it's quite a complex fellow with lots of parts:
            """)
            .foregroundColor(.gray)
            
            MathFormula(type: .vertexCount, size: 150)
                .padding(.vertical)
            
            Text("""
            Each of these numbers tells a story. The 16 vertices are like the corners of our four-dimensional cube, connected by 32 edges. These edges form 24 faces, which in turn make up 8 cubic cells. It's like having eight regular cubes that are all connected in a way that makes perfect sense in four dimensions, even though it looks mind-bending in our three-dimensional view.

            When you watch the tesseract rotate, you're seeing all these parts move together in a carefully choreographed dance, each following the precise mathematics we've laid out. It's like conducting a geometric orchestra where every piece moves in perfect mathematical harmony!
            """)
            .foregroundColor(.gray)
        }
    }
}

struct InteractiveSection: View {
    var body: some View {
        Group {
            Text("Your Window into the Fourth Dimension")
                .font(.system(.title2, design: .rounded))
                .foregroundColor(.cyan)
            
            Text("""
            Now comes the most exciting part – actually watching our four-dimensional friend in action! As you observe the tesseract rotating, you're seeing something truly remarkable: a three-dimensional shadow of a four-dimensional dance.

            Let me help you understand what you're seeing. Imagine you're a two-dimensional being watching the shadow of a cube rotating on your flat world. As the cube rotates, its shadow would stretch, shrink, and seem to turn inside out in ways that might seem impossible in your flat world. That's exactly what's happening here, just one dimension higher!

            Here's what to look for in the visualization:

            The Inner Cube:
            This is like your anchor point – it's a three-dimensional slice of the tesseract at a particular moment. Think of it as if you're taking a three-dimensional "photograph" of a four-dimensional object. As the tesseract rotates, this inner cube changes shape because we're seeing different three-dimensional cross-sections of the four-dimensional whole.

            The Outer Structure:
            Those seemingly floating lines and faces that appear to bend impossibly? They're showing you how the tesseract extends into the fourth dimension. When they appear to intersect or pass through each other, remember: in four dimensions, they don't intersect at all! It's just like how the edges of a cube's shadow might appear to cross on a flat surface, even though in three dimensions they're nowhere near each other.

            The Connecting Lines:
            These are like your guides through the fourth dimension. They show you how each point in the inner cube connects to its corresponding point in the outer structure. As the tesseract rotates, these lines trace out the paths that connect corresponding points across the fourth dimension.

            The "Inside-Out" Motion:
            This is perhaps the most mind-bending part. When you see parts of the tesseract appear to turn inside out, you're witnessing what happens when we try to squeeze a four-dimensional rotation into three dimensions. It's like trying to show the back of a cube without lifting it off the page – something has to give!

            Remember, what makes this visualization so special is not just what it shows, but what it suggests about the nature of space itself. Every time you see the tesseract seem to do something impossible, you're catching a glimpse of the extra freedom that comes with having four spatial dimensions.

            Take your time with it. Let your mind play with the possibilities. And don't worry if it seems confusing at first – you're literally training your brain to think beyond its everyday three-dimensional experience. That's not just mathematics; that's adventure!
            """)
            .foregroundColor(.gray)
        }
    }
}

struct TesseractInfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    IntroductionSection()
                    DimensionalAnalysisSection()
                    HistoricalSection()
                    TechnicalSection()
                    InteractiveSection()
                    
                    Text("\"Mathematics, rightly viewed, possesses not only truth, but supreme beauty — a beauty cold and austere, like that of sculpture, without appeal to any part of our weaker nature, without the gorgeous trappings of painting or music, yet sublimely pure, and capable of a stern perfection such as only the greatest art can show.\" - Bertrand Russell")
                        .italic()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                    
                    Divider()
                        .background(LinearGradient(colors: [.blue.opacity(0.3), .cyan.opacity(0.3)], 
                                                 startPoint: .leading, 
                                                 endPoint: .trailing))
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("Thanks to Eleanor Forsythe and Vincent Calloway for all your help.")
                            .foregroundColor(.gray)
                        Text("So Long, and Thanks for All the Fish")
                            .italic()
                            .foregroundColor(.gray)
                        Text("- Axel Schmidt (Berlin, 2025)")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)
                }
                .padding(24)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.cyan)
                }
            }
            .background(Color.black)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    TesseractInfoView()
        .preferredColorScheme(.dark)
} 