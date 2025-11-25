import SwiftUI

struct Goal: Identifiable, Hashable, Equatable {
    let id = UUID()
    let icon: String
    let title: String
    let color: Color

    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct GoalSelectView: View {
    @State private var goals = [
        Goal(icon: "heart.fill", title: "Stronger relationships", color: .red),
        Goal(icon: "brain.head.profile", title: "Improved self-control", color: .cyan),
        Goal(icon: "bolt.fill", title: "Improved desire and sex life", color: .red),
        Goal(icon: "face.smiling", title: "Improved mood and happiness", color: .yellow),
        Goal(icon: "sparkles", title: "Pure and healthy thoughts", color: .green),
        Goal(icon: "bolt.fill", title: "More energy and motivation", color: .orange),
        Goal(icon: "person.fill.checkmark", title: "Improved self-confidence", color: .blue),
    ]
    @State private var selectedGoals: Set<Goal> = []
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Dark gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.1, green: 0.15, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            StarryBackgroundView()
            
            VStack(alignment: .leading, spacing: 0) {
                // Back button
                HStack {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        // Just continue
                        onComplete()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    Spacer()
                    Text("Choose Your Goals")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Select the goals you wish to track during your reboot.")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.bottom, 15)
                        
                        
                        
                        
                        ForEach(goals) { goal in
                            VStack(spacing: 20) {
                                GoalRow(goal: goal, isSelected: selectedGoals.contains(goal)) {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    if selectedGoals.contains(goal) {
                                        selectedGoals.remove(goal)
                                        AnalyticsManager.shared.trackEvent(eventName: "select_goal", properties: ["goal": goal.title])
                                    } else {
                                        selectedGoals.insert(goal)
                                        AnalyticsManager.shared.trackEvent(eventName: "select_goal", properties: ["goal": goal.title])
                                        AnalyticsManager.shared.updateUserAttributes(attributes: ["goals": selectedGoals.map({ $0.title }).joined(separator: ",")])
                                    }
                                }
                                .padding(.horizontal, 10)
                                .padding(.bottom, 5)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
                    .padding(.bottom, 100)
                }
                
                // Button at bottom
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    onComplete()
                }) {
                    Text("Track these goals")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

struct GoalRow: View {
    let goal: Goal
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(goal.color.opacity(isSelected ? 0.5 : (UITraitCollection.current.userInterfaceStyle == .dark ? 0.3 : 0.1)))
                    .frame(height: 65)
                    .shadow(color: Color.black.opacity(0.3), radius: 1)
                HStack {
                    Image(systemName: goal.icon)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(goal.color)
                        .cornerRadius(15)
                        .padding(.trailing, 5)
                    
                    Text(goal.title)
                        .foregroundColor(.white)
                        .font(.headline)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                            .foregroundColor(.white.opacity(0.4))
                    }
                }
                .padding()
            }
        }
    }
}
