//
//  PodcastModels.swift
//  GoonAi
//
//  Models for podcast resources
//

import Foundation

// MARK: - Podcast Resource

struct PodcastResource: Identifiable {
    let id: Int
    let title: String
    let host: String
    let duration: String
    let category: String
    let url: String
    let description: String
    
    static let samplePodcasts: [PodcastResource] = [
        PodcastResource(
            id: 1,
            title: "Unhooked: Breaking Porn Addiction Podcast",
            host: "Jeremy Lipkowitz",
            duration: "30-60 min",
            category: "Recovery",
            url: "https://podcasts.apple.com/us/podcast/unhooked-breaking-porn-addiction-podcast/id1648984850",
            description: "Dedicated to helping people break free from porn addiction and other compulsive behaviors related to the internet, sex, and intimacy. Rooted in Buddhist wisdom, neuroscience, coaching, and mindfulness."
        ),
        PodcastResource(
            id: 2,
            title: "Overcome Pornography for Good",
            host: "Sara Brewer",
            duration: "20-45 min",
            category: "Recovery",
            url: "https://podcasts.apple.com/us/podcast/overcome-pornography-for-good/id1549605485",
            description: "Practical coaching and strategies to overcome pornography addiction using mindfulness techniques and evidence-based approaches."
        ),
        PodcastResource(
            id: 3,
            title: "Porn Reboot Podcast",
            host: "J.K. Emezi",
            duration: "30-60 min",
            category: "Recovery",
            url: "https://open.spotify.com/show/0ILT9xCM1SxEbJpWUmlF00",
            description: "For executives, entrepreneurs, and professionals who want to quit porn, improve productivity, and rebuild relationships."
        ),
        PodcastResource(
            id: 4,
            title: "Couples Healing From Pornography Addiction",
            host: "Sam Tielemans, LMFT",
            duration: "20-45 min",
            category: "Recovery",
            url: "https://podcasts.apple.com/us/podcast/couples-healing-from-pornography-addiction/id1544141458",
            description: "A resource to help husbands in their porn addiction recovery and to help couples restore trust and connection in their marriage."
        ),
        PodcastResource(
            id: 5,
            title: "Porn, Betrayal, Sex and the Experts",
            host: "PBSE",
            duration: "30-60 min",
            category: "Science",
            url: "https://open.spotify.com/show/0ILT9xCM1SxEbJpWUmlF00",
            description: "Expert insights on pornography addiction, betrayal trauma, and relationship healing."
        )
    ]
}
