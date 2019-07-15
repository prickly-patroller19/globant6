import Foundation

extension String {
    func ident(identation spaces: Int) -> String {
        var identedString = ""
        for _ in 0..<spaces {
            identedString.append(" ")
        }
        return identedString + self
    }
}
