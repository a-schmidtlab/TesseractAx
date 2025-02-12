# The Tesseract - A Window into the Fourth Dimension

An exploration of four-dimensional geometry through interactive visualization, inspired by the works of mathematicians who dared to think beyond our three-dimensional intuition.

## Mathematical Foundation

The tesseract represents the four-dimensional analog of a cube, existing in a space that transcends our everyday experience. This implementation explores its geometry through:

### Rotational Dynamics
- Multiple simultaneous rotations in 4D planes (XY, XZ, XW, YZ, YW, ZW)
- Quaternion-based smooth transitions
- Stereographic projection preserving geometric relationships

### Visualization Pipeline
1. R⁴ → R³: Stereographic projection with depth preservation
2. R³ → R²: Perspective projection with opacity gradients
3. Real-time interactive rotation in all six 4D planes

### Geometric Properties
- 16 vertices connected by 32 edges
- 24 square faces forming 8 cubic cells
- Full preservation of hypercube symmetries
- Continuous tracking of 4D depth for visualization

## Historical Context

This visualization stands on the shoulders of giants:
- Charles Howard Hinton (1888) - First description of the tesseract
- Alicia Boole Stott - Revolutionary work on 4D polytope visualization
- Ludwig Schläfli - Classification of regular polytopes
- Hermann Minkowski - Four-dimensional spacetime formulation


## Interactive Features

### Visualization Modes
- **Wireframe Mode**: Classic visualization showing the edges and vertices of the tesseract
- **Solid Mode**: Advanced rendering with faces and depth-based transparency
- **Cross-Section View**: Real-time slicing through the fourth dimension

### Projection Controls
- **Perspective Projection**: Traditional 3D-like view with depth perception
- **Orthographic Projection**: Mathematical view preserving parallel lines

### Advanced Rotation System
- **Manual 4D Controls**: Individual control over all four-dimensional rotation planes
  - XW Rotation: Movement through the fourth dimension
  - YZ Rotation: Vertical rotation
  - XY Rotation: Horizontal rotation
  - ZW Rotation: Depth rotation
- **Auto-Rotation**: Smooth automated rotation with adjustable speed
- **Axis Locking**: Ability to lock individual rotation planes

### User Interface
- **Full-Screen Visualization**: Immersive view of the tesseract
- **Intuitive Controls**: Easy-to-use sliders and toggles for all parameters
- **Real-Time Updates**: Instant visual feedback for all adjustments
- **Info Panel**: Detailed mathematical and historical context

### Technical Highlights
- **Depth-Based Rendering**: Objects closer to the viewer appear more opaque
- **Gradient Coloring**: Visual cues for depth and orientation
- **Optimized Performance**: Smooth animations even during complex rotations
- **Portrait Mode Optimization**: Designed for one-handed mobile use


## Technical Implementation

Built with:
- SwiftUI for declarative UI and animations
- Custom Canvas-based rendering engine
- Quaternion-based rotation system
- Real-time depth-based opacity calculations

## Requirements
- iOS 18.2+
- ARM64 architecture
- Xcode 15+

## Installation
```bash
git clone https://github.com/yourusername/SofaRotator.git
cd SofaRotator
# Open in Xcode and run
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

"Mathematics requires a small dose, not of genius, but of an imaginative freedom which, in a larger dose, would be insanity." - Angus K. Rodgers

---

Copyright © 2025 Axel Schmidt. All rights reserved.
