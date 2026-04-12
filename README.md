# Jesus Bonanza Slot

A fully functional **5-reel slot machine game** built entirely with **Flutter** (no backend, no third-party game engines).

This project demonstrates clean state management, smooth animations, custom UI effects, and engaging game mechanics—all implemented from scratch in pure Flutter and Dart.

**Live Demo** (built with GitHub Pages CI/CD):  
[Play the game → https://seltee.github.io/jesus_bonanza/](https://seltee.github.io/jesus_bonanza/)

## Features

- **5-reel slot mechanic** with multiple winning paylines, including straight lines and zig-zag patterns
- **Dynamic win highlighting** — winning combinations are revealed one by one with visual feedback and a total win amount display
- **Multifunctional Play/Stop button** — tap to start spinning; tap again to stop reels instantly (button is intelligently disabled during win presentation to prevent overlap)
- **Custom reel presentation** — no traditional slot machine frame; instead, a beautiful shader-based mask creates smooth transparency fade-offs at the reel edges, with symbols elegantly flying in from above
- **Polished animations** and visual effects for spins, stops, and wins
- **Responsive and performant** — optimized for web (and easily adaptable to mobile)

The game delivers a satisfying, arcade-style experience with responsive controls and clear visual feedback.

## Technical Highlights

- **100% Flutter & Dart** — no external game frameworks or backends
- Shader effect for reel masking and transparency
- Efficient animation handling for reel spinning and stopping
- State management for game flow (spinning → stopping → win evaluation → presentation)
- Clean separation of UI, logic, and visual effects
- Payline system supporting both standard and non-linear winning combinations
- Immediate reel-stop responsiveness combined with controlled win reveal sequence

This project showcases my ability to create engaging, interactive experiences using Flutter's animation and rendering capabilities.

## What I Learned / Showcased

- Building complex interactive UI with custom painting and shaders
- Managing multi-phase game states (spin, stop, evaluate, highlight wins)
- Creating delightful user feedback loops in a real-time game
- Optimizing performance for smooth 60fps animations on web
- Designing intuitive controls (multifunctional buttons with proper disable states)

Perfect for demonstrating Flutter proficiency in animations, custom widgets, state handling, and game-like interactions.

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Launch with `flutter run -d chrome` (or any supported device)

The project is structured for easy exploration. Core game logic is in the `lib/` directory.

## License

MIT License – feel free to explore and learn from the code.

---

**Built as a portfolio project to showcase Flutter skills in game development, custom animations, and polished UI/UX.**