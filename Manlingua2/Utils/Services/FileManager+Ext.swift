//
//  FileManager+Ext.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 15/10/24.
//

import Foundation

extension FileManager {

    var documentsDirectory: URL {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to find user's documents directory")
        }
        return url
    }

    func urlInDocumentsDirectory(named: String) -> URL {
        return documentsDirectory.appendingPathComponent(named)
    }
}
