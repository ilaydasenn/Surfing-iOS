import SwiftUI

struct ContentView: View {

    @State private var focusTask = ""
    @State private var selectedMinutes = 25
    @State private var distractionsPresent = false

    var waveName: String {
        switch selectedMinutes {
        case 5..<15:
            return "Ripple"
        case 15..<30:
            return "Small Wave"
        case 30..<45:
            return "Medium Wave"
        case 45..<60:
            return "Strong Wave"
        case 60..<90:
            return "Big Wave"
        case 90..<120:
            return "Epic Wave"
        default:
            return "Endless Surf"
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.86, green: 0.95, blue: 1.00),
                        Color(red: 0.75, green: 0.89, blue: 1.00),
                        Color(red: 0.66, green: 0.84, blue: 0.98)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {

                        // MARK: - Top Title Area

                        VStack(alignment: .leading, spacing: 10) {
                            Text("SURFING")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .tracking(3)
                                .foregroundStyle(
                                    Color(
                                        red: 0.19,
                                        green: 0.45,
                                        blue: 0.41
                                    )
                                
                                )

                            Text("Ride your\nfocus.")
                                .font(
                                    .system(
                                        size: 38,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                                .foregroundStyle(
                                    Color(
                                        red: 0.22,
                                        green: 0.20,
                                        blue: 0.20
                                    )
                                )

                            Text("Turn focused time into a calm surfing journey with waves, motion, and playful challenge.")
                                .font(.subheadline)
                                .foregroundStyle(
                                    Color(
                                        red: 0.45,
                                        green: 0.42,
                                        blue: 0.40
                                    )
                                )
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 4)
                        .padding(.top, 10)

                        // MARK: - Hero Card

                        ZStack(alignment: .bottomLeading) {

                            RoundedRectangle(cornerRadius: 34, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(
                                                red: 0.85,
                                                green: 0.89,
                                                blue: 0.90
                                            ),
                                            Color(
                                                red: 0.72,
                                                green: 0.79,
                                                blue: 0.83
                                            )
                                        ],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(height: 420)

                            OceanSceneView(
                                selectedMinutes: selectedMinutes,
                                distractionsPresent: distractionsPresent
                            )
                            .frame(height: 420)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 34,
                                    style: .continuous
                                )
                            )

                            VStack(alignment: .leading, spacing: 6) {
                                Text(waveName.uppercased())
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .tracking(2)
                                    .foregroundStyle(.white.opacity(0.9))

                                Text(formatDuration(selectedMinutes))
                                    .font(
                                        .system(
                                            size: 28,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundStyle(.white)
                            }
                            .padding(22)
                        }

                        // MARK: - Detail Panel

                        VStack(alignment: .leading, spacing: 22) {

                            // Task
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Focus Task")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(
                                        Color(
                                            red: 0.45,
                                            green: 0.42,
                                            blue: 0.40
                                        )
                                    )

                                TextField("Study Swift", text: $focusTask)
                                    .padding()
                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 18,
                                            style: .continuous
                                        )
                                        .fill(
                                            Color(
                                                red: 0.96,
                                                green: 1.00,
                                                blue: 0.98
                                            )
                                        )
                                    )
                            }

                            // Duration
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Duration")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(
                                            Color(
                                                red: 0.45,
                                                green: 0.42,
                                                blue: 0.40
                                            )
                                        )

                                    Spacer()

                                    Text(formatDuration(selectedMinutes))
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(
                                            Color(
                                                red: 0.22,
                                                green: 0.20,
                                                blue: 0.20
                                            )
                                        )
                                }

                                Slider(
                                    value: Binding(
                                        get: { Double(selectedMinutes) },
                                        set: { selectedMinutes = Int($0) }
                                    ),
                                    in: 5...240,
                                    step: 1
                                )
                                .tint(
                                    Color(
                                        red: 0.58,
                                        green: 0.41,
                                        blue: 0.33
                                    )
                                )

                                HStack {
                                    Text("5 min")
                                    Spacer()
                                    Text("4 hr")
                                }
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            }

                            // Wave + Environment
                            HStack(alignment: .top, spacing: 14) {

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Wave")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(
                                            Color(
                                                red: 0.45,
                                                green: 0.42,
                                                blue: 0.40
                                            )
                                        )

                                    Text(waveName)
                                        .font(.headline)
                                        .fontWeight(.bold)

                                    Text(waveDescription)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 22,
                                        style: .continuous
                                    )
                                    .fill(Color.white.opacity(0.65))
                                )

                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Environment")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(
                                            Color(
                                                red: 0.45,
                                                green: 0.42,
                                                blue: 0.40
                                            )
                                        )

                                    Picker("Environment", selection: $distractionsPresent) {
                                        Text("Calm").tag(false)
                                        Text("Sharks").tag(true)
                                    }
                                    .pickerStyle(.segmented)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 22,
                                        style: .continuous
                                    )
                                    .fill(Color.white.opacity(0.65))
                                )
                            }

                            // CTA
                            NavigationLink {
                                FocusSessionView(
                                    task: focusTask,
                                    selectedMinutes: selectedMinutes,
                                    distractionsPresent: distractionsPresent
                                )
                            } label: {
                                HStack {
                                    Spacer()

                                    Text("Start Riding")
                                        .fontWeight(.bold)

                                    Image(systemName: "arrow.right")

                                    Spacer()
                                }
                                .padding()
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 22,
                                        style: .continuous
                                    )
                                    .fill(
                                        Color(
                                            red: 0.28,
                                            green: 0.22,
                                            blue: 0.21
                                        )
                                    )
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(22)
                        .padding(22)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 30,
                                style: .continuous
                            )
                            .fill(
                                Color(
                                    red: 0.84,
                                    green: 0.93,
                                    blue: 0.89
                                )
                            )
                        )
                    }
                    .padding(20)
                }
            }
        }
    }

    var waveDescription: String {
        switch selectedMinutes {
        case 5..<15:
            return "A calm beginner ride."
        case 15..<30:
            return "Gentle and clearly surfable."
        case 30..<45:
            return "More shape, more momentum."
        case 45..<60:
            return "More energy and stronger motion."
        case 60..<90:
            return "A powerful and satisfying ride."
        case 90..<120:
            return "Dramatic and exciting."
        default:
            return "A long surfing journey across multiple waves."
        }
    }

    func formatDuration(_ minutes: Int) -> String {
        if minutes < 60 {
            return "\(minutes) min"
        }

        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        if remainingMinutes == 0 {
            return hours == 1 ? "1 hr" : "\(hours) hr"
        }

        return "\(hours) hr \(remainingMinutes) min"
    }
}

#Preview {
    ContentView()
}
