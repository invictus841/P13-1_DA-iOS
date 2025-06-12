//
//  ClientIntegrationTests.swift
//  RelayanceTests
//
//  Created by Alexandre Talatinian on 12/06/2025.
//

import XCTest
@testable import Relayance

final class ClientIntegrationTests: XCTestCase {

    func testAddClientWithValidDataAddsClientToList() {
        // Given
        let viewModel = ClientsViewModel()
        let initialCount = viewModel.clients.count

        // When
        let success = viewModel.addClient(nom: "Alan Turing", email: "alan.turing@example.com")

        // Then
        XCTAssertTrue(success)
        XCTAssertEqual(viewModel.clients.count, initialCount + 1)
    }

    func testAddClientWithInvalidEmailDoesNotAddClient() {
        // Given
        let viewModel = ClientsViewModel()
        let initialCount = viewModel.clients.count

        // When
        let success = viewModel.addClient(nom: "Fake", email: "invalid-email")

        // Then
        XCTAssertFalse(success)
        XCTAssertEqual(viewModel.clients.count, initialCount)
    }
    
    func testDeleteClientRemovesClientFromList() {
        // Given
        let viewModel = ClientsViewModel()
        let client = Client.creerNouveauClient(nom: "To Delete", email: "delete@example.com")
        viewModel.clients.append(client)
        let countBefore = viewModel.clients.count

        // When
        viewModel.deleteClient(client)

        // Then
        XCTAssertEqual(viewModel.clients.count, countBefore - 1)
        XCTAssertFalse(viewModel.clients.contains(client))
    }
}
