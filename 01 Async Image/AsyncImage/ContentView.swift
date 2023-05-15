//
//  ContentView.swift
//  AsyncImage
//
//  Created by Vuk Knezevic on 11.01.23.
//

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View {
        self.imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    
    private let imageUrl: String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        // MARK: - 1. Basic
        /*
        AsyncImage(url: URL(string: imageUrl))
         */
        
        // MARK: - 2. Scale
        // Veca vrednost scale-a, slika ce biti manja.
        // Default-na vrednost scale-a je 1.
        // Ukoliko hocu da slika bude veca, scale postavljam manjim od 1.
        /*
        AsyncImage(url: URL(string: imageUrl), scale: 3.0)
         */
        
        // MARK: - 3. Placeholder
        /*
        AsyncImage(url: URL(string: imageUrl)) {
            $0.imageModifier()
        } placeholder: {
            Image(systemName: "photo.circle.fill")
                .iconModifier()
        }
        .padding(40)
         */
        
        // MARK: - 4. Phase
        /*
        AsyncImage(url: URL(string: imageUrl)) {
            if let image = $0.image {
                image
                    .imageModifier()
            } else if $0.error != nil {
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            } else {
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            }
        }
        .padding(40)
         */
        
        // MARK: - 5. Animation
        AsyncImage(url: URL(string: imageUrl), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) {
            switch $0 {
            case .success(let image):
                image
                    .imageModifier()
                    //.transition(.move(edge: .bottom))
                    //.transition(.slide)
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill")
                    .iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill")
                    .iconModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
