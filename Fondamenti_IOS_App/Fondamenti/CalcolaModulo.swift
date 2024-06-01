//
//  Esercizio2.swift
//  Fondamenti
//
//  Created by Michele Calliari on 11/05/24.
//
import SwiftUI

struct CalcolaModulo: View {
    @State private var number = ""
    @State private var mod = ""
    @State private var result = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Modulo:")
                    .font(.headline)
                
                TextField("Numero", text: $number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Mod", text: $mod)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(result)
                    .padding(.top, 8) // Spazio tra i TextField e il risultato
            }
            
            Spacer() // Spacer per spingere il bottone in basso
            
            HStack {
                Spacer()
                Button(action: {
                    // Calcola il modulo e aggiorna il risultato
                    let num = evaluateExpression(expression: number)
                    let modValue = Int(mod) ?? 1
                    let modulo = num % modValue
                    let quoziente = num / modValue
                    result = "\(number) mod \(mod) = \(modValue)*\(quoziente) + \(modulo)"
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
        .navigationTitle("Calcola Modulo")
    }
    
    // Funzione per valutare l'espressione matematica
    private func evaluateExpression(expression: String) -> Int {
        var cleanedExpression = expression.replacingOccurrences(of: "^", with: "**") // Aggiorna l'operatore di potenza
        cleanedExpression = cleanedExpression.replacingOccurrences(of: " ", with: "") // Rimuovi gli spazi
        
        // Usa il NSExpression per valutare l'espressione
        let expressionToEvaluate = NSExpression(format: cleanedExpression)
        guard let evaluatedValue = expressionToEvaluate.expressionValue(with: nil, context: nil) as? Int else {
            return 0
        }
        return evaluatedValue
    }
}

struct CalcolaModuloView_Previews: PreviewProvider {
    static var previews: some View {
        CalcolaModulo()
    }
}
