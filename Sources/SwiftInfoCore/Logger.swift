import Foundation

func args() -> [String] {
    return ProcessInfo.processInfo.arguments
}

public let isInVerboseMode = args().contains("-v") || args().contains("--verbose")
public let isInSilentMode = args().contains("-s") || args().contains("--silent")
public let isInPullRequestMode = args().contains("--pullRequest")
public let printSourceKitQueries = args().contains("-p") || args().contains("--print-sourcekit")

public func log(_ message: String, verbose: Bool = false, sourceKit: Bool = false, hasPrefix: Bool = true) {
    guard isInSilentMode == false else {
        return
    }
    guard (sourceKit && printSourceKitQueries) || verbose == false || isInVerboseMode else {
        return
    }
    print("\(hasPrefix ? "* " : "")\(message)")
}
