//
//  TabManViewController.swift
//  instagram_ios_zoe
//
//  Created by 남경민 on 2023/01/01.
//


import Tabman

extension TabmanViewController {
    func setTabBarUI(_ vc : TabViewController) {
        // 바 생성 + tabbar 에 관한 디자인처리를 여기서 하면 된다.
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        //배경색
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        // tab 밑 bar 색깔 & 크기
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .gray
        // tap center
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        // tap 사이 간격
        bar.layout.interButtonSpacing = 0
        // tap 선택 / 미선택
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        addBar(bar, dataSource: vc, at: .top)
    }
    func setPostTabBarUI(_ vc : MyPostTabViewController) {
        // 바 생성 + tabbar 에 관한 디자인처리를 여기서 하면 된다.
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        //배경색
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        // tab 밑 bar 색깔 & 크기
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .gray
        // tap center
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        // tap 사이 간격
        bar.layout.interButtonSpacing = 0
        // tap 선택 / 미선택
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        addBar(bar, dataSource: vc, at: .top)
    }
    func setSearchingTabBarUI(_ vc : SearchingTabViewController) {
        // 바 생성 + tabbar 에 관한 디자인처리를 여기서 하면 된다.
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        //배경색
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        // tab 밑 bar 색깔 & 크기
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .gray
        // tap center
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        // tap 사이 간격
        bar.layout.interButtonSpacing = 0
        // tap 선택 / 미선택
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        addBar(bar, dataSource: vc, at: .top)
    }
}
