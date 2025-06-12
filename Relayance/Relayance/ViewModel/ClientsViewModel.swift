//
//  ClientsViewModel.swift
//  Relayance
//
//  Created by Alexandre Talatinian on 12/06/2025.
//

import Foundation

class ClientsViewModel: ObservableObject {
    @Published var clients: [Client] = []

    init() {
        clients = ModelData.chargement("Source.json")
    }

    func addClient(nom: String, email: String) -> Bool {
        guard isValidEmail(email) else { return false }
        let newClient = Client.creerNouveauClient(nom: nom, email: email)
        clients.append(newClient)
        return true
    }

    func deleteClient(_ client: Client) {
        clients.removeAll { $0 == client }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
