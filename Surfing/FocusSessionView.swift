import SwiftUI
import Combine

struct FocusSessionView: View {

    let task: String
    let selectedMinutes: Int
    let distractionsPresent: Bool

    @State private var remainingSeconds: Int
    @State private var isRunning = true

    // Her saniye tetiklenen basit timer
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()

    init(
        task: String,
        selectedMinutes: Int,
        distractionsPresent: Bool
    ) {
        self.task = task
        self.selectedMinutes = selectedMinutes
        self.distractionsPresent = distractionsPresent

        _remainingSeconds = State(
            initialValue: selectedMinutes * 60
        )
    }

    // Tamamlanan süre
    var completedSeconds: Int {
        selectedMinutes * 60 - remainingSeconds
    }

    // 0 ile 1 arasında ilerleme değeri
    var progress: Double {
        let totalSeconds = selectedMinutes * 60

        return Double(completedSeconds) / Double(totalSeconds)
    }

    var body: some View {

        ZStack {

            LinearGradient(
                colors: distractionsPresent
                ? [
                    Color.gray.opacity(0.65),
                    Color.blue.opacity(0.45)
                ]
                : [
                    Color.cyan.opacity(0.35),
                    Color.blue.opacity(0.15),
                    Color.white
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 28) {

                Spacer()

                Text(
                    task.isEmpty
                    ? "Focus Session"
                    : task
                )
                .font(.title2)
                .fontWeight(.bold)

                OceanSceneView(
                    selectedMinutes: selectedMinutes,
                    distractionsPresent: distractionsPresent
                )
                .frame(height: 280)

                Text(timeText)
                    .font(
                        .system(
                            size: 54,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    .monospacedDigit()

                ProgressView(value: progress)
                    .tint(.blue)

                Text("\(Int(progress * 100))% focused")
                    .foregroundStyle(.secondary)

                Button {

                    isRunning.toggle()

                } label: {

                    HStack {

                        Image(
                            systemName: isRunning
                            ? "pause.fill"
                            : "play.fill"
                        )

                        Text(
                            isRunning
                            ? "Pause"
                            : "Resume"
                        )
                        .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 18)
                    )
                }

                Spacer()
            }
            .padding()
        }

        .onReceive(timer) { _ in

            if isRunning && remainingSeconds > 0 {
                remainingSeconds -= 1
            }
        }
    }

    var timeText: String {

        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60

        if hours > 0 {

            return String(
                format: "%d:%02d:%02d",
                hours,
                minutes,
                seconds
            )

        } else {

            return String(
                format: "%02d:%02d",
                minutes,
                seconds
            )
        }
    }
}

#Preview {

    FocusSessionView(
        task: "Study Swift",
        selectedMinutes: 25,
        distractionsPresent: false
    )
}
