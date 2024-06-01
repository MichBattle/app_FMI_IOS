//
//  Score.swift
//  Fondamenti
//
//  Created by Michele Calliari on 30/05/24.
//
import SwiftUI

struct Score: View {
    @State private var textField1: String = ""
    @State private var textField2: String = ""
    @State private var isHamiltonian: Bool = false
    @State private var isDisconnected: Bool = false
    @State private var isDueConnesso: Bool = false
    @State private var isAlbero: Bool = false
    @State private var showModal: Bool = false
    @State private var calculationResult: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Group{
                Text("Primo score:")
                    .font(.headline)

                TextField("d1: x1,x2,...xn", text: $textField1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Group{
                Text("Secondo score:")
                    .font(.headline)
                
                TextField("d2: x1,x2,...xn", text: $textField2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Toggle(isOn: $isHamiltonian) {
                Text("Hamiltoniano")
            }
            .padding(.bottom, 10)

            Toggle(isOn: $isDisconnected) {
                Text("Sconnesso")
            }
            .padding(.bottom, 10)
            
            Toggle(isOn: $isDueConnesso) {
                Text("2-Connesso")
            }
            .padding(.bottom, 10)
            
            Toggle(isOn: $isAlbero) {
                Text("Albero")
            }
            .padding(.bottom, 10)

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    calculate()
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
        .navigationTitle("Score grafi")
        .sheet(isPresented: $showModal) {
            ModalView4(showModal: $showModal, result: $calculationResult)
        }
    }
    
    func verificaOstruzioni(vettore: [Int], nomeVettore: String) -> String {
        let n = vettore.count
        let maxVal = vettore.max()!
        let minVal = vettore.min()!

        if maxVal > n - 1 {
            return "\(nomeVettore) NO a causa dell'ostruzione 1"
        }

        if maxVal == n - 1 {
            if minVal < vettore.filter({ $0 == maxVal }).count {
                return "\(nomeVettore) NO a causa dell'ostruzione 2"
            }
        }

        if n > 2 {
            let L = vettore.dropLast(2).filter { $0 >= 2 }.count
            let K = vettore.suffix(2).reduce(0, +) - n
            if L < K {
                return "\(nomeVettore) NO a causa dell'ostruzione 3"
            }
        }

        let numDispari = vettore.filter { $0 % 2 != 0 }.count
        if numDispari % 2 != 0 {
            return "\(nomeVettore) NO a causa dell'ostruzione 4"
        }

        return "\(nomeVettore) SI"
    }

    func teoremaDelloScore(vettore: inout [Int]) -> String {
        var result = "TEOREMA DELLO SCORE\n"
        result += "\(vettore)\n"
        while vettore.max()! > 2 {
            let n = vettore.removeLast()
            for i in 1...n {
                vettore[vettore.count - i] -= 1
            }

            result += "\(vettore)\n"
            vettore.sort()
            result += "vettore ordinato: \n\(vettore)\n"
        }
        return result
    }

    func isDisconnected(graph: [[Int]]) -> Bool {
        return !isConnected(graph: graph)
    }

    func isConnected(graph: [[Int]]) -> Bool {
        var visited = [Bool](repeating: false, count: graph.count)
        var queue = [0]
        visited[0] = true
        while !queue.isEmpty {
            let node = queue.removeFirst()
            for neighbor in graph[node] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    queue.append(neighbor)
                }
            }
        }
        return visited.allSatisfy { $0 }
    }
    
    func stringToIntArray(_ input: String) -> [Int]? {
        let components = input.split(separator: ",")
        let intArray = components.compactMap { Int($0) }
        
        // Verifica se tutti i componenti sono stati convertiti con successo
        if intArray.count == components.count {
            return intArray
        } else {
            // Se c'è qualche componente che non è un numero intero, restituisce nil
            return nil
        }
    }

    func trovaGrafo(vettore: [Int], hamiltoniano: Bool, sconnesso: Bool, dueConnesso: Bool, albero: Bool) -> String {
        let n = vettore.count
        var graph = [[Int]](repeating: [Int](), count: n)

        for i in 0..<n {
            for j in i + 1..<n {
                if vettore[i] + vettore[j] >= n {
                    graph[i].append(j)
                    graph[j].append(i)
                }
            }
        }

        var result = ""
        if sconnesso {
            result += "Sconnesso " + (is_graph_disconnected(score: vettore) ? "SI" : "NO") + "\n"
        }
        if hamiltoniano {
            result += "Hamiltoniano " + (contains_hamiltonian_cycle(degree_sequence: vettore) ? "SI" : "NO") + "\n"
        }
        if dueConnesso {
            result += "2-Connesso " + (is_2_connected(degree_sequence: vettore) ? "SI" : "NO") + "\n"
        }
        if albero {
            result += "Albero " + (is_tree(degree_sequence: vettore) ? "SI" : "NO") + "\n"
        }
        
        return result
    }
    
    func main(d1: String, d2: String, hamiltoniano: Bool, sconnesso: Bool, dueConnesso: Bool, albero: Bool) -> String {
        let vettore1 = d1.split(separator: ",").compactMap { Int($0) }
        let vettore2 = d2.split(separator: ",").compactMap { Int($0) }
        
        var output = ""

        let result1 = verificaOstruzioni(vettore: vettore1, nomeVettore: "d1")
        let result2 = verificaOstruzioni(vettore: vettore2, nomeVettore: "d2")

        output += result1 + "\n" + result2 + "\n"

        var vettoreSopravvissuto: [Int]
        if !result1.contains("NO") {
            vettoreSopravvissuto = vettore1
        } else if !result2.contains("NO") {
            vettoreSopravvissuto = vettore2
        } else {
            return output.trimmingCharacters(in: .whitespacesAndNewlines)
        }

        var vettoreSopravvissutoCopy = vettoreSopravvissuto
        output += teoremaDelloScore(vettore: &vettoreSopravvissutoCopy)
        output += trovaGrafo(vettore: vettoreSopravvissuto, hamiltoniano: hamiltoniano, sconnesso: sconnesso, dueConnesso: dueConnesso, albero: albero)

        return output.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func calculate() {
        calculationResult = main(d1: textField1, d2: textField2, hamiltoniano: isHamiltonian, sconnesso: isDisconnected, dueConnesso: isDueConnesso, albero: isAlbero)
        showModal = true
    }
}

struct ModalView4: View {
    @Binding var showModal: Bool
    @Binding var result: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("")
                .font(.largeTitle)
                .padding(.bottom, 20)

            Text(result)
                .padding(.leading)
                .padding(.top)
                .padding(.trailing, 16)
                .padding(.bottom, 16)

            Spacer()

            HStack {
                Spacer()
                Button(action: {
                    showModal = false
                }) {
                    Text("Indietro")
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
    }
}

#Preview {
    Score()
}
