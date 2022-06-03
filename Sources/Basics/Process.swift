//
//  File.swift
//  
//
//  Created by Alex Ivashko on 02.06.2022.
//

import Foundation
import TSCBasic

extension TSCBasic.Process {
    /// Execute a subprocess and calls completion block when it finishes execution
    ///
    /// - Parameters:
    ///   - arguments: The arguments for the subprocess.
    ///   - environment: The environment to pass to subprocess. By default the current process environment
    ///     will be inherited.
    ///   - loggingHandler: Handler for logging messages
    ///   - queue: Queue to use for callbacks
    ///   - completion: A completion handler to return the process result
    @available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
    static public func popen(
        arguments: [String],
        environment: [String: String] = ProcessEnv.vars,
        loggingHandler: TSCBasic.Process.LoggingHandler? = .none
    ) throws -> Task<ProcessResult, Swift.Error> {
        let process = TSCBasic.Process(
            arguments: arguments,
            environment: environment,
            outputRedirection: .collect,
            loggingHandler: loggingHandler
        )
        try process.launch()
        return Task {
            return try process.waitUntilExit()
        }
    }
    
}

