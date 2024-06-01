//
//  ContentView.swift
//  Fondamenti
//
//  Created by Michele Calliari on 11/05/24.
//
import SwiftUI

/**
 * Main view for the "Fondamenti" app.
 * This view serves as a navigation hub to various sections of the app.
 */
struct ContentView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    HStack {
                        /**
                         * Navigation link to the "Congruenze" section.
                         * The button has a blue background, white text, and rounded corners.
                         */
                        NavigationLink(destination: CongruencesSystem()) {
                            Text("Congruenze")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        /**
                         * Navigation link to the "RSA" section.
                         * The button has a blue background, white text, and rounded corners.
                         */
                        NavigationLink(destination: RSACongruence()) {
                            Text("RSA")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    
                    HStack {
                        /**
                         * Navigation link to the "Isomorfismi" section.
                         * The button has a blue background, white text, and rounded corners.
                         */
                        NavigationLink(destination: Isomorphisms()) {
                            Text("Isomorfismi")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        /**
                         * Navigation link to the "Score" section.
                         * The button has a blue background, white text, and rounded corners.
                         */
                        NavigationLink(destination: Score()) {
                            Text("Score")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    
                    /**
                     * Navigation link to the "Tool modulo" section.
                     * The button has a blue background, white text, and rounded corners.
                     */
                    NavigationLink(destination: ModTool()) {
                        Text("Tool modulo")
                            .frame(width: geometry.size.width / 1.5 - 20, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .navigationTitle("Fondamenti")
            }
        }
    }
}
