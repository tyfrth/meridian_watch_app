

import Foundation

let limit: Double = 25 * 60

let datesKey = "meridian.dates"

class UserStatus: ObservableObject {
    enum Status {
        case idle
        case countingDown
    }

    enum Page {
        case timer
        case list
    }

    @Published var dates: [Date] = [] {
        didSet {
            save()
        }
    }

    @Published var end = Date()
    var start: Date { end.addingTimeInterval(limit) }

    @Published var status: Status = .idle
    @Published var currentPage: Page = .timer

    /// Call when appDidFinishLaunching
    func load(_ dates: [Date]) {
        self.dates = dates
    }

    func save() {
        UserDefaults.standard.set(dates, forKey: datesKey)
    }
}
