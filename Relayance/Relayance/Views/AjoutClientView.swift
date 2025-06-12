//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AjoutClientView: View {
    @ObservedObject var viewModel: ClientsViewModel
    @Binding var dismissModal: Bool
    @State var nom: String = ""
    @State var email: String = ""
    @State var showError = false

    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            TextField("Nom", text: $nom)
                .font(.title2)
            TextField("Email", text: $email)
                .font(.title2)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            if showError {
                Text("Adresse email invalide.")
                    .foregroundColor(.red)
            }
            Button("Ajouter") {
                let success = viewModel.addClient(nom: nom, email: email)
                if success {
                    dismissModal.toggle()
                } else {
                    showError = true
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            .foregroundStyle(.white)
            .padding(.top, 50)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AjoutClientView(viewModel: ClientsViewModel(), dismissModal: .constant(false))
}

