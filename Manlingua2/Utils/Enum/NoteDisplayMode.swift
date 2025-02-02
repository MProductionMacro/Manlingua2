enum NoteDisplayMode: Equatable, Hashable {
    case favorite
    case subChapter(storyId: Int, subChapterId: Int)
}
