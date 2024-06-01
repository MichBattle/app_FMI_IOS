//
//  CongruencesSystem.swift
//  Fondamenti
//
//  Created by Michele Calliari on 11/05/24.
//
import SwiftUI
import Foundation

/**
 * Calculates the GCD using the Euclidean algorithm with backward substitution.
 *
 * - Parameters:
 *   - a: The first integer.
 *   - b: The second integer.
 * - Returns: A string describing the steps to calculate the GCD.
 */
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

/**
 * Solves the given system of congruences.
 *
 * - Parameters:
 *   - a: The first number.
 *   - k: The modulus for the first congruence.
 *   - b: The second number.
 *   - j: The modulus for the second congruence.
 * - Returns: A string describing the solution to the system of congruences.
 */
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

/**
 * Returns the GCD and the two coefficients for the linear combination.
 *
 * - Parameters:
 *   - a: The first integer.
 *   - b: The second integer.
 * - Returns: A tuple containing the GCD and the coefficients.
 */
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

/**
 * Calculates the GCD normally.
 *
 * - Parameters:
 *   - a: The first integer.
 *   - b: The second integer.
 * - Returns: The GCD of the two integers.
 */
func mcd(_ a: Int, _ b: Int) -> Int {
    var (a, b) = (a, b)
    while b != 0 {
        (a, b) = (b, a % b)
    }
    return a
}

/**
 * Calculates the LCM.
 *
 * - Parameters:
 *   - a: The first integer.
 *   - b: The second integer.
 * - Returns: The LCM of the two integers.
 */
func mcm(_ a: Int, _ b: Int) -> Int {
    return (a * b) / mcd(a, b)
}

/**
 * Executes the exercise.
 *
 * - Parameters:
 *   - xNumber: The first number.
 *   - xMod: The modulus for the first number.
 *   - yNumber: The second number.
 *   - yMod: The modulus for the second number.
 * - Returns: A Text view with the result of the calculations.
 */
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

/**
 * Modal view for displaying the content of the text fields.
 */
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
                // Closes the modal view
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

/**
 * Main view for the "CongruencesSystem" section.
 */
struct CongruencesSystem: View {
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
            
            Spacer() // Spacer to push the button down
            
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
            // Pass the values from the text fields to the modal view
            ModalView6(xNumber: Int(xNumber) ?? 0, xMod: Int(xMod) ?? 0, yNumber: Int(yNumber) ?? 0, yMod: Int(yMod) ?? 0)
        }
    }
}

/**
 * Preview provider for "CongruencesSystem".
 */
struct CongruencesSystemView_Previews: PreviewProvider {
    static var previews: some View {
        CongruencesSystem()
    }
}
