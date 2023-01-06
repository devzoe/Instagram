//
//  DeletePostViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/06.
//

import UIKit

class DeletePostViewController: BaseViewController {
    lazy var dataManager : DeletePostDataManager = DeletePostDataManager()
    var postIdx = 0
    @IBOutlet weak var deleteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        deleteView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // 게시물 삭제 alert
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let action = UIAlertAction(title: "삭제", style: .default) { action in
            self.dataManager.deletePostData(self.postIdx, delegate: self)
        }
        self.presentAlert(title: "게시물을 삭제하시겠어요?", isCancelActionIncluded: true, with: action)
    }
}


extension DeletePostViewController {
    func didDeletePost(result: DeletePostResponse) {
        print("게시물 삭제 성공")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
