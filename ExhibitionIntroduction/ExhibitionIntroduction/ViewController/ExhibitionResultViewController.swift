//
//  ExhibitionResultViewController.swift
//  ExhibitionIntroduction
//
//  Created by Hira on 2020/5/26.
//  Copyright © 2020 1. All rights reserved.
//

import UIKit
import Kingfisher

class ExhibitionResultViewController: UIViewController {

    @IBOutlet var views: ExhibitionResultView!
    
    var model: ExhibitionModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setUI()
    }
    
    @objc func didClickWebBtn() {
        guard model.sourceWebPromote != "", !model.sourceWebPromote.contains("list_permanent.asp") else { return }
        let vc = UIStoryboard.init(name: "Exhibition", bundle: nil).instantiateViewController(withIdentifier: "ExhibitionWebViewController") as! ExhibitionWebViewController
        vc.urls = model.sourceWebPromote
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUI() {
        views.titleLabel.text = "" + model.title
        views.introduceLabel.text = "簡介：" + model.description
        views.startTimeLabel.text = model.info.count > 0 ? "開始時間：" + model.info[0].time : ""
        views.endTimeLabel.text = model.info.count > 0 ? "結束時間：" + model.info[0].endTime : ""
        views.locationNameLabel.text = model.info.count > 0 ? "地點：" + model.info[0].locationName : ""
        views.locationLabel.text = model.info.count > 0 ? "地址：" + model.info[0].location : ""
        views.toWebButton.addTarget(self, action: #selector(didClickWebBtn), for: .touchUpInside)
        views.toWebButton.setAttributedTitle(webTitle(url: model.sourceWebPromote, color: UIColor.blue), for: .normal)
        
        if model.sourceWebPromote.contains("list_permanent.asp") {
            views.toWebButton.setAttributedTitle(webTitle(url: "", color: UIColor.black), for: .normal)
            views.toWebButton.isEnabled = false
        }
        
        if model.imageUrl == "" {
            views.noImageLabel.isHidden = false
            views.mImageView.image = UIImage(named: "landing")
        } else {
            if let url = URL(string: model.imageUrl) {
                DispatchQueue.main.async {
                    UIImageView().kf.setImage(with: url, placeholder: UIImage(named: "landing"), options: nil, progressBlock: nil) { (result) in
                        switch result {
                        case .success(let success):
                            self.views.mImageView.image = success.image
                        case .failure(_):
                            self.views.noImageLabel.isHidden = false
                            break
                        }
                    }
                }
            }
        }
    }
    
    func webTitle(url: String, color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: "網址：\(url)", attributes: [
          .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
          .foregroundColor: color,
          .kern: -0.41
        ])
        attributedString.addAttributes([
          .font: UIFont(name: "PingFangTC-Regular", size: 17.0)!,
          .foregroundColor: UIColor.black,
          .kern: -0.33
        ], range: NSRange(location: 0, length: 3))
        return attributedString
    }
}
