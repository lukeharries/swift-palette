//
//  PaletteGenerator.swift
//  paletteGenerator
//
//  Created by Luke Harries on 5/04/17.
//  Copyright © 2017 Luke Harries. All rights reserved.
//

import Foundation

enum PaletteError: Error {
    case invalidInputFile
    case jsonParseError
    case other(message: String)
}

class PaletteGenerator {
    
    func run() {
        let commandLine = CommandLine()
        let inputFilePath = StringOption("i", "input", true, "Path to the input file")
        let outputFilePath = StringOption("o", "output", true, "Path to the output file")
        
        commandLine.addOptions(inputFilePath, outputFilePath)
        
        do {
            try commandLine.parse()
        } catch {
            commandLine.printUsage(error)
            exit(EX_USAGE)
        }
        
        do {
            try generatePalette(inputPath: inputFilePath.value!, outputPath: outputFilePath.value!)
        } catch {
            handleError(error: error)
        }
    }
    
    func generatePalette(inputPath: String, outputPath: String) throws {
        print("Input path: \(inputPath)")
        print("Output path: \(outputPath)")

        guard let data = try? readContentsOfFile(filePath: inputPath) else {
            throw PaletteError.invalidInputFile
        }

        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw PaletteError.jsonParseError
        }
        
        let palette = Palette(json: json!)
        
        dump(palette)
    }
    
    func readContentsOfFile(filePath : String) throws -> Data {
        do {
            return try Data(contentsOf: URL(fileURLWithPath: filePath), options: Data.ReadingOptions.mappedIfSafe)
        } catch {
            throw PaletteError.invalidInputFile
        }
    }
    
    func handleError(error: Error) {
        switch error as! PaletteError {
        case .invalidInputFile:
            print("Invalid input file.")
            exit(EX_IOERR)
        default:
            print("Something went wrong")
            exit(EXIT_FAILURE)
        }
    }

}
