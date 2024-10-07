//
//  FontExtension.swift
//  Manlingua2
//
//  Created by Paulus Michael on 07/10/24.
//

import SwiftUI

extension Font {
   public static func judulBesar() -> Font {
      return .system(size: 40, weight: .heavy)
   }
   
   public static func judulBiasa() -> Font {
      return .system(size: 20, weight: .semibold)
   }
   
   public static func subJudul() -> Font {
      return .system(size: 16, weight: .semibold)
   }
   
   public static func normalText() -> Font {
      return .system(size: 14, weight: .regular)
   }
   
   public static func button() -> Font {
      return .system(size: 20, weight: .semibold)
   }
   
   public static func bpmf() -> Font {
      return .system(size: 24, weight: .regular)
   }
   
   public static func hanzi() -> Font {
      return .system(size: 16, weight: .regular)
   }
   
   public static func pinyin() -> Font {
      return .system(size: 11, weight: .regular)
   }
}
