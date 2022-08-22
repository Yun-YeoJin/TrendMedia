

import UIKit

class Setting2TableViewController: UITableViewController {
    
    //구조체 이용해서 만듦
    var movieList = MovieInfo() //인스턴스화
    
    
    // MARK: 뷰컨트롤러의 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(resetButtonClicked))
        
        
    }
    
    //MARK: 일반 액션
    
    ///Window rootViewController 교체 - 시작화면으로 돌아가는 메서드 (퀵 헬프)
    @objc func resetButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    //MARK: 테이블뷰 메서드
    
    //셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    // 셀의 내용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Setting2TableViewCell", for: indexPath) as! Setting2TableViewCell
        
        let data = movieList.movie[indexPath.row]
        cell.configureCell(data: data)
        //TableViewCell에서 함수 만들어서 불러옴
        
        return cell
        
        
    }
    //셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8 //전체 디바이스 높이
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectedRow")
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "RecommendCollectionViewController") as! RecommendCollectionViewController
        
        vc.movieData = movieList.movie[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        //Setting2TableViewController에 네비게이션이 붙어 있어야 실행이 된다.
        
        //2. 값 전달 - VC가 가지고 있는 프로퍼티에 데이터 추가
        
        
        
    }
}
