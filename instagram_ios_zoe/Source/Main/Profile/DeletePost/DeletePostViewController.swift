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
    @IBOutlet weak var updateView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("delete post view will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("delete post view did appear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("delete post view did load")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteView(_:)))
        deleteView.addGestureRecognizer(tapGestureRecognizer)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(didTapUpdateView(_:)))
        updateView.addGestureRecognizer(tapGestureRecognizer2)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    // 게시물 삭제 alert
    @objc func didTapDeleteView(_ sender: UITapGestureRecognizer) {
        let action = UIAlertAction(title: "삭제", style: .default) { action in
            self.dataManager.deletePostData(self.postIdx, delegate: self)
        }
        self.presentAlert(title: "게시물을 삭제하시겠어요?", isCancelActionIncluded: true, with: action)
    }
    
    
    // 게시물 수정 화면으로 전환
    @objc func didTapUpdateView(_ sender: UITapGestureRecognizer) {
        var rootView = self.presentingViewController
        print(rootView)
        self.dismiss(animated: true) {
            print("push는 일어남?")
            
            print(rootView)
            let updatePostViewController = self.storyboard?.instantiateViewController(identifier: "UpdatePostNavigationController")
            updatePostViewController?.modalPresentationStyle = .fullScreen
            rootView?.present(updatePostViewController!, animated: true)
        }
        
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
extension UINavigationController {
    func popViewController(animated: Bool, completion:@escaping (()->())) -> UIViewController? {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        let poppedViewController = self.popViewController(animated: animated)
        CATransaction.commit()
        return poppedViewController
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion:@escaping (()->())) {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
