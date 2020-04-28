//
//  TaskPersistence.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/28/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import Foundation

struct OutstandingHelper {
    static let manager = OutstandingHelper()

    func save(newFavorite: Outstanding) throws {
        try persistenceManager.save(newElement: newFavorite)
    }

    func getFavorites() throws -> [Outstanding] {
        return try persistenceManager.getObjects()
    }
    
    //TODO: - Build out delete functionality
    func deleteFavorite(withID: String) throws {
        do {
            let favorites = try getFavorites()
            let newFavorites = favorites.filter { $0.name != withID}
            try persistenceManager.replace(elements: newFavorites)
        }
    }

    private let persistenceManager = PersistenceManager<Outstanding>(fileName: "outstanding.plist")

    private init() {}
}

struct CompletedHelper {
    static let manager = CompletedHelper()

    func save(newFavorite: Completed) throws {
        try persistenceManager.save(newElement: newFavorite)
    }

    func getFavorites() throws -> [Completed] {
        return try persistenceManager.getObjects()
    }
    
    //TODO: - Build out delete functionality
    func deleteFavorite(withID: String) throws {
        do {
            let favorites = try getFavorites()
            let newFavorites = favorites.filter { $0.name != withID}
            try persistenceManager.replace(elements: newFavorites)
        }
    }

    private let persistenceManager = PersistenceManager<Completed>(fileName: "completed.plist")

    private init() {}
}
