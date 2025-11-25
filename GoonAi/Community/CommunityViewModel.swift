//
//  CommunityViewModel.swift
//  GoonAi
//
//  ViewModel for Community tab
//

import SwiftUI
import Combine

class CommunityViewModel: ObservableObject {
    
    // TODO: Replace with actual Discord invite link
    private let discordInviteURL = "https://discord.gg/nogoon"
    
    func openDiscord() {
        guard let url = URL(string: discordInviteURL) else { return }
        UIApplication.shared.open(url)
    }
}

