//
//  ContentView.swift
//  Fondamenti
//
//  Created by Michele Calliari on 11/05/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Spacer() // Spazio sopra per centrare verticalmente
                    
                    HStack {
                        NavigationLink(destination: Esercizio2()) {
                            Text("Congruenze")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        NavigationLink(destination: Esercizio3()) {
                            Text("RSA")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    
                    HStack {
                        NavigationLink(destination: Isomorfismi()) {
                            Text("Isomorfismi")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        NavigationLink(destination: Score()) {
                            Text("Score")
                                .frame(width: geometry.size.width / 3 - 20, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    
                    NavigationLink(destination: CalcolaModulo()) {
                        Text("Tool modulo")
                            .frame(width: geometry.size.width / 1.5 - 20, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    Spacer() // Spazio sotto per centrare verticalmente
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .navigationTitle("Fondamenti")
            }
        }
    }
}
