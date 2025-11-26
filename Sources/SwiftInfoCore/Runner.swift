import Foundation

public enum Runner {
    public static func getCoreSwiftCArguments(fileUtils: FileUtils,
                                              toolchainPath: String,
                                              processInfoArgs: [String]) -> [String] {
        let include = fileUtils.toolFolder + "/../include/swiftinfo"
        var args = [
            "swiftc",
            "--driver-mode=swift", // Don't generate a binary, just run directly.
            "-L", // Link with SwiftInfoCore manually.
            include,
            "-I",
            include,
            "-lSwiftInfoCore",
            "-Xcc",
            "-fmodule-map-file=\(include)/Csourcekitd/include/module.modulemap",
            "-I",
            "\(include)/Csourcekitd/include",
            (try! fileUtils.infofileFolder()) + "Infofile.swift",
        ]
        
        // For Swift 6+, we use the new driver which supports the toolchain path differently
        // Only add -toolchain flag if using legacy driver (Swift < 5.5)
        #if swift(<5.5)
        args += [
            "-toolchain",
            "\(toolchainPath)",
        ]
        #endif
        
        return args + Array(processInfoArgs.dropFirst()) // Route SwiftInfo args to the sub process
    }
}
