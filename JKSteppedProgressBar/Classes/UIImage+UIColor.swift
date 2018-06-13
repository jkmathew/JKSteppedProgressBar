import UIKit

extension UIImage {
    func imageWithColor(_ color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func draw(inside rect: CGRect) {
        let insideRect = rect.insetBy(dx: 8, dy: 8)
        self.draw(in: insideRect)
    }
}
