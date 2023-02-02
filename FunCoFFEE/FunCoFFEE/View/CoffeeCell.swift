//
//  CoffeeCell.swift
//  FunCoFFEE
//
//  Created by  on 2021/3/12.
//

import UIKit

protocol CoffeeCellProtocol: class {
    func clickMap(longitude: String, latitude: String)
    func clickUrl(url: String)
}

class CoffeeCell: UICollectionViewCell {

    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mTime: UILabel!
    @IBOutlet weak var mAddress: UIButton!
    @IBOutlet weak var mUrl: UIButton!
    @IBOutlet weak var mMrt: UILabel!
    
    var mModel: CoffeeModel?
    weak var delegate: CoffeeCellProtocol?
    static var nib: UINib {
        return UINib(nibName: "CoffeeCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(model: CoffeeModel) {
        self.mModel = model
        mName.text = "店名：\(mModel?.name ?? "")"
        mTime.text = "營業時間：\(mModel?.openTime ?? "")"
        mAddress.setTitle(mModel?.address, for: .normal)
        mUrl.setTitle(mModel?.url, for: .normal)
        mMrt.text = "備註：\(mModel?.mrt ?? "")"
    }
    
    @IBAction func didClickMap(_ sender: Any) {
        delegate?.clickMap(longitude: mModel?.longitude ?? "", latitude: mModel?.latitude ?? "")
    }
    
    @IBAction func didClickUrl(_ sender: Any) {
        delegate?.clickUrl(url: mModel?.url ?? "")
    }
}
