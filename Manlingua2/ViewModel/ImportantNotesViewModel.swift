//
//  ImportantNotesViewModel.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import Foundation

class ImportantNotesViewModel : ObservableObject {
    private var importantNotes: [ImportantNote] = [
        ImportantNote(title: "Perkenalan Nama", allowed: "Gunakan sapaan formal “您好” (Nín hǎo), perkenalkan diri dan posisi, ungkapkan minat kerjasama.", forbidden: "Jangan langsung pakai panggilan informal & masuk ke bisnis.", caution: "Perhatikan bahasa tubuh, jaga sikap tetap ramah."),
        ImportantNote(title: "Perkenalan Nama", allowed: "Gunakan sapaan formal “您好” (Nín hǎo), perkenalkan diri dan posisi, ungkapkan minat kerjasama.", forbidden: "Jangan langsung pakai panggilan informal & masuk ke bisnis.", caution: "Perhatikan bahasa tubuh, jaga sikap tetap ramah."),
        ImportantNote(title: "Perkenalan Nama", allowed: "Gunakan sapaan formal “您好” (Nín hǎo), perkenalkan diri dan posisi, ungkapkan minat kerjasama.", forbidden: "Jangan langsung pakai panggilan informal & masuk ke bisnis.", caution: "Perhatikan bahasa tubuh, jaga sikap tetap ramah.")
    ]
    
    public func getImportantNotes() -> [ImportantNote] {
        let storyProgress = UserDefaultSingleton.shared.latestStory - 1
        //return Array(importantNotes[0..<storyProgress])
        return Array(importantNotes[0..<1])

    }
}
