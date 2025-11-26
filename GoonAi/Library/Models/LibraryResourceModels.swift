//
//  LibraryResourceModels.swift
//  GoonAi
//
//  Models for library resources (videos, articles, books)
//

import Foundation

// MARK: - Video Resource

struct VideoResource: Identifiable {
    let id: Int
    let title: String
    let channel: String
    let thumbnail: String
    let duration: String
    let url: String
    let category: String
    
    static let sampleVideos: [VideoResource] = [
        VideoResource(
            id: 1,
            title: "The Science of Porn Addiction",
            channel: "The Conscious Man",
            thumbnail: "https://img.youtube.com/vi/MrwM4BHz1eo/maxresdefault.jpg",
            duration: "12:34",
            url: "https://www.youtube.com/watch?v=MrwM4BHz1eo",
            category: "Science"
        ),
        VideoResource(
            id: 2,
            title: "Breaking Free: A Personal Journey",
            channel: "Atomic Motivation",
            thumbnail: "https://img.youtube.com/vi/Txf6TmtHejg/maxresdefault.jpg",
            duration: "15:20",
            url: "https://www.youtube.com/watch?v=Txf6TmtHejg",
            category: "Personal Stories"
        ),
        VideoResource(
            id: 3,
            title: "The Neuroscience of Addiction",
            channel: "TEDx Talks",
            thumbnail: "https://img.youtube.com/vi/dbYWKVAeu6Y/maxresdefault.jpg",
            duration: "18:45",
            url: "https://www.youtube.com/watch?v=dbYWKVAeu6Y",
            category: "Science"
        ),
        VideoResource(
            id: 4,
            title: "How to Quit Porn Forever",
            channel: "Jordan Green",
            thumbnail: "https://img.youtube.com/vi/ndJe-aDspe0/maxresdefault.jpg",
            duration: "15:30",
            url: "https://www.youtube.com/watch?v=ndJe-aDspe0",
            category: "Recovery"
        ),
        VideoResource(
            id: 5,
            title: "How to Stop Watching Porn",
            channel: "Teachingmensfashion",
            thumbnail: "https://img.youtube.com/vi/CoIt-ubJSC4/maxresdefault.jpg",
            duration: "12:45",
            url: "https://www.youtube.com/watch?v=CoIt-ubJSC4",
            category: "Recovery"
        ),
        VideoResource(
            id: 6,
            title: "The Truth About Porn Addiction",
            channel: "Hamza Unfiltered",
            thumbnail: "https://img.youtube.com/vi/ksdV_tgZf5g/maxresdefault.jpg",
            duration: "20:15",
            url: "https://www.youtube.com/watch?v=ksdV_tgZf5g",
            category: "Science"
        )
    ]
}

// MARK: - Scientific Article Resource

struct ScientificArticle: Identifiable {
    let id: Int
    let title: String
    let source: String
    let readTime: String
    let category: String
    let url: String
    
    static let sampleArticles: [ScientificArticle] = [
        ScientificArticle(
            id: 1,
            title: "Impact of Cybersex and Intensive Internet Use on the Well-Being of Generation Z",
            source: "Journal of Technology in Behavioral Science",
            readTime: "15 min",
            category: "Research",
            url: "https://link.springer.com/article/10.1007/s41347-021-00197-4"
        ),
        ScientificArticle(
            id: 2,
            title: "Internet Addiction and Its Impact on Mental Health",
            source: "PMC",
            readTime: "12 min",
            category: "Research",
            url: "https://pmc.ncbi.nlm.nih.gov/articles/PMC6088458/"
        ),
        ScientificArticle(
            id: 3,
            title: "Neuroscience of Internet Addiction",
            source: "PubMed",
            readTime: "10 min",
            category: "Research",
            url: "https://pubmed.ncbi.nlm.nih.gov/39267458/"
        ),
        ScientificArticle(
            id: 4,
            title: "Digital Addiction and Mental Health",
            source: "PMC",
            readTime: "14 min",
            category: "Research",
            url: "https://pmc.ncbi.nlm.nih.gov/articles/PMC10903670/"
        ),
        ScientificArticle(
            id: 5,
            title: "Psychological Impact of Digital Media",
            source: "Frontiers in Psychology",
            readTime: "16 min",
            category: "Research",
            url: "https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2020.613244/full"
        )
    ]
}

// MARK: - Book Resource

struct BookResource: Identifiable {
    let id: Int
    let title: String
    let author: String
    let category: String
    let cover: String
    let url: String
    
    static let sampleBooks: [BookResource] = [
        BookResource(
            id: 1,
            title: "Your Brain on Porn",
            author: "Gary Wilson",
            category: "Science",
            cover: "https://m.media-amazon.com/images/I/41jLBhIonqL._SX331_BO1,204,203,200_.jpg",
            url: "https://www.amazon.com/Your-Brain-Porn-Pornography-Addiction-ebook/dp/B00N2AH8NW"
        ),
        BookResource(
            id: 2,
            title: "The Porn Trap",
            author: "Wendy Maltz",
            category: "Recovery",
            cover: "https://m.media-amazon.com/images/I/51J8G8XZQZL._SX331_BO1,204,203,200_.jpg",
            url: "https://www.amazon.com/Porn-Trap-Essential-Overcoming-Pornography/dp/0061231878"
        ),
        BookResource(
            id: 4,
            title: "Treating Pornography Addiction",
            author: "Kevin Skinner",
            category: "Recovery",
            cover: "https://m.media-amazon.com/images/I/41jLBhIonqL._SX331_BO1,204,203,200_.jpg",
            url: "https://www.amazon.com/Treating-Pornography-Addiction-Essential-Recovery/dp/097722080X"
        )
    ]
}
