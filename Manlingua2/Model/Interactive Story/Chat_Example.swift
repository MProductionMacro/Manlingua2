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
struct Chat: Codable, Identifiable, Hashable {
   public let id: Int
   public let speaker: String
   public let pinyin: String
   public let hanzi: String
   public let meaning: String
   public let choice: [String]?
   public let answer: String?
   public let question: String?
   public let type: ChatType
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

