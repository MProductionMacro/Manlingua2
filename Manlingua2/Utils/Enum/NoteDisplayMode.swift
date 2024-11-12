//
//  NoteDisplayMode.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/11/24.
//

enum NoteDisplayMode: Equatable, Hashable {
    case favorite
    case subChapter(storyId: Int, subChapterId: Int)
}
