//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by Alexandre Talatinian on 12/06/2025.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {

    func testClientInitWithValidData() {
        // Given
        let nom = "Marie Curie"
        let email = "marie.curie@example.com"
        let dateCreationString = "2023-02-20T09:15:00Z"
        
        // When
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        // Then
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertEqual(client.formatDateVersString(), "20-02-2023", "La date devrait être formatée en dd-MM-yyyy")
        XCTAssertEqual(Calendar.current.component(.year, from: client.dateCreation), 2023)
    }
    
    func testClientInitWithInvalidDate() {
        // Given
        let client = Client(nom: "Fake", email: "fake@example.com", dateCreationString: "invalid-date")

        // Then
        XCTAssertNotNil(client.dateCreation)
    }
    
    func testCreerNouveauClientSetsCorrectValues() {
        // Given
        let nom = "Albert Einstein"
        let email = "albert@example.com"

        // When
        let client = Client.creerNouveauClient(nom: nom, email: email)

        // Then
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertTrue(client.estNouveauClient(), "Le client vient d'être créé donc il devrait être nouveau.")
    }
    
    func testEstNouveauClientWhenClientIsNew() {
        let client = Client.creerNouveauClient(nom: "Test", email: "test@example.com")
        XCTAssertTrue(client.estNouveauClient())
    }
    
    func testEstNouveauClientWhenClientIsOld() {
        let oldClient = Client(nom: "Old", email: "old@example.com", dateCreationString: "2020-01-01T00:00:00Z")
        XCTAssertFalse(oldClient.estNouveauClient())
    }
    
    func testClientExisteReturnsTrueIfClientIsInList() {
        let client = Client(nom: "Ada", email: "ada@example.com", dateCreationString: "2023-04-01T00:00:00Z")
        let list = [client]
        XCTAssertTrue(client.clientExiste(clientsList: list))
    }

    func testClientExisteReturnsFalseIfClientNotInList() {
        let client = Client(nom: "Ada", email: "ada@example.com", dateCreationString: "2023-04-01T00:00:00Z")
        let list: [Client] = []
        XCTAssertFalse(client.clientExiste(clientsList: list))
    }
    
    func testFormatDateVersStringReturnsFormattedDate() {
        let client = Client(nom: "Turing", email: "turing@example.com", dateCreationString: "2023-05-10T00:00:00Z")
        XCTAssertEqual(client.formatDateVersString(), "10-05-2023")
    }
    
    func testFormatDateVersStringReturnsTodayForInvalidDateInput() {
        let invalidDate = "bad-format"
        let client = Client(nom: "Glitch", email: "glitch@example.com", dateCreationString: invalidDate)

        let expectedDateString = Date.stringFromDate(Date())!

        XCTAssertEqual(client.formatDateVersString(), expectedDateString)
    }
    
    func testChargementParsesJSONSuccessfully() {
        let clients: [Client] = ModelData.chargement("Source.json")
        XCTAssertFalse(clients.isEmpty)
        XCTAssertEqual(clients[0].nom, "Frida Kahlo")
    }
}

