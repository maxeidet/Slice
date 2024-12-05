//
//  EditProfileView.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-29.
//

import SwiftUI

struct EditProfileView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Top Bar
                HStack {
                    Image(systemName: "arrow.left")
                        .frame(width: 15)
                    Spacer()
                    Text("Edit profile")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "link")
                        .frame(width: 15)
                }
                .padding(.horizontal)
                
                // Profile Image
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                    Button(action: {
                        // Action for changing profile picture
                    }) {
                        Text("Change Profile Picture")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 20)
                
                // Input Fields
                VStack(spacing: 20) {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    EditProfileView()
}
