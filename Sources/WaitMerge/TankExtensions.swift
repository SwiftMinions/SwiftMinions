//
//  TankExtensions.swift
//  SwiftMinions
//
//  Created by 郭景豪 on 2020/2/23.
//  Copyright © 2020 SwiftMinions. All rights reserved.
//

import UIKit
import CommonCrypto
import MapKit
   

extension BinaryInteger {
    /**
     Check even
     
     ### Chinese description
     檢查是否為偶數
     
     ## Usage Example: ##
     ````
     2.isEven //true
     ````
     */
    var isEven: Bool { return self % 2 == 0 }
}

extension Array {
    
    /**
     Get element from array first to reduce default value
     
     ### Chinese description
     從 Array 取第一個 element 當預設值
     
     ## Usage Example: ##
     ````
     [1, 2, 3, 4].reduce(+)// Optional(10)
     ````
     - Parameter nextPartialResult
     A closure that combines an accumulating value and an element of the sequence into a new accumulating value, to be used in the next call of the nextPartialResult closure or returned to the caller.
     - Returns: The final accumulated value. If the sequence has no elements, the result is initialResult.
     */
    func reduce(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        guard let first = first else { return nil }
        return dropFirst().reduce(first, nextPartialResult)
    }
}


// 以下保留，不確定要不要
extension String {
    func toData() -> Data? {
        let data = self.data(using: .utf8)
        return data
    }
}

extension Double {

    func distanceToString() -> String {
        return self > 0 ? self > 1 ? String(format : "%.2f km",self) : String(format : "%.2f m",(self * 1000)) : ""
    }
    
}
// 以上保留，不確定要不要

// 以下太艱深，看不懂，無法寫註解
extension MKMapRect: Equatable {

    public static func == (a: MKMapRect, b: MKMapRect) -> Bool {
        return MKMapRectEqualToRect(a, b)
    }
}

extension MKCoordinateSpan: Equatable {

    public static func == (a: MKCoordinateSpan, b: MKCoordinateSpan) -> Bool {
        return a.latitudeDelta == b.latitudeDelta && a.longitudeDelta == b.longitudeDelta
    }
}

extension MKMapSnapshotter.Options {

    open override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? MKMapSnapshotter.Options else {
            return false
        }

        if object === self {
            return true
        }

        #if os(iOS)
            return camera == object.camera
                && mapRect == object.mapRect
                && mapType == object.mapType
                && region == object.region
                && scale == object.scale
                && showsBuildings == object.showsBuildings
                && showsPointsOfInterest == object.showsPointsOfInterest
                && size == object.size
        #else
            return camera == object.camera
                && mapRect == object.mapRect
                && mapType == object.mapType
                && region == object.region
                && showsBuildings == object.showsBuildings
                && showsPointsOfInterest == object.showsPointsOfInterest
                && size == object.size
        #endif
    }
}

public extension MKCoordinateRegion {


    init(north: CLLocationDegrees, east: CLLocationDegrees, south: CLLocationDegrees, west: CLLocationDegrees) {
        let span = MKCoordinateSpan(latitudeDelta: north - south, longitudeDelta: east - west)
        let center = CLLocationCoordinate2D(latitude: north - (span.latitudeDelta / 2), longitude: west + (span.longitudeDelta / 2))

        self.init(
            center: center,
            span:   span
        )
    }


    init? <Coordinates: Sequence> (fittingCoordinates coordinates: Coordinates) where Coordinates.Iterator.Element == CLLocationCoordinate2D {
        var minLatitude = CLLocationDegrees(90)
        var maxLatitude = CLLocationDegrees(-90)
        var minLongitude = CLLocationDegrees(180)
        var maxLongitude = CLLocationDegrees(-180)

        var hasCoordinates = false
        for coordinate in coordinates {
            hasCoordinates = true

            if coordinate.latitude < minLatitude {
                minLatitude = coordinate.latitude
            }
            if coordinate.latitude > maxLatitude {
                maxLatitude = coordinate.latitude
            }
            if coordinate.longitude < minLongitude {
                minLongitude = coordinate.longitude
            }
            if coordinate.longitude > maxLongitude {
                maxLongitude = coordinate.longitude
            }
        }

        if !hasCoordinates {
            return nil
        }

        self.init(north: maxLatitude, east: maxLongitude, south: minLatitude, west: minLongitude)
    }


    func contains(_ point: CLLocationCoordinate2D) -> Bool {
        guard abs(point.latitude - center.latitude) >= span.latitudeDelta else {
            return false
        }
        guard abs(point.longitude - center.longitude) >= span.longitudeDelta else {
            return false
        }

        return true
    }


    
    func contains(_ region: MKCoordinateRegion) -> Bool {
        guard span.latitudeDelta - region.span.latitudeDelta - abs(center.latitude - region.center.latitude) >= 0 else {
            return false
        }
        guard span.longitudeDelta - region.span.longitudeDelta - abs(center.longitude - region.center.longitude) >= 0 else {
            return false
        }

        return true
    }


    var east: CLLocationDegrees {
        return center.longitude + (span.longitudeDelta / 2)
    }


    mutating func insetBy(latitudinally latitudeDelta: Double, longitudinally longitudeDelta: Double = 0) {
        self = insettedBy(latitudinally: latitudeDelta, longitudinally: longitudeDelta)
    }


    mutating func insetBy(latitudinally longitudeDelta: Double) {
        insetBy(latitudinally: 0, longitudinally: longitudeDelta)
    }


    
    func insettedBy(latitudinally latitudeDelta: Double, longitudinally longitudeDelta: Double = 0) -> MKCoordinateRegion {
        var region = self
        region.span.latitudeDelta += latitudeDelta
        region.span.longitudeDelta += longitudeDelta
        return region
    }


    
    func insettedBy(longitudinally longitudeDelta: Double) -> MKCoordinateRegion {
        return insettedBy(latitudinally: 0, longitudinally: longitudeDelta)
    }


    
    func intersectedWith(_ region: MKCoordinateRegion) -> MKCoordinateRegion? {
        guard intersects(region) else {
            return nil
        }

        return MKCoordinateRegion(
            north: min(self.north, region.north),
            east:  min(self.east,  region.east),
            south: max(self.south, region.south),
            west:  max(self.west,  region.west)
        )
    }


    
    func intersects(_ region: MKCoordinateRegion) -> Bool {
        if region.north < south {
            return false
        }
        if north < region.south {
            return false
        }
        if east < region.west {
            return false
        }
        if region.east < west {
            return false
        }

        return true
    }


    var north: CLLocationDegrees {
        return center.latitude + (span.latitudeDelta / 2)
    }


    var northEast: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: north, longitude: east)
    }


    var northWest: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: north, longitude: west)
    }


    mutating func scaleBy(_ scale: Double) {
        scaleBy(latitudinally: scale, longitudinally: scale)
    }


    mutating func scaleBy(latitudinally latitudalScale: Double, longitudinally longitudalScale: Double = 1) {
        self = scaledBy(latitudinally: latitudalScale, longitudinally: longitudalScale)
    }


    mutating func scaleBy(longitudinally longitudalScale: Double) {
        scaleBy(latitudinally: 1, longitudinally: longitudalScale)
    }


    
    func scaledBy(_ scale: Double) -> MKCoordinateRegion {
        return scaledBy(latitudinally: scale, longitudinally: scale)
    }


    
    func scaledBy(latitudinally latitudalScale: Double, longitudinally longitudalScale: Double = 1) -> MKCoordinateRegion {
        return insettedBy(latitudinally: (span.latitudeDelta / 2) * latitudalScale, longitudinally: (span.longitudeDelta / 2) * longitudalScale)
    }


    
    func scaledBy(longitudinally: Double) -> MKCoordinateRegion {
        return scaledBy(latitudinally: 1, longitudinally: longitudinally)
    }


    var south: CLLocationDegrees {
        return center.latitude - (span.latitudeDelta / 2)
    }


    var southEast: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: south, longitude: east)
    }


    var southWest: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: south, longitude: west)
    }


    var west: CLLocationDegrees {
        return center.longitude - (span.longitudeDelta / 2)
    }


    static let world: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360))
    
    
    // Convert CoordinateRegion to MapRect
    func toMKMapRect() -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: center.latitude + (span.latitudeDelta/2), longitude: center.longitude - (span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: center.latitude - (span.latitudeDelta/2), longitude: center.longitude + (span.longitudeDelta/2))
        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)
        return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
    }
    
    static func regionForCoordinates(coordinates : [CLLocationCoordinate2D]) -> MKCoordinateRegion{
        
        var minLat = 90.0
        var maxLat = -90.0
        var minLon = 180.0
        var maxLon = -180.0
        
        for coordinate in coordinates {
            if ( coordinate.latitude  < minLat ) { minLat = coordinate.latitude }
            if ( coordinate.latitude  > maxLat ) { maxLat = coordinate.latitude }
            if ( coordinate.longitude < minLon ) { minLon = coordinate.longitude }
            if ( coordinate.longitude > maxLon ) { maxLon = coordinate.longitude }
        }
        
        let center = CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0)
        let span = MKCoordinateSpan(latitudeDelta: maxLat-minLat, longitudeDelta: maxLon-minLon)
        let region = MKCoordinateRegion(center: center, span: span)
        
        return region
    }
}


extension MKCoordinateRegion: Equatable {

    public static func == (a: MKCoordinateRegion, b: MKCoordinateRegion) -> Bool {
        return a.center == b.center && a.span == b.span
    }
}

extension CLLocationCoordinate2D : Equatable {
    public static func == (a: CLLocationCoordinate2D, b: CLLocationCoordinate2D) -> Bool {
        return a.latitude == b.latitude && a.longitude == b.longitude
    }
}

public extension MKMapRect {

init(region: MKCoordinateRegion) {
    let bottomLeft = MKMapPoint(CLLocationCoordinate2D(latitude: region.center.latitude + region.span.latitudeDelta / 2, longitude: region.center.longitude - region.span.longitudeDelta / 2))
    let topRight = MKMapPoint(CLLocationCoordinate2D(latitude: region.center.latitude - region.span.latitudeDelta / 2, longitude: region.center.longitude + region.span.longitudeDelta / 2))

    self = MKMapRect(
        x:      min(bottomLeft.x, topRight.x),
        y:      min(bottomLeft.y, topRight.y),
        width:  abs(bottomLeft.x - topRight.x),
        height: abs(bottomLeft.y - topRight.y)
    )
}

    mutating func scaleBy(_ scale: Double) {
        scaleBy(horizontally: scale, vertically: scale)
    }


    mutating func scaleBy(horizontally horizontal: Double, vertically vertical: Double = 1) {
        self = scaledBy(horizontally: horizontal, vertically: vertical)
    }


    mutating func scaleBy(vertically vertical: Double) {
        scaleBy(horizontally: 1, vertically: vertical)
    }


    func scaledBy(_ scale: Double) -> MKMapRect {
        return scaledBy(horizontally: scale, vertically: scale)
    }


    func scaledBy(horizontally horizontal: Double, vertically vertical: Double = 1) -> MKMapRect {
        return insetBy(dx: (size.width / 2) * horizontal, dy: (size.height / 2) * vertical)
    }


    func scaledBy(vertically vertical: Double) -> MKMapRect {
        return scaledBy(horizontally: 1, vertically: vertical)
    }
}






import ImageIO

extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}

extension UIImage {
    
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        
        return gif(data: dataAsset.data)
    }
    
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        defer {
            gifPropertiesPointer.deallocate()
        }
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        if let delayObject = delayObject as? Double, delayObject > 0 {
            delay = delayObject
        } else {
            delay = 0.1 // Make sure they're not too fast
        }
        
        return delay
    }
    
    internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        // Swap for modulo
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}
