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
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Brain Rewiring")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Track the new neural pathways you're forming.")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.15), lineWidth: 8)
                        .frame(width: 70, height: 70)
                    Circle()
                        .trim(from: 0, to: CGFloat(progress) / 100)
                        .stroke(
                            AngularGradient(
                                colors: [Color.cyan, Color.purple, Color.cyan],
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 70, height: 70)
                    Text("\(progress)%")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    LinearGradient(
                        colors: [Color.white.opacity(0.08), Color.white.opacity(0.02)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
        )
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
    let onItemAction: (ChecklistItem) -> Void
    
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
                    onItemAction(item)
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
                    
                    if item.hasLaunched {
                        Text("Tap again to mark as done")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
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
    let entries: [JournalEntry]
    let onAddNew: () -> Void
    let onDelete: (JournalEntry) -> Void
    private let maxVisibleEntries = 3
    
    private static let journalDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Journal")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Button(action: onAddNew) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            if entries.isEmpty {
                emptyState
            } else {
                entryList
            }
            
            Button(action: onAddNew) {
                HStack {
                    Image(systemName: "square.and.pencil")
                        .font(.headline)
                    Text("Write a new entry")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
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
    
    @ViewBuilder
    private var emptyState: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("No entries yet.")
                .font(.subheadline)
                .foregroundColor(.white)
            Text("Tap the button below to capture how you're feeling today.")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
    
    private var entryList: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(entries.prefix(maxVisibleEntries), id: \.id) { entry in
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(entry.title.isEmpty ? "Untitled Entry" : entry.title)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(Self.journalDateFormatter.string(from: entry.createdAt))
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.6))
                        Text(entry.body)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                            .lineLimit(3)
                    }
                    
                    Spacer(minLength: 8)
                    
                    Button(role: .destructive) {
                        onDelete(entry)
                    } label: {
                        Image(systemName: "trash")
                            .font(.body)
                            .foregroundColor(.red.opacity(0.9))
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.white.opacity(0.08))
                )
            }
        }
    }
}

// MARK: - Why I'm Quitting Card

struct WhyQuittingCardView: View {
    let reasonText: String
    let lastUpdated: Date?
    let onEdit: () -> Void
    
    private var formattedDate: String {
        guard let lastUpdated else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: lastUpdated)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Why I'm Quitting")
                .font(.headline)
                .foregroundColor(.white)
            
            Text(reasonText.isEmpty ? "Tap edit to write your deepest why." : reasonText)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(4)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if !formattedDate.isEmpty {
                Text("Updated \(formattedDate)")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Button(action: onEdit) {
                HStack {
                    Image(systemName: "pencil.circle.fill")
                        .font(.title3)
                    Text("Edit Reason")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.purple.opacity(0.6))
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
            HStack(spacing: 14) {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Panic Button")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.95, green: 0.26, blue: 0.21),
                                Color(red: 0.78, green: 0.0, blue: 0.18)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: Color(red: 0.7, green: 0.04, blue: 0.18).opacity(0.45), radius: 20, x: 0, y: 10)
            )
        }
        .buttonStyle(.plain)
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

