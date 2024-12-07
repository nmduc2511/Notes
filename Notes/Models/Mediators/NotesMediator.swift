import Foundation

class NotesMediator {
    // MARK: - Variables
    private var groupedNotes: [NotesSectionType: [NoteModel]]
    private var folder: FolderModel
    var folderId: String {
        return folder.id
    }
    
    // MARK: - Init
    init(folder: FolderModel) {
        self.groupedNotes = [
            .today: [],
            .previous7Days: [],
            .previousMonths: []
        ]
        
        self.folder = folder
    }
    
    // MARK: - Method
    func configuration() {
        let calendar = Calendar.current
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let dateFormatter = DateFormatter()

        for note in folder.notes {
            if calendar.isDateInToday(note.createdDate) {
                let date = calendar.date(byAdding: .day, value: -1, to: note.createdDate)!
                dateFormatter.dateFormat = "HH:mm"
                note.displayDate = dateFormatter.string(from: date)
                groupedNotes[.today]?.append(note)
            } else if 
                let startOfWeek = calendar.date(byAdding: .day, value: -7, to: startOfToday),
                note.createdDate >= startOfWeek {
                let date = calendar.date(byAdding: .day, value: -6, to: note.createdDate)!
                dateFormatter.dateFormat = "EEEE" // Full day name (e.g., Monday)
                note.displayDate = dateFormatter.string(from: date)
                groupedNotes[.previous7Days]?.append(note)
            } else {
                let date = calendar.date(byAdding: .month, value: -1, to: note.createdDate)!
                dateFormatter.dateFormat = "dd/MM/yyyy"
                note.displayDate = dateFormatter.string(from: date)
                groupedNotes[.previousMonths]?.append(note)
            }
        }
        
        if groupedNotes[.today]?.isEmpty == true {
            groupedNotes[.today] = nil
        }
        
        if groupedNotes[.previous7Days]?.isEmpty == true {
            groupedNotes[.previous7Days] = nil
        }
        
        if groupedNotes[.previousMonths]?.isEmpty == true {
            groupedNotes[.previousMonths] = nil
        }
    }
    
    func update() {
        groupedNotes = [
            .today: [],
            .previous7Days: [],
            .previousMonths: []
        ]
        
        configuration()
    }
    
    // MARK: - UITableView
    func numberOfGroups() -> Int {
        return groupedNotes.count
    }
    
    func numberOfNotes(at section: Int) -> Int {
        let sectionType = sectionType(at: section)
        return groupedNotes[sectionType]?.count ?? 0
    }
    
    func note(at indexPath: IndexPath) -> NoteModel? {
        let sectionType = sectionType(at: indexPath.section)
        return groupedNotes[sectionType]?[indexPath.row]
    }
    
    func headerTitle(at section: Int) -> String {
        let sectionType = sectionType(at: section)
        return sectionType.rawValue
    }
    
    func deleteNote(at indexPath: IndexPath) {
        let sectionType = sectionType(at: indexPath.section)
        groupedNotes[sectionType]?.remove(at: indexPath.row)
        if groupedNotes[sectionType]?.isEmpty == true {
            groupedNotes[sectionType] = nil
        }
    }
    
    private func sectionType(at index: Int) -> NotesSectionType {
        let allSections = Array(groupedNotes.keys)
            .sorted { $0.rawValue < $1.rawValue }
        return allSections[index]
    }
}
