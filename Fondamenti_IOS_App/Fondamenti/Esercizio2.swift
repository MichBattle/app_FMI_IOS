//
//  Esercizio2.swift
//  Fondamenti
//
//  Created by Michele Calliari on 11/05/24.
//
import SwiftUI
import Foundation

//Calcola MCD con sostituz a ritroso
func euclideanAlgorithm(_ a: Int, _ b: Int) -> String {
    var (x0, x1, y0, y1) = (1, 0, 0, 1)
    let (a0, b0) = (a, b)
    var (a, b) = (a, b)
    var result = ""
    while b != 0 {
        result += "\(a) = \(a / b)*\(b) + \(a % b)\n"
        let q = a / b
        (a, b) = (b, a % b)
        (x0, x1) = (x1, x0 - q * x1)
        (y0, y1) = (y1, y0 - q * y1)
    }
    result += "MCD = \(a) = \(x0)*\(a0) + \(y0)*\(b0)"
    return result
}

//Risolve l'esercizio, calcola soluz particolare e completa
func solveCongruences(_ a: Int, _ k: Int, _ b: Int, _ j: Int) -> String {
    let s = abs(a - b)
    
    var (mcd, k0, j0) = euclide(k, j)
    
    let div = Double(s) / Double(mcd)
    k0 = Int(Double(k0) * Double(k) * div)
    j0 = Int(Double(j0) * Double(-j) * div)
    j0 += Int(Double(b))
    k0 += Int(Double(a))
    
    var c = Int(k0)
    var result = "C = \(c)\n"
    
    let m = mcm(k, j)
    
    while c < 0 {
        c += m
    }
    
    result += "S = \(c)"
    
    return result
}

//ritorna mcd e i 2 valori per cui vengono moltiplicati k e j
func euclide(_ a: Int, _ b: Int) -> (Int, Int, Int) {
    var (x0, x1, y0, y1) = (1, 0, 0, 1)
    let (_, _) = (a, b)
    var (a, b) = (a, b)
    while b != 0 {
        let q = a / b
        (a, b) = (b, a % b)
        (x0, x1) = (x1, x0 - q * x1)
        (y0, y1) = (y1, y0 - q * y1)
    }
    return (a, x0, y0)
}

//calcola mcd normalmente
func mcd(_ a: Int, _ b: Int) -> Int {
    var (a, b) = (a, b)
    while b != 0 {
        (a, b) = (b, a % b)
    }
    return a
}

//calcola mcm
func mcm(_ a: Int, _ b: Int) -> Int {
    return (a * b) / mcd(a, b)
}

//esegue l'esercizio
func menu(xNumber: Int, xMod: Int, yNumber: Int, yMod: Int) -> Text {
    let k = xMod
    let j = yMod
    
    var result = ""
    
    if k > j {
        result += "\nCALCOLO MCD CON EUCLIDE E SOSTITUZ A RITROSO:\n"
        result += "\(euclideanAlgorithm(k, j))\n"
        result += "MCM = \(mcm(k, j))\n"
        result += "\nRISULTATI FINALI:\n"
        result += "\(solveCongruences(xNumber, k, yNumber, j))"
    } else {
        result += "\nCALCOLO MCD CON EUCLIDE E SOSTITUZ A RITROSO:\n"
        result += "\(euclideanAlgorithm(j, k))\n"
        result += "MCM = \(mcm(j, k))\n"
        result += "\nRISULTATI FINALI:\n"
        result += "\(solveCongruences(yNumber, j, xNumber, k))"
    }
    
    return Text(result)
}

// Vista modale per visualizzare i contenuti dei campi di testo
struct ModalView6: View {
    @Environment(\.presentationMode) var presentationMode
    
    var xNumber: Int
    var xMod: Int
    var yNumber: Int
    var yMod: Int
    
    var body: some View {
        VStack {
            menu(xNumber: xNumber, xMod: xMod, yNumber: yNumber, yMod: yMod)
            
            Spacer()
            
            Button(action: {
                // Chiude la vista modale
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Indietro")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

struct Esercizio2: View {
    @State private var xNumber = ""
    @State private var xMod = ""
    @State private var yNumber = ""
    @State private var yMod = ""
    @State private var showModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Prima congruenza:")
                    .font(.headline)
                
                TextField("Numero", text: $xNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Mod", text: $xMod)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Group {
                Text("Seconda congruenza:")
                    .font(.headline)
                
                TextField("Numero", text: $yNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Mod", text: $yMod)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Spacer() // Spacer per spingere il bottone in basso
            
            HStack {
                Spacer()
                Button(action: {
                    showModal = true
                }) {
                    Text("Calcola")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding(.bottom, 20)
        }
        .padding()
        .navigationTitle("Sistema")
        .sheet(isPresented: $showModal) {
            // Passa i valori dei campi di testo alla vista modale
            ModalView6(xNumber: Int(xNumber) ?? 0, xMod: Int(xMod) ?? 0, yNumber: Int(yNumber) ?? 0, yMod: Int(yMod) ?? 0)
        }
    }
}

struct Esercizio2View_Previews: PreviewProvider {
    static var previews: some View {
        Esercizio2()
    }
}
