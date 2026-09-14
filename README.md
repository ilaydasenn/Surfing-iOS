# Surfing 🌊

### Ride your focus.

Surfing is a beginner-friendly iOS focus timer prototype that turns focused time into a visual surfing journey.

Instead of representing focus only with a countdown, the app uses animated waves and a surfing poodle to make focus sessions feel more playful, calm, and rewarding.

## Concept

The size and intensity of the ocean change depending on the selected focus duration.

- 5–14 min → Ripple
- 15–29 min → Small Wave
- 30–44 min → Medium Wave
- 45–59 min → Strong Wave
- 60–89 min → Big Wave
- 90–119 min → Epic Wave
- 120+ min → Endless Surf

As the session becomes more challenging, the poodle's surfing behavior also changes.

Short sessions are calm, while longer sessions create stronger waves and more energetic surfing.

## Distraction Metaphor

The app includes two focus environments:

- Calm Sea
- Sharks

Sharks represent distractions and interruptions.

Because iOS does not freely allow apps to monitor notifications from other apps, this feature is currently implemented as a manual prototype toggle.

## Built With

- Swift
- SwiftUI
- NavigationStack
- @State
- Timer
- Custom SwiftUI Shapes
- SwiftUI Animations

No backend, database, third-party packages, or external animation frameworks are used.

## Why I Built It

I created Surfing as part of my ongoing Swift and SwiftUI learning journey, with a focus on turning a simple productivity idea into an interactive iOS prototype.

## My Role

This is a self-initiated individual concept.

I developed the product idea, focus and wave system, distraction metaphor, user experience, visual direction, and interaction decisions.

I built and tested the prototype in Xcode while learning how SwiftUI views, state, navigation, timers, shapes, and animations work together.

## AI-Assisted Development

As a beginner in Swift, I used AI as a coding and learning assistant during development.

I used it to help translate my product and design ideas into SwiftUI, understand errors, explore implementation approaches, and iterate on the prototype.

The concept, feature decisions, visual direction, testing, and design iterations were driven by me as part of my learning process.

## What I Learned

Through this project I began learning:

- How a SwiftUI app is structured
- How @State updates an interface
- How NavigationStack connects screens
- How custom Shape objects can create animated waves
- How interaction design can communicate progress visually
- How to transition from my usual VS Code workflow to Xcode and build my first iOS project from scratch


## Status

Surfing is currently a portfolio prototype and learning project.

Future iterations could include:

- Completed-session rewards
- A dedicated completion screen
- Progress-based ocean environments
- More advanced surfing animation
- Session history and statistics
- Deeper integration with Apple focus-related technologies
- A playful failed-session sequence where the ocean becomes rougher and sharks “get” the surfer if the session is abandoned before completion
