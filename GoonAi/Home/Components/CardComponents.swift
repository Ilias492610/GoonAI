//
//  CardComponents.swift
//  GoonAi
//
//  Reusable card components for Home
//

import SwiftUI

// MARK: - Brain Rewiring Card

struct BrainRewiringCardView: View {
    let progress: Int
    
    var body: some View {
        HStack {
            Text("Brain Rewiring")
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            ZStack(alignment: .leading) {
                // Background track
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 150, height: 8)
                
                // Progress fill
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 150 * CGFloat(progress) / 100.0, height: 8)
            }
            
            Text("\(progress)%")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 45, alignment: .trailing)
        }
        .padding()
        .glassEffect()
        .padding(.horizontal)
    }
}

// MARK: - Quote Card

struct QuoteCardView: View {
    let quote: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text("\"")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white.opacity(0.5))
                .offset(y: -10)
            
            Text(quote)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("\"")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white.opacity(0.5))
                .offset(y: 10)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassEffect()
        .padding(.horizontal)
    }
}

// MARK: - Checklist Card

struct ChecklistCardView: View {
    @Binding var items: [ChecklistItem]
    let onItemAction: (ChecklistItem.ActionType) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
                Text("Checklist")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 4)
            
            ForEach($items) { $item in
                ChecklistItemRow(item: $item) {
                    onItemAction(item.actionType)
                }
            }
        }
        .padding()
        .glassEffect()
        .padding(.horizontal)
    }
}

struct ChecklistItemRow: View {
    @Binding var item: ChecklistItem
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: item.iconName)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if item.isCompleted {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Journal Card

struct JournalCardView: View {
    let onAddNew: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Journal")
                .font(.headline)
                .foregroundColor(.white)
            
            Button(action: onAddNew) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                    Text("Add New")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.blue.opacity(0.6))
                )
            }
        }
        .padding()
        .glassEffect()
        .padding(.horizontal)
    }
}

// MARK: - Content Blocker Card

struct ContentBlockerCardView: View {
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "shield.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Content Blocker")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Block distracting websites and apps")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding()
            .glassEffect()
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Panic Button

struct PanicButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.title2)
                Text("Panic Button")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.red, Color.red.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
            .shadow(color: Color.red.opacity(0.4), radius: 15, x: 0, y: 8)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

// MARK: - Pledge Check-In Pill

struct PledgeCheckInPill: View {
    let hoursRemaining: Int
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "info.circle.fill")
                .font(.caption)
            
            Text("\(hoursRemaining) hours till check-in")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

