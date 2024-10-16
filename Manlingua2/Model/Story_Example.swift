//
//  Story_Example.swift
//  TE_JSON_Real
//
//  Created by Arrick Russell Adinoto on 30/09/24.
//

import Foundation

//struct Story_Example and SubChapter_Example hasn't been finalize yet.

/// Struktur `Story_Example` mematuhi protokol `Codable` dan `Identifiable`, dan dipisahkan dari struktur `Subchapter`
/// karena JSON untuk Story dan Chat disimpan secara terpisah.
///
/// Chat dapat berupa pernyataan biasa atau perintah aktivitas yang harus dilakukan oleh pengguna.
///
/// - Properti:
///   - `id`: Pengidentifikasi unik untuk story
///   - `number` : Menunjukkan urutan dari story, seperti story ke-1, ke-2, dan seterusnya.
///   - `title` : Judul untuk story tersebut
///   - `hanzi`: Judul untuk story dalam bentuk hanzi
///   - `description`: Properti yang berisikan kata - kata pengantar untuk story tersebut
///     (jika chat bersifat soal pilihan ganda).
///   - `pinyin`: Judul untuk story dalam bentuk pinyin
///   - `subChapter` : Properti yang berisikan tentang seluruh subChapter untuk story tersebut

struct Story_Example: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let hanzi: String
    let introduction: String
    let pinyin: String
    let subChapter: [SubChapter_Example]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case hanzi
        case introduction
        case pinyin
        case subChapter
    }
}

struct SubChapter_Example: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let pinyin: String
    let hanzi: String
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case pinyin
        case hanzi
        case duration
    }
}

