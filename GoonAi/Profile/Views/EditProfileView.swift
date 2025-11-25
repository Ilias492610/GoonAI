//
//  EditProfileView.swift
//  GoonAi
//
//  Edit Profile screen
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var showNameEditor = false
    @State private var showAgeEditor = false
    @State private var showGenderPicker = false
    @State private var showOrientationPicker = false
    @State private var showEthnicityPicker = false
    @State private var showReligiousPicker = false
    @State private var showRegionPicker = false
    @State private var showDeleteConfirmation = false
    @State private var showLogoutConfirmation = false
    
    var body: some View {
        ZStack {
            StarryBackgroundView()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    Text("Your profile")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear.frame(width: 44)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Email (read-only)
                        ProfileFieldRow(
                            label: "Email",
                            value: viewModel.userProfile.email,
                            isEditable: false,
                            action: {}
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Name
                        ProfileFieldRow(
                            label: "Name",
                            value: viewModel.userProfile.name,
                            isEditable: true,
                            action: { showNameEditor = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Age
                        ProfileFieldRow(
                            label: "Age",
                            value: "\(viewModel.userProfile.age)",
                            isEditable: true,
                            action: { showAgeEditor = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Gender
                        ProfileFieldRow(
                            label: "Gender",
                            value: viewModel.userProfile.gender,
                            isEditable: true,
                            action: { showGenderPicker = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Orientation
                        ProfileFieldRow(
                            label: "Orientation",
                            value: viewModel.userProfile.orientation,
                            isEditable: true,
                            action: { showOrientationPicker = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Ethnicity
                        ProfileFieldRow(
                            label: "Ethnicity",
                            value: viewModel.userProfile.ethnicity,
                            isEditable: true,
                            action: { showEthnicityPicker = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Religious content
                        ProfileFieldRow(
                            label: "Religious content",
                            value: viewModel.userProfile.religiousContent,
                            isEditable: true,
                            action: { showReligiousPicker = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Region
                        ProfileFieldRow(
                            label: "Region",
                            value: viewModel.userProfile.region,
                            isEditable: true,
                            action: { showRegionPicker = true }
                        )
                        .padding(.horizontal, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Delete Profile
                        DestructiveActionButton(title: "Delete Profile") {
                            showDeleteConfirmation = true
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                        
                        // Logout
                        DestructiveActionButton(title: "Logout") {
                            showLogoutConfirmation = true
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                }
            }
        }
        .alert("Delete Profile", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                viewModel.deleteProfile()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete your profile? This action cannot be undone.")
        }
        .alert("Logout", isPresented: $showLogoutConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Logout", role: .destructive) {
                viewModel.logout()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to logout?")
        }
    }
}

