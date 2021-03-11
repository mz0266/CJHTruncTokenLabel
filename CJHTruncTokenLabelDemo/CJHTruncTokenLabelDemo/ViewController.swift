//
//  ViewController.swift
//  CJHTruncTokenLabelDemo
//
//  Created by CJH on 2021/3/11.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    let tableView = UITableView()
    private var datas = Array(repeating: false, count: 10)
    let paragraphStyle = NSMutableParagraphStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paragraphStyle.lineSpacing = 3
        tableView.register(CJHTruncTokenCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 50
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CJHTruncTokenCell
        let paragraphStyle = NSMutableParagraphStyle()
        let attr = NSAttributedString(string: "我不是武汉人，可我是中国人！一直来我日日关注疫情，心系武汉，因为我们有同一个母亲——中国！我每日祈祷，和我们祖国千千万万的子女一样，祈祷我们早日战胜这场没有硝烟的战争。全国上下各方人士齐心协力，众志成城，携手共渡难关。我坚信：武汉必胜！中国必胜！", attributes: [
                                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                        NSAttributedString.Key.paragraphStyle:paragraphStyle
        ])
        cell.truncTokenLabel.setAttrText(attr: attr, open: datas[indexPath.row]) { (open) in
            self.datas[indexPath.row] = open
            self.tableView.reloadData()
        }
        return cell
    }

    class CJHTruncTokenCell: UITableViewCell {
        
        let truncTokenLabel = CJHTruncTokenLabel(maxLines: 3)
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
            contentView.addSubview(truncTokenLabel)
            truncTokenLabel.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[truncToken]-15-|", options: [], metrics: nil, views: ["truncToken":truncTokenLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[truncToken]-15-|", options: [], metrics: nil, views: ["truncToken":truncTokenLabel]))
        }
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    }

}

