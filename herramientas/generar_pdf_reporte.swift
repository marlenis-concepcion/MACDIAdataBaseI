import Foundation
import AppKit
import CoreText

let baseDir = "/Users/vampy/Documents/UASD/proyecto finakl"
let inputPath = baseDir + "/documento/Proyecto_Final_Banco_Agricola.md"
let outputPath = baseDir + "/documento/Proyecto_Final_Banco_Agricola.pdf"

let pageWidth: CGFloat = 612
let pageHeight: CGFloat = 792
let marginLeft: CGFloat = 58
let marginRight: CGFloat = 58
let marginTop: CGFloat = 62
let marginBottom: CGFloat = 58
let contentWidth = pageWidth - marginLeft - marginRight

func font(_ name: String, _ size: CGFloat) -> NSFont {
    if let f = NSFont(name: name, size: size) { return f }
    return NSFont.systemFont(ofSize: size)
}

let titleFont = font("Helvetica-Bold", 19)
let h2Font = font("Helvetica-Bold", 14)
let h3Font = font("Helvetica-Bold", 12)
let bodyFont = font("Times New Roman", 11.2)
let bulletFont = font("Times New Roman", 11.2)
let monoFont = font("Menlo", 8.4)
let smallFont = font("Helvetica", 8.8)

func attrs(_ f: NSFont, _ color: NSColor = .black) -> [NSAttributedString.Key: Any] {
    [.font: f, .foregroundColor: color]
}

func measure(_ text: String, _ f: NSFont) -> CGFloat {
    (text as NSString).size(withAttributes: attrs(f)).width
}

func wrap(_ text: String, font f: NSFont, width: CGFloat) -> [String] {
    let clean = text.trimmingCharacters(in: .whitespacesAndNewlines)
    if clean.isEmpty { return [""] }
    var lines: [String] = []
    for paragraph in clean.components(separatedBy: "\n") {
        var current = ""
        for rawWord in paragraph.split(separator: " ") {
            let word = String(rawWord)
            let candidate = current.isEmpty ? word : current + " " + word
            if measure(candidate, f) <= width {
                current = candidate
            } else {
                if !current.isEmpty { lines.append(current) }
                current = word
            }
        }
        if !current.isEmpty { lines.append(current) }
    }
    return lines
}

func wrapCode(_ text: String, width: CGFloat) -> [String] {
    if text.isEmpty { return [""] }
    var lines: [String] = []
    var current = ""
    for ch in text {
        let candidate = current + String(ch)
        if measure(candidate, monoFont) <= width {
            current = candidate
        } else {
            lines.append(current)
            current = String(ch)
        }
    }
    if !current.isEmpty { lines.append(current) }
    return lines
}

let outputURL = URL(fileURLWithPath: outputPath)
var mediaBox = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
guard let consumer = CGDataConsumer(url: outputURL as CFURL),
      let context = CGContext(consumer: consumer, mediaBox: &mediaBox, nil) else {
    fatalError("No se pudo crear el PDF")
}

var currentY: CGFloat = marginTop
var pageNumber = 0
var pageOpen = false

func drawLine(_ text: String, x: CGFloat, y: CGFloat, f: NSFont, color: NSColor = .black) {
    let line = CTLineCreateWithAttributedString(NSAttributedString(string: text, attributes: attrs(f, color)))
    context.textPosition = CGPoint(x: x, y: pageHeight - y - f.ascender)
    CTLineDraw(line, context)
}

func beginPage() {
    context.beginPDFPage(nil)
    pageNumber += 1
    currentY = marginTop
    pageOpen = true
    drawLine("Proyecto Final - Banco Agricola RD", x: marginLeft, y: 28, f: smallFont, color: NSColor(calibratedWhite: 0.35, alpha: 1))
    drawLine("Pagina \(pageNumber)", x: pageWidth - marginRight - 54, y: pageHeight - 30, f: smallFont, color: NSColor(calibratedWhite: 0.35, alpha: 1))
}

func ensure(_ needed: CGFloat) {
    if !pageOpen { beginPage() }
    if currentY + needed > pageHeight - marginBottom {
        context.endPDFPage()
        beginPage()
    }
}

func renderText(_ text: String, f: NSFont, indent: CGFloat = 0, spacing: CGFloat = 4, color: NSColor = .black) {
    let lines = wrap(text, font: f, width: contentWidth - indent)
    ensure(CGFloat(lines.count) * (f.pointSize + 3) + spacing)
    for line in lines {
        drawLine(line, x: marginLeft + indent, y: currentY, f: f, color: color)
        currentY += f.pointSize + 3
    }
    currentY += spacing
}

func renderCode(_ text: String) {
    let lines = wrapCode(text, width: contentWidth)
    ensure(CGFloat(lines.count) * (monoFont.pointSize + 3) + 4)
    for line in lines {
        drawLine(line, x: marginLeft, y: currentY, f: monoFont, color: NSColor(calibratedWhite: 0.12, alpha: 1))
        currentY += monoFont.pointSize + 3
    }
    currentY += 2
}

let md = try String(contentsOfFile: inputPath, encoding: .utf8)
var inCode = false

for rawLine in md.components(separatedBy: .newlines) {
    let line = rawLine.trimmingCharacters(in: .whitespaces)
    if line.hasPrefix("```") {
        inCode.toggle()
        currentY += 3
        continue
    }
    if inCode {
        renderCode(rawLine)
        continue
    }
    if line.isEmpty {
        currentY += 6
        continue
    }
    if line == "---" {
        currentY += 8
        continue
    }
    if line.hasPrefix("# ") {
        ensure(34)
        renderText(String(line.dropFirst(2)), f: titleFont, spacing: 10, color: NSColor(calibratedRed: 0.12, green: 0.34, blue: 0.24, alpha: 1))
    } else if line.hasPrefix("## ") {
        ensure(30)
        currentY += 4
        renderText(String(line.dropFirst(3)), f: h2Font, spacing: 6, color: NSColor(calibratedRed: 0.12, green: 0.34, blue: 0.24, alpha: 1))
    } else if line.hasPrefix("### ") {
        ensure(24)
        renderText(String(line.dropFirst(4)), f: h3Font, spacing: 4)
    } else if line.hasPrefix("- ") {
        renderText("• " + String(line.dropFirst(2)), f: bulletFont, indent: 12, spacing: 1)
    } else if line.hasPrefix("|") {
        renderCode(line)
    } else {
        renderText(line, f: bodyFont, spacing: 5)
    }
}

if pageOpen {
    context.endPDFPage()
}
context.closePDF()
