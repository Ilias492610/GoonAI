//
//  LibraryModels.swift
//  GoonAi
//
//  Library models for NoGoon
//

import Foundation
import SwiftUI

// MARK: - Article Category

enum ArticleCategory: String, CaseIterable, Identifiable, Codable {
    case addictionAndMyths = "Addiction and Myths"
    case healthEffects = "Health Effects"
    case quittingBenefits = "Quitting Benefits"
    case recoveryStrategies = "Recovery Strategies"
    
    var id: String { rawValue }
    
    var color: Color {
        switch self {
        case .addictionAndMyths: return Color.orange
        case .healthEffects: return Color.pink
        case .quittingBenefits: return Color.purple
        case .recoveryStrategies: return Color.blue
        }
    }
}

// MARK: - Article Model

struct Article: Identifiable, Codable, Hashable {
    let id: String
    let category: ArticleCategory
    let index: Int
    let title: String
    let body: String
    var isCompleted: Bool
    
    init(id: String = UUID().uuidString, category: ArticleCategory, index: Int, title: String, body: String, isCompleted: Bool = false) {
        self.id = id
        self.category = category
        self.index = index
        self.title = title
        self.body = body
        self.isCompleted = isCompleted
    }
    
    static let sampleArticles: [Article] = [
        // Addiction and Myths
        Article(
            category: .addictionAndMyths,
            index: 1,
            title: "The Neuroscience of Porn Addiction—How It Hijacks the Brain",
            body: """
            Understanding porn addiction requires a deep dive into the brain's inner workings. Pornography can significantly alter neural pathways, affecting reward circuits, motivation, and behavior patterns.
            
            The Brain's Reward System
            
            The brain's reward system is designed to reinforce behaviors essential for survival, such as eating and social interaction. When engaging with pornography, the brain releases high levels of dopamine, a neurotransmitter associated with pleasure and reinforcement. This dopamine surge exceeds natural levels, creating a powerful association that can lead to compulsive behavior.
            
            Desensitization and Tolerance
            
            Repeated exposure to pornography can lead to desensitization, where the brain requires increasingly intense stimuli to achieve the same dopamine response. This tolerance mechanism is similar to substance addiction and can drive escalating consumption patterns.
            
            and Triggers
            
            Environmental cues such as stress, boredom, or certain emotional states can trigger cravings for pornography. These triggers are reinforced through conditioning, where the brain associates specific cues with the reward of porn use, making relapse more likely even after periods of abstinence.
            
            Conclusion
            
            By understanding how porn addiction alters brain function, individuals can better appreciate the challenges faced during recovery. Recognizing that porn addiction is not merely a lack of willpower but a complex interaction of neural processes is a crucial step toward effective treatment and self-compassion.
            """
        ),
        Article(
            category: .addictionAndMyths,
            index: 2,
            title: "Debunking Common Myths About Porn Addiction",
            body: """
            Many myths surround porn addiction, leading to misunderstanding and stigma. Let's address some common misconceptions.
            
            Myth 1: Only weak-willed people get addicted
            Reality: Addiction is a complex neurological condition that can affect anyone, regardless of willpower or character strength.
            
            Myth 2: Porn addiction isn't real
            Reality: Scientific research shows that compulsive porn use activates the same brain regions as substance addictions.
            
            Myth 3: You can quit anytime
            Reality: Recovery often requires structured support, behavioral changes, and time to rewire neural pathways.
            """
        ),
        
        // Health Effects
        Article(
            category: .healthEffects,
            index: 1,
            title: "Physical Health Consequences of Porn Addiction",
            body: """
            Porn addiction can have various physical health consequences that extend beyond mental wellbeing.
            
            Sexual Dysfunction
            
            Regular porn consumption can lead to erectile dysfunction, delayed ejaculation, and decreased sexual satisfaction with real partners.
            
            Sleep Disruption
            
            Late-night viewing can disrupt sleep patterns, leading to fatigue and decreased daytime functioning.
            
            Physical Neglect
            
            Time spent viewing porn may replace physical exercise and self-care activities, impacting overall health.
            """
        ),
        
        // Quitting Benefits
        Article(
            category: .quittingBenefits,
            index: 1,
            title: "Reclaiming Mental Clarity and Emotional Stability",
            body: """
            One of the most significant benefits of quitting porn is the return of mental clarity and emotional stability.
            
            Improved Focus
            
            Many report enhanced concentration and cognitive function within weeks of stopping.
            
            Emotional Regulation
            
            Without the dopamine spikes from porn, emotions become more balanced and manageable.
            
            Self-Confidence
            
            Successfully overcoming addiction builds tremendous self-esteem and personal pride.
            """
        ),
        
        // Recovery Strategies
        Article(
            category: .recoveryStrategies,
            index: 1,
            title: "Creating a Personalized Recovery Plan",
            body: """
            A personalized recovery plan is essential for long-term success in overcoming porn addiction.
            
            Identify Triggers
            
            Document situations, emotions, and environments that lead to urges. This awareness is the first step to managing them.
            
            Build Support Systems
            
            Connect with therapists, support groups, or accountability partners who understand your journey.
            
            Establish Healthy Routines
            
            Replace old habits with positive activities: exercise, hobbies, social connections, and mindfulness practices.
            """
        )
    ]
}

// MARK: - Mindfulness Audio Track

struct AudioTrack: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String // Asset name or placeholder
    let duration: TimeInterval
    
    static let tracks: [AudioTrack] = [
        AudioTrack(title: "Ocean Waves", imageName: "ocean_waves", duration: 600),
        AudioTrack(title: "Rain & Thunder", imageName: "rain_thunder", duration: 600),
        AudioTrack(title: "Forest Sounds", imageName: "forest_sounds", duration: 600),
        AudioTrack(title: "Deep Ocean", imageName: "deep_ocean", duration: 600)
    ]
}

// MARK: - Chat Message

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
    let timestamp: Date
    
    init(text: String, isUser: Bool, timestamp: Date = Date()) {
        self.text = text
        self.isUser = isUser
        self.timestamp = timestamp
    }
}

