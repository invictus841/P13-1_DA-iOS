//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
    @StateObject var viewModel = ClientsViewModel()
    @State private var showModal: Bool = false

    var body: some View {
        NavigationStack {
            List(viewModel.clients, id: \.self) { client in
                NavigationLink {
                    DetailClientView(client: client, viewModel: viewModel)
                } label: {
                    Text(client.nom)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AjoutClientView(viewModel: viewModel, dismissModal: $showModal)
            })
        }
    }
}

#Preview {
    ListClientsView()
}
