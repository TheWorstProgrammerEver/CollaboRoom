
#if os(macOS)

import AppKit

extension NSImage {
    func resize(maxDimension: CGFloat) -> Data {
        resize(scale: maxDimension / max(size.height, size.width))
    }
    
    func resize(scale: CGFloat) -> Data {
        let newSize: NSSize = .init(width: size.width * scale, height: size.height * scale)
        let bitmapRep = NSBitmapImageRep(
            bitmapDataPlanes: nil,
            pixelsWide: Int(newSize.width),
            pixelsHigh: Int(newSize.height),
            bitsPerSample: 8,
            samplesPerPixel: 4,
            hasAlpha: true,
            isPlanar: false,
            colorSpaceName: .calibratedRGB,
            bytesPerRow: 0,
            bitsPerPixel: 0)!
        
            bitmapRep.size = newSize
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
            draw(in: NSRect(x: 0, y: 0, width: newSize.width, height: newSize.height), from: .zero, operation: .copy, fraction: 1.0)
            NSGraphicsContext.restoreGraphicsState()
            
        return bitmapRep.representation(using: .png, properties: [:])!
    }
}

#else

import UIKit

extension UIImage {
    func resize(maxDimension: CGFloat) -> Data {
        resize(scale: maxDimension / max(size.height, size.width))
    }
    
    func resize(scale: CGFloat) -> Data {
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.jpegData(withCompressionQuality: 1.0) { context in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
#endif
