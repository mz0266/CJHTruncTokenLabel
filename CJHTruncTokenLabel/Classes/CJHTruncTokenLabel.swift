//
//  CJHTruncTokenLabel.swift
//
//  Created by CJH on 2021/3/11.
//
//════════════════════════════════════════════════════════════════════════════════

import UIKit

class CJHTruncTokenLabel: UILabel {
    private let maxLines:Int
    private var tsqAttributedText:NSAttributedString?
    private var open = false
    public var closure:((Bool)->Void)?
    init(maxLines:Int = 0) {
        self.maxLines = maxLines
        super.init(frame: .zero)
        numberOfLines = maxLines
        lineBreakMode = .byClipping
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
 
    override func draw(_ rect: CGRect) {
        if let attTxt = tsqAttributedText {
            let ctLines = attTxt.ctLines(rect:CGRect(x: 0, y: 0, width: rect.width, height: CGFloat.greatestFiniteMagnitude))
            if ctLines.count > maxLines {
                isUserInteractionEnabled = true
                addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(on_trunc_toggle)))
                var rangeSample = NSRange(location: attTxt.length - 1, length: 1)
                let attrKeys:[NSAttributedString.Key : Any] = attTxt.attributes(at: 0, effectiveRange: &rangeSample)
                var optAttrKeys = attrKeys
                optAttrKeys[NSAttributedString.Key.foregroundColor] = UIColor(red: 1, green: 0.31, blue: 0, alpha: 1)
                var optAttText:NSMutableAttributedString!
                if open {
                    optAttText = NSMutableAttributedString(string: " 收起", attributes: optAttrKeys)
                } else {
                    optAttText = NSMutableAttributedString(string: "... 展开 ", attributes: attrKeys)
                    optAttText.setAttributes(optAttrKeys, range: NSRange(location: 4, length: 2))
                }
                
                let lineBounds = CTLineGetBoundsWithOptions(ctLines[maxLines-1], [])
                let length = ctLines.prefix(maxLines).reduce(0, { $0 + CTLineGetStringRange($1).length })
                let optWidth = optAttText.boundingRect(with: CGSize(width: rect.width, height: lineBounds.height), options: [.usesLineFragmentOrigin], context: nil).width
                let maxLen = open ? attTxt.length : min(CTLineGetStringIndexForPosition(ctLines[maxLines-1], CGPoint(x: rect.width - optWidth, y: 0)), length)
                let vAttText = NSMutableAttributedString(attributedString: attTxt.attributedSubstring(from: NSRange(location: 0, length: maxLen)))
                vAttText.append(optAttText)
                attributedText = vAttText
            }
        }
        super.draw(rect)
    }
 
    @objc private func on_trunc_toggle() { open.toggle();closure?(open) }
    func setAttrText(attr:NSAttributedString,open:Bool,closure:@escaping (Bool)->Void) {
        numberOfLines = open ? 0 : maxLines
        self.tsqAttributedText = attr
        attributedText = attr
        self.closure = closure
        self.open = open
        setNeedsDisplay()
    }
}
extension NSAttributedString {
    func ctLines(rect:CGRect) -> [CTLine] {
        let frameSet = CTFramesetterCreateWithAttributedString(self)
        let path = CGMutablePath()
        path.addRect(rect)
        let frame = CTFramesetterCreateFrame(frameSet, CFRangeMake(0, 0), path, nil)
        return CTFrameGetLines(frame) as? [CTLine] ?? [CTLine]()
    }
    func height(width:CGFloat) -> CGFloat {
        boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], context: nil).height
    }
}
