import Foundation

extension DispatchQueue {
    static func asyncMain(execute work: @escaping () -> Void) {
        DispatchQueue.main.async(execute: work)
    }
}
