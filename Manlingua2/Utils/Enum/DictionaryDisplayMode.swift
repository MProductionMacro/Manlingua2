enum DictionaryDisplayMode: Equatable, Hashable {
   case favorite(isFromHome: Bool)
   case story(id: Int)
}
