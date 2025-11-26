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
            
            Cues and Triggers
            
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
        Article(
            category: .addictionAndMyths,
            index: 3,
            title: "Why 'Just One More Time' Never Works",
            body: """
            If you've ever told yourself "just one more time," you know exactly how this story ends.
            
            You watch. You feel guilty. You promise yourself it's the last time. And then a few days later, you're back again.
            
            The Cycle of Relapse
            
            This isn't about lack of willpower. It's about how addiction rewires the brain's decision-making processes. Each "one more time" reinforces the neural pathways that make the behavior harder to resist in the future.
            
            The Bargaining Phase
            
            Your brain is incredibly skilled at rationalization. It will convince you that:
            • You deserve it after a stressful day
            • You'll quit tomorrow instead
            • One time won't hurt your progress
            
            But each relapse teaches your brain that the urge is stronger than your commitment.
            
            Breaking the Pattern
            
            Real change happens when you stop negotiating with yourself. When you recognize the urge, acknowledge it, and choose a different response—not because you're perfect, but because you're committed to a different path.
            
            Recovery isn't about never having urges. It's about learning to respond differently when they arise.
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
        Article(
            category: .healthEffects,
            index: 2,
            title: "How Porn Affects Your Relationships (Even If You're Single)",
            body: """
            Porn doesn't just affect romantic relationships—it shapes how you connect with everyone around you.
            
            Intimacy Avoidance
            
            When your brain gets used to the instant gratification of porn, real human connection starts to feel like too much work. You might find yourself avoiding vulnerability, deep conversations, or emotional closeness.
            
            Unrealistic Expectations
            
            Porn creates a distorted view of sex, bodies, and relationships. These unrealistic standards can lead to dissatisfaction, anxiety, and performance pressure when real intimacy happens.
            
            Emotional Disconnection
            
            Many people report feeling emotionally numb or distant from partners, friends, and family. The constant dopamine hits from porn can make everyday interactions feel dull or unfulfilling.
            
            Trust and Honesty Issues
            
            Hiding porn use creates a barrier between you and others. The secrecy, shame, and lying erode self-trust and make authentic connection nearly impossible.
            
            The Path Forward
            
            Quitting porn isn't just about stopping a behavior—it's about reopening the door to genuine human connection. As your brain heals, you'll find yourself more present, more engaged, and more capable of real intimacy.
            """
        ),
        Article(
            category: .healthEffects,
            index: 3,
            title: "The Link Between Porn and Mental Health Struggles",
            body: """
            Porn addiction rarely exists in isolation. It's often intertwined with anxiety, depression, and other mental health challenges.
            
            Depression and Low Mood
            
            Chronic porn use is associated with increased rates of depression. The shame cycle, isolation, and dopamine dysregulation all contribute to persistent low mood and hopelessness.
            
            Anxiety and Social Withdrawal
            
            Many people experience heightened anxiety, especially in social or intimate situations. The fear of judgment, combined with the brain's rewired reward system, can lead to avoidance of real-world interactions.
            
            Reduced Stress Tolerance
            
            When porn becomes your go-to coping mechanism for stress, you lose the ability to develop healthier ways to manage difficult emotions. This creates a fragile mental state where minor stressors feel overwhelming.
            
            The Recovery Connection
            
            Addressing porn addiction often requires also addressing underlying mental health issues. Therapy, support groups, and healthy coping strategies work together to create lasting change.
            
            Healing is possible—and it starts with recognizing that your mental health and your recovery are deeply connected.
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
        Article(
            category: .quittingBenefits,
            index: 2,
            title: "The Energy You Didn't Know You Were Missing",
            body: """
            One of the most unexpected benefits of quitting porn? You get your energy back.
            
            Not just physical energy—though that improves too. We're talking about the mental and emotional energy that gets drained every time you binge, feel guilty, and try to hide it.
            
            Mental Energy
            
            Think about how much mental space porn takes up:
            • Planning when you can watch
            • Hiding your habits
            • Dealing with shame and regret
            • Promising yourself you'll stop
            
            When you quit, that mental bandwidth becomes available for things that actually matter—your goals, your relationships, your creativity.
            
            Emotional Energy
            
            Porn creates an emotional rollercoaster: excitement, guilt, numbness, shame. It's exhausting. When you step away, you start experiencing emotions in a more balanced, sustainable way.
            
            Motivation Returns
            
            Many people report feeling motivated again after quitting. Projects that felt overwhelming suddenly seem doable. Goals that felt distant start feeling achievable.
            
            Your brain isn't fighting itself anymore—and that makes all the difference.
            """
        ),
        Article(
            category: .quittingBenefits,
            index: 3,
            title: "Better Sleep, Better Life: The Recovery Connection",
            body: """
            If you've been stuck in the cycle of late-night porn binges, you know the toll it takes on your sleep.
            
            The Sleep-Porn Connection
            
            Porn consumption, especially before bed, disrupts your natural sleep cycle:
            • Blue light from screens suppresses melatonin
            • Dopamine spikes make it harder to wind down
            • Guilt and shame create mental restlessness
            
            When You Quit
            
            Within the first few weeks of quitting, many people notice:
            • Falling asleep faster
            • Sleeping more deeply
            • Waking up feeling more rested
            • Having more consistent energy throughout the day
            
            The Ripple Effect
            
            Better sleep doesn't just mean feeling less tired. It means:
            • Better mood regulation
            • Improved focus and decision-making
            • Stronger immune function
            • More resilience to stress and triggers
            
            Recovery isn't just about stopping a behavior—it's about reclaiming the foundational habits that support a healthy, fulfilling life.
            
            Sleep is one of them.
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
        ),
        Article(
            category: .recoveryStrategies,
            index: 2,
            title: "What to Do When an Urge Hits: The 5-Minute Rule",
            body: """
            Urges are inevitable. How you respond to them determines your recovery.
            
            The 5-Minute Rule
            
            When an urge hits, commit to waiting just 5 minutes before acting on it. During those 5 minutes:
            
            1. Leave the room or change your environment
            2. Do something physical—push-ups, a walk, stretching
            3. Call or text someone you trust
            4. Journal what you're feeling and what triggered the urge
            
            Why It Works
            
            Most urges peak and then naturally subside within 10-15 minutes. By creating distance between the trigger and the action, you give your prefrontal cortex time to re-engage.
            
            You're not trying to make the urge disappear—you're practicing riding it out.
            
            Building the Habit
            
            Each time you successfully wait out an urge, you're strengthening new neural pathways. You're teaching your brain that urges don't have to be acted on.
            
            Recovery is built in these small moments of resistance.
            """
        ),
        Article(
            category: .recoveryStrategies,
            index: 3,
            title: "The Role of Community in Long-Term Recovery",
            body: """
            You don't have to do this alone. In fact, trying to recover in isolation is one of the biggest predictors of relapse.
            
            Why Community Matters
            
            Addiction thrives in secrecy. Community brings your struggle into the light, where it loses its power.
            
            Being part of a recovery community provides:
            • Accountability without judgment
            • Shared experiences and strategies
            • Hope from people who are further along
            • A reminder that you're not broken or alone
            
            Types of Support
            
            Your community can take many forms:
            • Online forums or support groups
            • In-person accountability partners
            • Therapy or counseling
            • Faith-based recovery groups
            • Friends who know your struggle and support your goals
            
            Taking the First Step
            
            Opening up is scary. But vulnerability is where healing begins.
            
            You don't need to share with everyone—but sharing with someone is essential.
            
            Recovery isn't about perfection. It's about progress. And progress happens best when you have people walking alongside you.
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
    let filename: String // Audio file name in bundle
    
    static let tracks: [AudioTrack] = [
        AudioTrack(title: "Ocean Waves", imageName: "ocean_waves", duration: 600, filename: "ocean_waves.mp3"),
        AudioTrack(title: "Rain & Thunder", imageName: "rain_thunder", duration: 600, filename: "rain_thunder.mp3"),
        AudioTrack(title: "Forest Sounds", imageName: "forest_sounds", duration: 600, filename: "forest_sounds.mp3"),
        AudioTrack(title: "Deep Ocean", imageName: "deep_ocean", duration: 600, filename: "deep_ocean.mp3")
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
