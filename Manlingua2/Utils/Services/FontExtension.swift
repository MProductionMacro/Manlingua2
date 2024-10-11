//
//  FontExtension.swift
//  Manlingua2
//
//  Created by Paulus Michael on 07/10/24.
//

import SwiftUI

extension Font {
    // New Font Design System
    public static func heavy48() -> Font{
        return .system(size: 48, weight: .heavy)
    }
    
    public static func bold48() -> Font{
        return .system(size: 48, weight: .bold)
    }
    
    public static func medium48() -> Font{
        return .system(size: 48, weight: .medium)
    }
    
    public static func normal48() -> Font{
        return .system(size: 48, weight: .regular)
    }
    
    public static func heavy40() -> Font{
        return .system(size: 40, weight: .heavy)
    }
    
    public static func bold40() -> Font{
        return .system(size: 40, weight: .bold)
    }
    
    public static func medium40() -> Font{
        return .system(size: 40, weight: .medium)
    }
    
    public static func normal40() -> Font{
        return .system(size: 40, weight: .regular)
    }
    
    public static func heavy32() -> Font{
        return .system(size: 32, weight: .heavy)
    }
    
    public static func bold32() -> Font{
        return .system(size: 32, weight: .bold)
    }
    
    public static func medium32() -> Font{
        return .system(size: 32, weight: .medium)
    }
    
    public static func normal32() -> Font{
        return .system(size: 32, weight: .regular)
    }
    
    public static func heavy24() -> Font{
        return .system(size: 24, weight: .heavy)
    }
    
    public static func bold24() -> Font{
        return .system(size: 24, weight: .bold)
    }
    
    public static func medium24() -> Font{
        return .system(size: 24, weight: .medium)
    }
    
    public static func normal24() -> Font{
        return .system(size: 24, weight: .regular)
    }
    
    public static func heavy20() -> Font{
        return .system(size: 20, weight: .heavy)
    }
    
    public static func bold20() -> Font{
        return .system(size: 20, weight: .bold)
    }
    
    public static func medium20() -> Font{
        return .system(size: 20, weight: .medium)
    }
    
    public static func normal20() -> Font{
        return .system(size: 20, weight: .regular)
    }
    
    public static func heavy16() -> Font{
        return .system(size: 16, weight: .heavy)
    }
    
    public static func bold16() -> Font{
        return .system(size: 16, weight: .bold)
    }
    
    public static func medium16() -> Font{
        return .system(size: 16, weight: .medium)
    }
    
    public static func normal16() -> Font{
        return .system(size: 16, weight: .regular)
    }
    
    public static func heavy12() -> Font{
        return .system(size: 12, weight: .heavy)
    }
    
    public static func bold12() -> Font{
        return .system(size: 12, weight: .bold)
    }
    
    public static func medium12() -> Font{
        return .system(size: 12, weight: .medium)
    }
    
    public static func normal12() -> Font{
        return .system(size: 12, weight: .regular)
    }
    
    
    // Old Font Design System
    // Soon will be deleted
    // Tapi takut ada page lain yang masih pake, jadi sementara dibiarin dulu
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
