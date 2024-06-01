//
//  Esercizio3.swift
//  Fondamenti
//
//  Created by Michele Calliari on 11/05/24.
//
import SwiftUI
import Foundation

//scompone un numero in fattori primi
func fattoriPrimi(_ n: Int) -> [Int] {
    var n = n
    var i = 2
    var factors = [Int]()
    while i * i <= n {
        if n % i != 0 {
            i += 1
        } else {
            n /= i
            factors.append(i)
        }
    }
    if n > 1 {
        factors.append(n)
    }
    return factors
}

//calcola phi di eulero di un numero
func phiEulero(_ n: Int) -> Int {
    var n = n
    var result = n
    var p = 2
    while p * p <= n {
        if n % p == 0 {
            while n % p == 0 {
                n /= p
            }
            result -= result / p
        }
        p += 1
    }
    if n > 1 {
        result -= result / n
    }
    return result
}

//esegue l'algoritmo di euclide con sostituz a ritroso su due numeri
//ritorna il numero per cui viene moltiplicata la potenza, stringa che contiene tutti i passaggi
func euclideanAlgorithm2(_ a: Int, _ b: Int) -> (Int, String) {
    var a = a
    var b = b
    let keep = b
    var x0 = 1, x1 = 0, y0 = 0, y1 = 1
    let a0 = a, b0 = b
    var str = ""
    
    // Aggiunta della condizione if per evitare il primo ciclo del while
    if b <= a {
        str += "\(a) = \(a / b)*\(b) + \(a % b)\n"
    }
    
    while b != 0 {
        // Rimozione del comando print dal corpo del while
        let q = a / b
        (a, b) = (b, a % b)
        (x0, x1) = (x1, x0 - q * x1)
        (y0, y1) = (y1, y0 - q * y1)
        
        // Aggiunta della stampa all'interno del while solo se b != 0
        if b != 0 {
            str += "\(a) = \(a / b)*\(b) + \(a % b)\n"
        }
    }
    str += "MCD = \(a) = \(x0)*\(a0) + \(y0)*\(b0)\n"
    var z = 0
    if a0 != keep{ //prendo il valore che moltiplica number
        z = x0
    }else{
        z = y0
    }
    
    while(z < 0){ //fiche z è negativa aggiunge phi(n)
        z += keep
    }
    
    return (z, str)
}

//calcola l'orbita
func calculateModularExponentiation(_ k: Int, residue: Int, modulus: Int) -> String {
    var result = 1
    var str = ""
    for i in 1...k {
        result = (result * residue) % modulus
        str += "\(residue)^\(i) (mod \(modulus)) = \(result)\n"
    }
    return str
}

//calcola le soluz min > 0 e max < 0
func congruenceSolver(_ k: Int, residue: Int, modulus: Int) -> String {
    var solutions = [Int]()
    for x in 0..<modulus {
        var result = 1
        for _ in 0..<k {
            result = (result * x) % modulus
        }
        if result == residue {
            solutions.append(x)
        }
    }
    if solutions.isEmpty {
        return "Non ci sono soluzioni.\n"
    }
    let minPositiveSolution = solutions.min()!
    let maxNegativeSolution = solutions.map { $0 - modulus }.max()!
    return "Minima soluzione positiva: \(minPositiveSolution)\nMassima soluzione negativa: \(maxNegativeSolution)\n"
}

//esegue tutto
func menu2(potenza: Int, number: Int, mod: Int) -> String {
    var result = ""
    
    result += "Scomposizione in fattori primi (1):\n"
    result += "\(number) = \(fattoriPrimi(number))\n"
    result += "\(mod) = \(fattoriPrimi(mod))\n\n"

    let phi = phiEulero(mod)
    result += "Scomposizione in fattori primi (2):\n"
    result += "\(potenza) = \(fattoriPrimi(potenza))\n"
    result += "phi(\(mod)) = \(phi) = \(fattoriPrimi(phi))\n\n"
    
    let (f, ff) = euclideanAlgorithm2(potenza, phi)

    result += "MCD con sostituz a ritroso su \(potenza) e phi(\(mod)):\n"
    result += "\(ff)\n"
    
    result += "d:=\(f)\n"
    result += "Calcolo orbita \(number)^\(f)mod\(mod):\n"
    result += "\(calculateModularExponentiation(f, residue: number, modulus: mod))"
    
    result += "\nTrovo soluz max e min:\n"
    result += "\(congruenceSolver(potenza, residue: number, modulus: mod))\n"
    
    return result
}

// Vista modale per visualizzare i contenuti dei campi di testo
struct ModalView2: View {
    @Environment(\.presentationMode) var presentationMode
    
    var potenza: Int
    var mod: Int
    var number: Int
    
    var body: some View {
        ScrollView {
            VStack {
                Text(menu2(potenza: potenza, number: number, mod: mod))
                    .padding()
                
                Spacer()
                
                Button("Indietro") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .navigationBarTitle("Risultati")
    }
}

struct Esercizio3: View {
    @State private var potenza = ""
    @State private var number = ""
    @State private var mod = ""
    @State private var showModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Congruenza:")
                    .font(.headline)
                
                TextField("Potenza", text: $potenza)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Numero", text: $number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Mod", text: $mod)
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
        .navigationTitle("RSA")
        .sheet(isPresented: $showModal) {
            // Passa i valori dei campi di testo alla vista modale
            ModalView2(potenza: Int(potenza) ?? 0, mod: Int(mod) ?? 0, number: Int(number) ?? 0)
        }
    }
}

struct Esercizio3View_Previews: PreviewProvider {
    static var previews: some View {
        Esercizio3()
    }
}
