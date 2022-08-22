

import UIKit
import Toast
import Kingfisher

/*
 TableView => CollectionView
 Row => item 만 다름
 heightForRowAt이 없는 이유, 3*n으로 할지, 4*n으로 할지 높이와 너비 두 개 다 필요하기 때문에 없음.
 => 그래서 FlowLayOut (heightForItem)
 */




class RecommendCollectionViewController: UICollectionViewController {

    // 1.값 전달 - 데이터를 받을 공간(프로퍼티) 생성
    var movieData: Movie?
    // 따로따로 프로퍼티 생성하지 않고 하나의 구조체 전체를 전달받는 이유?
    
    var imageURL = "https://img.hankyung.com/photo/202205/01.29908345.1-1200x.jpg"
     
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //3. 값 전달 - 프로퍼티 값을 뷰에 표현
        //title = movieTitle == nil ? "No data" : movieTitle!
        
        //컬렉션뷰의 셀 크기, 셀 사이 간격 등 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        //device를 여백 하나도 꽉채움 (uiscreen.main.bounds.width)
        let width = UIScreen.main.bounds.width - (spacing * 4) //여백이 4개라 곱하기 4를 함(겹치니까)
        
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2) //컬렉션뷰 셀의 크기 설정 (높이, 너비)
        layout.scrollDirection = .vertical //컬렉션뷰 스크롤 방향 설정
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) // 상,하,좌,우 여백 설정
        layout.minimumLineSpacing = spacing //셀 사이의 간격
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout // 레이아웃 선언을 해줘야 동작함.
        
}
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell", for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.posterImage.backgroundColor = .clear
        
        let url = URL(string: imageURL)
        cell.posterImage.kf.setImage(with: url)
        
        return cell
    }
  
    // 셀이 선택되었을 때 - didSelectItemAt (Toast 라이브러리 사용)
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.view.makeToast("\(indexPath.item)번째 셀을 선택했습니다.", duration: 1, position: .center)
        // 1초동안, 스크린 가운데에 표시.
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
