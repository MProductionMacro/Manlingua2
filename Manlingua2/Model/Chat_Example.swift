//
//  Chat_Example.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import Foundation

/// Struktur `Chat_Example` mematuhi protokol `Codable` dan `Identifiable`, dan dipisahkan dari struktur `Subchapter`
/// karena JSON untuk Story dan Chat disimpan secara terpisah.
///
/// Chat dapat berupa pernyataan biasa atau perintah aktivitas yang harus dilakukan oleh pengguna.
///
/// - Properti:
///   - `id`: Pengidentifikasi unik untuk entri chat.
///   - `speaker`: Nama pembicara dalam chat.
///   - `pinyin`: Representasi Pinyin dari teks Hanzi.
///   - `hanzi`: Teks Hanzi yang digunakan dalam chat.
///   - `meaning`: Makna atau terjemahan dari teks Hanzi.
///   - `speaking`: Properti opsional yang menyimpan jenis aktivitas berbicara yang harus dilakukan oleh pengguna
///     (jika chat bersifat perintah aktivitas berbicara).
///   - `choice`: Properti opsional yang menyimpan pilihan yang harus dipilih oleh pengguna
///     (jika chat bersifat soal pilihan ganda).
///   - `answer`: Properti opsional yang berisi jawaban untuk soal pilihan ganda yang diberikan melalui array `choice`.
struct Chat_Example: Codable, Identifiable, Hashable {
   let id: Int
   let speaker: String
   let pinyin: String
   let hanzi: String
   let meaning: String
   let choice: [String]?
   let answer: String?
   let question: String?
   let type: ChatType
   
   enum CodingKeys: String, CodingKey {
      case id
      case speaker
      case pinyin
      case hanzi
      case meaning
      case choice
      case answer
      case question
      case type
   }
}

enum ChatType: String, Codable {
   case speaker1
   case speaker2
   case question
}


/// Terdapat 2 jenis aktivitas speaking yang dapat dilakukan oleh user
/// - Case :
///   - `repeating`: aktivitas speaking ketika user diminta untuk mengulangi sebuah kalimat
///             bahasa Mandarin.
///   - `translate`: aktivitas speaking ketika user diminta untuk mentranslate sebuah kalimat ke
///             dalam bahasa Mandarin.

