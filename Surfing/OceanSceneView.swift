import SwiftUI

struct OceanSceneView: View {

    let selectedMinutes: Int
    let distractionsPresent: Bool

    // Three wave layers move independently.
    @State private var backPhase: CGFloat = 0
    @State private var middlePhase: CGFloat = .pi / 2
    @State private var frontPhase: CGFloat = .pi

    // Controls the surfer's up/down motion.
    @State private var surferMoves = false


    // MARK: - Surf Stage

    private var surfStage: SurfStage {

        switch selectedMinutes {

        case 5..<30:
            return .floating

        case 30..<45:
            return .ready

        case 45..<90:
            return .surfing

        default:
            return .wild
        }
    }


    // MARK: - Wave Size

    private var waveAmplitude: CGFloat {

        switch selectedMinutes {

        case 5..<15:
            return 16

        case 15..<30:
            return 22

        case 30..<45:
            return 29

        case 45..<60:
            return 37

        case 60..<90:
            return 45

        case 90..<120:
            return 52

        default:
            // 120+ reaches the maximum.
            // We do not keep creating giant waves.
            return 58
        }
    }


    // 2 hours and above = happiest dog.
    private var isExtraHappy: Bool {
        selectedMinutes >= 120
    }


    // MARK: - Surfer Movement

    private var surferRotation: Double {

        switch surfStage {

        case .floating:
            return surferMoves ? -2 : 2

        case .ready:
            return surferMoves ? -5 : 5

        case .surfing:
            return surferMoves ? -11 : 8

        case .wild:
            return surferMoves ? -17 : 12
        }
    }


    private var surferVerticalMovement: CGFloat {

        switch surfStage {

        case .floating:
            return 4

        case .ready:
            return 7

        case .surfing:
            return 11

        case .wild:
            return 15
        }
    }


    var body: some View {

        GeometryReader { geometry in

            ZStack {

                // MARK: - Peaceful Blue Sky

                LinearGradient(
                    colors: distractionsPresent
                    ? [
                        Color(
                            red: 0.56,
                            green: 0.72,
                            blue: 0.86
                        ),

                        Color(
                            red: 0.68,
                            green: 0.81,
                            blue: 0.91
                        )
                    ]
                    : [
                        Color(
                            red: 0.75,
                            green: 0.90,
                            blue: 1.00
                        ),

                        Color(
                            red: 0.65,
                            green: 0.84,
                            blue: 0.99
                        ),

                        Color(
                            red: 0.56,
                            green: 0.78,
                            blue: 0.97
                        )
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )


                // MARK: - Sun Glow

                Circle()
                    .fill(
                        Color.white.opacity(0.48)
                    )
                    .frame(
                        width: 72,
                        height: 72
                    )
                    .blur(radius: 7)
                    .position(
                        x: geometry.size.width * 0.82,
                        y: geometry.size.height * 0.18
                    )


                // MARK: - BACK WAVE

                SurfWaveBandShape(
                    amplitude: waveAmplitude * 0.45,
                    frequency: 1.30,
                    phase: backPhase
                )
                .fill(
                    LinearGradient(
                        colors: [
                            Color(
                                red: 0.36,
                                green: 0.65,
                                blue: 0.95
                            ),

                            Color(
                                red: 0.16,
                                green: 0.45,
                                blue: 0.84
                            )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .offset(
                    y: geometry.size.height * 0.47
                )


                // Soft highlight on back wave
                SurfWaveCrestShape(
                    amplitude: waveAmplitude * 0.45,
                    frequency: 1.30,
                    phase: backPhase
                )
                .stroke(
                    Color.white.opacity(0.18),
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .blur(radius: 0.6)
                .offset(
                    y: geometry.size.height * 0.47
                )


                // MARK: - MIDDLE WAVE

                SurfWaveBandShape(
                    amplitude: waveAmplitude * 0.72,
                    frequency: 1.22,
                    phase: middlePhase
                )
                .fill(
                    LinearGradient(
                        colors: [
                            Color(
                                red: 0.40,
                                green: 0.70,
                                blue: 0.99
                            ),

                            Color(
                                red: 0.17,
                                green: 0.48,
                                blue: 0.88
                            )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .offset(
                    y: geometry.size.height * 0.61
                )


                SurfWaveCrestShape(
                    amplitude: waveAmplitude * 0.72,
                    frequency: 1.22,
                    phase: middlePhase
                )
                .stroke(
                    Color.white.opacity(0.27),
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                )
                .blur(radius: 0.5)
                .offset(
                    y: geometry.size.height * 0.61
                )


                // MARK: - FRONT WAVE

                SurfWaveBandShape(
                    amplitude: waveAmplitude,
                    frequency: 1.42,
                    phase: frontPhase
                )
                .fill(
                    LinearGradient(
                        colors: [
                            Color(
                                red: 0.22,
                                green: 0.60,
                                blue: 0.98
                            ),

                            Color(
                                red: 0.06,
                                green: 0.35,
                                blue: 0.80
                            )
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .offset(
                    y: geometry.size.height * 0.75
                )


                // MARK: - White Foam

                SurfWaveCrestShape(
                    amplitude: waveAmplitude,
                    frequency: 1.42,
                    phase: frontPhase
                )
                .stroke(
                    Color.white.opacity(0.92),
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .blur(radius: 0.7)
                .offset(
                    y: geometry.size.height * 0.75
                )


                SurfWaveCrestShape(
                    amplitude: waveAmplitude * 0.92,
                    frequency: 1.42,
                    phase: frontPhase + 0.10
                )
                .stroke(
                    Color.white.opacity(0.35),
                    style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .round
                    )
                )
                .offset(
                    y: geometry.size.height * 0.77
                )


                // Small white foam dots.
                SurfFoamDustView()
                    .opacity(
                        selectedMinutes >= 30
                        ? 0.75
                        : 0.42
                    )
                    .position(
                        x: geometry.size.width * 0.50,
                        y: geometry.size.height * 0.78
                    )


                // MARK: - Sharks

                if distractionsPresent {

                    SurfSharkFinShape()
                        .fill(
                            Color(
                                red: 0.12,
                                green: 0.20,
                                blue: 0.28
                            )
                            .opacity(0.65)
                        )
                        .frame(
                            width: 32,
                            height: 25
                        )
                        .position(
                            x: geometry.size.width * 0.20,
                            y: geometry.size.height * 0.84
                        )


                    SurfSharkFinShape()
                        .fill(
                            Color(
                                red: 0.12,
                                green: 0.20,
                                blue: 0.28
                            )
                            .opacity(0.52)
                        )
                        .frame(
                            width: 23,
                            height: 18
                        )
                        .position(
                            x: geometry.size.width * 0.79,
                            y: geometry.size.height * 0.87
                        )
                }


                // MARK: - Poodle + Surfboard

                SurfPoodleView(
                    stage: surfStage,
                    isExtraHappy: isExtraHappy
                )
                .frame(
                    width: 150,
                    height: 145
                )
                .rotationEffect(
                    .degrees(surferRotation)
                )
                .position(
                    x: geometry.size.width * 0.54,

                    y:
                        geometry.size.height * 0.57
                        +
                        (
                            surferMoves
                            ? -surferVerticalMovement
                            : surferVerticalMovement
                        )
                )
                .animation(
                    .easeInOut(duration: 1.05)
                    .repeatForever(
                        autoreverses: true
                    ),
                    value: surferMoves
                )


                // MARK: - Surf Spray

                if surfStage == .surfing ||
                    surfStage == .wild {

                    SurfWaterSprayView(
                        strength:
                            surfStage == .wild
                            ? 1.0
                            : 0.62
                    )
                    .position(
                        x: geometry.size.width * 0.67,
                        y: geometry.size.height * 0.59
                    )
                }


                // Distraction mode becomes slightly darker.
                if distractionsPresent {

                    Color.black
                        .opacity(0.055)
                }
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 34,
                    style: .continuous
                )
            )
        }

        .onAppear {

            // Back wave = slowest
            withAnimation(
                .linear(duration: 11)
                .repeatForever(
                    autoreverses: false
                )
            ) {
                backPhase += .pi * 2
            }


            // Middle wave
            withAnimation(
                .linear(duration: 8)
                .repeatForever(
                    autoreverses: false
                )
            ) {
                middlePhase += .pi * 2
            }


            // Front wave = fastest
            withAnimation(
                .linear(duration: 5)
                .repeatForever(
                    autoreverses: false
                )
            ) {
                frontPhase += .pi * 2
            }


            surferMoves = true
        }
    }
}



// MARK: - Surf Stage

private enum SurfStage {

    // 5–29 minutes
    case floating

    // 30–44 minutes
    case ready

    // 45–89 minutes
    case surfing

    // 90+ minutes
    case wild
}



// MARK: - Wave Fill Shape

private struct SurfWaveBandShape: Shape {

    var amplitude: CGFloat
    var frequency: CGFloat
    var phase: CGFloat


    var animatableData: CGFloat {

        get {
            phase
        }

        set {
            phase = newValue
        }
    }


    func path(
        in rect: CGRect
    ) -> Path {

        var path = Path()

        let baseline =
            rect.height * 0.16


        path.move(
            to: CGPoint(
                x: 0,
                y: baseline
            )
        )


        for x in stride(
            from: CGFloat.zero,
            through: rect.width,
            by: 1
        ) {

            let progress =
                x / rect.width


            let mainWave =
                sin(
                    progress
                    * .pi
                    * 2
                    * frequency
                    + phase
                )
                * amplitude


            // Small second sine wave makes the water
            // slightly more organic.
            let secondaryWave =
                sin(
                    progress
                    * .pi
                    * 4
                    + phase * 0.75
                )
                * amplitude
                * 0.08


            let y =
                baseline
                + mainWave
                + secondaryWave


            path.addLine(
                to: CGPoint(
                    x: x,
                    y: y
                )
            )
        }


        path.addLine(
            to: CGPoint(
                x: rect.width,
                y: rect.height
            )
        )


        path.addLine(
            to: CGPoint(
                x: 0,
                y: rect.height
            )
        )


        path.closeSubpath()

        return path
    }
}



// MARK: - Foam / Crest Shape

private struct SurfWaveCrestShape: Shape {

    var amplitude: CGFloat
    var frequency: CGFloat
    var phase: CGFloat


    var animatableData: CGFloat {

        get {
            phase
        }

        set {
            phase = newValue
        }
    }


    func path(
        in rect: CGRect
    ) -> Path {

        var path = Path()

        let baseline =
            rect.height * 0.16


        for x in stride(
            from: CGFloat.zero,
            through: rect.width,
            by: 1
        ) {

            let progress =
                x / rect.width


            let mainWave =
                sin(
                    progress
                    * .pi
                    * 2
                    * frequency
                    + phase
                )
                * amplitude


            let secondaryWave =
                sin(
                    progress
                    * .pi
                    * 4
                    + phase * 0.75
                )
                * amplitude
                * 0.08


            let y =
                baseline
                + mainWave
                + secondaryWave


            if x == 0 {

                path.move(
                    to: CGPoint(
                        x: x,
                        y: y
                    )
                )

            } else {

                path.addLine(
                    to: CGPoint(
                        x: x,
                        y: y
                    )
                )
            }
        }


        return path
    }
}



// MARK: - Foam Dots

private struct SurfFoamDustView: View {

    var body: some View {

        ZStack {

            ForEach(
                0..<34,
                id: \.self
            ) { index in

                Circle()
                    .fill(
                        Color.white.opacity(
                            0.25
                            +
                            Double(index % 5)
                            * 0.10
                        )
                    )
                    .frame(
                        width:
                            CGFloat(
                                2 + index % 4
                            ),

                        height:
                            CGFloat(
                                2 + index % 4
                            )
                    )
                    .offset(
                        x:
                            CGFloat(
                                (index * 23) % 300
                            )
                            - 150,

                        y:
                            CGFloat(
                                (index * 13) % 34
                            )
                            - 17
                    )
            }
        }
        .frame(
            width: 310,
            height: 50
        )
    }
}



// MARK: - Poodle + Board

private struct SurfPoodleView: View {

    let stage: SurfStage
    let isExtraHappy: Bool


    var body: some View {

        ZStack {

            // MARK: Surfboard

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(
                                red: 1.00,
                                green: 0.48,
                                blue: 0.08
                            ),

                            Color(
                                red: 1.00,
                                green: 0.70,
                                blue: 0.18
                            )
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(
                    width: 118,
                    height: 17
                )
                .rotationEffect(
                    .degrees(-8)
                )
                .offset(y: 41)


            // Lighter stripe on the board.
            Capsule()
                .fill(
                    Color(
                        red: 1.00,
                        green: 0.84,
                        blue: 0.42
                    )
                    .opacity(0.82)
                )
                .frame(
                    width: 72,
                    height: 7
                )
                .rotationEffect(
                    .degrees(-8)
                )
                .offset(y: 41)


            // Dog pose changes depending on session length.
            switch stage {

            case .floating:

                SurfFloatingPoodle(
                    happy: isExtraHappy
                )


            case .ready:

                SurfReadyPoodle(
                    happy: isExtraHappy
                )


            case .surfing:

                SurfStandingPoodle(
                    lean: -7,
                    happy: isExtraHappy
                )


            case .wild:

                SurfStandingPoodle(
                    lean: -15,
                    happy: isExtraHappy
                )
            }
        }
    }
}



// MARK: - Floating Poodle
// All four legs exist.
// The dog is lying low on the board.

private struct SurfFloatingPoodle: View {

    let happy: Bool


    var body: some View {

        ZStack {

            // Tail
            Circle()
                .fill(SurfDogColors.fur)
                .frame(
                    width: 15,
                    height: 15
                )
                .offset(
                    x: -34,
                    y: 3
                )


            // Body
            Ellipse()
                .fill(SurfDogColors.fur)
                .frame(
                    width: 56,
                    height: 29
                )
                .offset(
                    x: -3,
                    y: 7
                )


            // Back leg 1
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 8,
                    height: 19
                )
                .rotationEffect(
                    .degrees(15)
                )
                .offset(
                    x: -18,
                    y: 19
                )


            // Back leg 2
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 8,
                    height: 19
                )
                .rotationEffect(
                    .degrees(-6)
                )
                .offset(
                    x: -3,
                    y: 19
                )


            // Head
            Circle()
                .fill(SurfDogColors.head)
                .frame(
                    width: 35,
                    height: 35
                )
                .offset(
                    x: 25,
                    y: -4
                )


            // Puffy top hair
            Circle()
                .fill(SurfDogColors.head)
                .frame(
                    width: 22,
                    height: 17
                )
                .offset(
                    x: 25,
                    y: -19
                )


            // Left ear
            Ellipse()
                .fill(SurfDogColors.ear)
                .frame(
                    width: 12,
                    height: 21
                )
                .rotationEffect(
                    .degrees(12)
                )
                .offset(
                    x: 13,
                    y: -3
                )


            // Right ear
            Ellipse()
                .fill(SurfDogColors.ear)
                .frame(
                    width: 12,
                    height: 21
                )
                .rotationEffect(
                    .degrees(-12)
                )
                .offset(
                    x: 37,
                    y: -3
                )


            // Front leg 1
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 8,
                    height: 19
                )
                .rotationEffect(
                    .degrees(12)
                )
                .offset(
                    x: 16,
                    y: 18
                )


            // Front leg 2
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 8,
                    height: 19
                )
                .rotationEffect(
                    .degrees(-9)
                )
                .offset(
                    x: 30,
                    y: 18
                )


            SurfPoodleFace(
                extraHappy: happy
            )
            .offset(
                x: 25,
                y: -4
            )
        }
    }
}



// MARK: - Ready Poodle
// Crouching before standing up.

private struct SurfReadyPoodle: View {

    let happy: Bool


    var body: some View {

        ZStack {

            // Tail
            Circle()
                .fill(SurfDogColors.fur)
                .frame(
                    width: 14,
                    height: 14
                )
                .offset(
                    x: -27,
                    y: -1
                )


            // Body
            Ellipse()
                .fill(SurfDogColors.fur)
                .frame(
                    width: 44,
                    height: 36
                )
                .offset(y: 1)


            // Head
            Circle()
                .fill(SurfDogColors.head)
                .frame(
                    width: 35,
                    height: 35
                )
                .offset(
                    x: 8,
                    y: -29
                )


            // Puffy hair
            Circle()
                .fill(SurfDogColors.head)
                .frame(
                    width: 22,
                    height: 17
                )
                .offset(
                    x: 8,
                    y: -44
                )


            // Ears
            Ellipse()
                .fill(SurfDogColors.ear)
                .frame(
                    width: 11,
                    height: 21
                )
                .offset(
                    x: -4,
                    y: -28
                )


            Ellipse()
                .fill(SurfDogColors.ear)
                .frame(
                    width: 11,
                    height: 21
                )
                .offset(
                    x: 20,
                    y: -28
                )


            // Rear left leg
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 9,
                    height: 26
                )
                .rotationEffect(
                    .degrees(31)
                )
                .offset(
                    x: -16,
                    y: 25
                )


            // Rear right leg
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 9,
                    height: 26
                )
                .rotationEffect(
                    .degrees(-16)
                )
                .offset(
                    x: 7,
                    y: 24
                )


            // Front left leg
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 8,
                    height: 24
                )
                .rotationEffect(
                    .degrees(18)
                )
                .offset(
                    x: -2,
                    y: 21
                )


            // Front right leg
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 8,
                    height: 24
                )
                .rotationEffect(
                    .degrees(-13)
                )
                .offset(
                    x: 18,
                    y: 21
                )


            SurfPoodleFace(
                extraHappy: happy
            )
            .offset(
                x: 8,
                y: -29
            )
        }
    }
}



// MARK: - Standing Poodle
// Proper surfing stance with four limbs.

private struct SurfStandingPoodle: View {

    let lean: Double
    let happy: Bool


    var body: some View {

        ZStack {

            // Tail
            Circle()
                .fill(SurfDogColors.fur)
                .frame(
                    width: 14,
                    height: 14
                )
                .offset(
                    x: -26,
                    y: -3
                )


            // Body
            Ellipse()
                .fill(SurfDogColors.fur)
                .frame(
                    width: 40,
                    height: 47
                )


            // Head
            Circle()
                .fill(SurfDogColors.head)
                .frame(
                    width: 35,
                    height: 35
                )
                .offset(
                    x: 4,
                    y: -35
                )


            // Puffy hair
            Circle()
                .fill(SurfDogColors.head)
                .frame(
                    width: 22,
                    height: 17
                )
                .offset(
                    x: 4,
                    y: -50
                )


            // Ears
            Ellipse()
                .fill(SurfDogColors.ear)
                .frame(
                    width: 11,
                    height: 22
                )
                .rotationEffect(
                    .degrees(8)
                )
                .offset(
                    x: -8,
                    y: -34
                )


            Ellipse()
                .fill(SurfDogColors.ear)
                .frame(
                    width: 11,
                    height: 22
                )
                .rotationEffect(
                    .degrees(-8)
                )
                .offset(
                    x: 16,
                    y: -34
                )


            // Back leg
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 9,
                    height: 37
                )
                .rotationEffect(
                    .degrees(27)
                )
                .offset(
                    x: -16,
                    y: 31
                )


            // Front leg
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 9,
                    height: 37
                )
                .rotationEffect(
                    .degrees(-25)
                )
                .offset(
                    x: 16,
                    y: 30
                )


            // Left arm
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 34,
                    height: 7
                )
                .rotationEffect(
                    .degrees(-20)
                )
                .offset(
                    x: -19,
                    y: -3
                )


            // Right arm
            Capsule()
                .fill(SurfDogColors.leg)
                .frame(
                    width: 34,
                    height: 7
                )
                .rotationEffect(
                    .degrees(18)
                )
                .offset(
                    x: 20,
                    y: -6
                )


            SurfPoodleFace(
                extraHappy: happy
            )
            .offset(
                x: 4,
                y: -35
            )
        }
        .rotationEffect(
            .degrees(lean)
        )
    }
}



// MARK: - Poodle Face

private struct SurfPoodleFace: View {

    let extraHappy: Bool


    var body: some View {

        ZStack {

            // Eyes
            Circle()
                .fill(Color.black.opacity(0.88))
                .frame(
                    width: 4,
                    height: 4
                )
                .offset(
                    x: -5,
                    y: -4
                )


            Circle()
                .fill(Color.black.opacity(0.88))
                .frame(
                    width: 4,
                    height: 4
                )
                .offset(
                    x: 5,
                    y: -4
                )


            // Nose
            Circle()
                .fill(Color.black.opacity(0.90))
                .frame(
                    width: 5,
                    height: 4
                )
                .offset(y: 3)


            // Smile
            SurfSmileShape()
                .stroke(
                    Color.black.opacity(0.88),
                    style: StrokeStyle(
                        lineWidth: 1.8,
                        lineCap: .round
                    )
                )
                .frame(
                    width:
                        extraHappy
                        ? 15
                        : 10,

                    height:
                        extraHappy
                        ? 9
                        : 6
                )
                .offset(
                    y:
                        extraHappy
                        ? 10
                        : 9
                )


            // Extra happiness at 120+ minutes:
            // little rosy cheeks.
            if extraHappy {

                Circle()
                    .fill(
                        Color.pink.opacity(0.32)
                    )
                    .frame(
                        width: 6,
                        height: 6
                    )
                    .offset(
                        x: -11,
                        y: 3
                    )


                Circle()
                    .fill(
                        Color.pink.opacity(0.32)
                    )
                    .frame(
                        width: 6,
                        height: 6
                    )
                    .offset(
                        x: 11,
                        y: 3
                    )
            }
        }
    }
}



// MARK: - Smile

private struct SurfSmileShape: Shape {

    func path(
        in rect: CGRect
    ) -> Path {

        var path = Path()

        path.move(
            to: CGPoint(
                x: rect.minX,
                y: rect.midY - 1
            )
        )


        path.addQuadCurve(
            to: CGPoint(
                x: rect.maxX,
                y: rect.midY - 1
            ),

            control: CGPoint(
                x: rect.midX,
                y: rect.maxY
            )
        )


        return path
    }
}



// MARK: - Dog Colors

private enum SurfDogColors {

    static let fur =
        Color(
            red: 0.97,
            green: 0.93,
            blue: 0.88
        )


    static let head =
        Color(
            red: 0.99,
            green: 0.96,
            blue: 0.92
        )


    static let ear =
        Color(
            red: 0.74,
            green: 0.60,
            blue: 0.48
        )


    static let leg =
        Color(
            red: 0.89,
            green: 0.82,
            blue: 0.74
        )
}



// MARK: - Surf Spray

private struct SurfWaterSprayView: View {

    let strength: Double


    var body: some View {

        ZStack {

            ForEach(
                0..<15,
                id: \.self
            ) { index in

                Circle()
                    .fill(
                        Color.white.opacity(
                            strength
                            *
                            (
                                0.32
                                +
                                Double(index % 4)
                                * 0.13
                            )
                        )
                    )
                    .frame(
                        width:
                            CGFloat(
                                3 + index % 4
                            ),

                        height:
                            CGFloat(
                                3 + index % 4
                            )
                    )
                    .offset(
                        x:
                            CGFloat(
                                -index * 4
                            ),

                        y:
                            CGFloat(
                                (index % 5) * 7
                            )
                            - 24
                    )
            }
        }
    }
}



// MARK: - Shark Fin

private struct SurfSharkFinShape: Shape {

    func path(
        in rect: CGRect
    ) -> Path {

        var path = Path()


        path.move(
            to: CGPoint(
                x: 0,
                y: rect.height
            )
        )


        path.addCurve(
            to: CGPoint(
                x: rect.width,
                y: rect.height
            ),

            control1: CGPoint(
                x: rect.width * 0.34,
                y: rect.height * 0.12
            ),

            control2: CGPoint(
                x: rect.width * 0.55,
                y: 0
            )
        )


        path.closeSubpath()

        return path
    }
}



// MARK: - Preview

#Preview {

    VStack(spacing: 16) {

        // Calm
        OceanSceneView(
            selectedMinutes: 20,
            distractionsPresent: false
        )
        .frame(height: 260)


        // Surfing
        OceanSceneView(
            selectedMinutes: 60,
            distractionsPresent: false
        )
        .frame(height: 260)


        // Maximum wave + happiest dog
        OceanSceneView(
            selectedMinutes: 120,
            distractionsPresent: false
        )
        .frame(height: 260)
    }
    .padding()
}
