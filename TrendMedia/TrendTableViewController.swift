
import UIKit

class TrendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    //화면전환: 1.스토리보드 파일 2. 스토리보드 내에 VC 3.화면전환
    //영화버튼 클릭시 -> 버킷리스트 테이블뷰 띄워주기 (Present)
    @IBAction func movieButtonClicked(_ sender: UIButton) {
        //1. 스토리보드 파일
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        //2. 스토리보드 내에 VC
        let vc = sb.instantiateViewController(withIdentifier: "BucketlistTableViewController") as! BucketlistTableViewController
        vc.textFieldPlaceholder = "영화를 입력해주세요"
    
        //3. 화면 전환(present)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        //1. 스토리보드 파일
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        //2. 스토리보드 내에 VC
        let vc = sb.instantiateViewController(withIdentifier: "BucketlistTableViewController") as! BucketlistTableViewController
        
        vc.textFieldPlaceholder = "드라마를 입력해주세요"
        // 뷰 컨트롤러 띄우는 옵션 설정
        vc.modalPresentationStyle = .fullScreen
        //3. 화면 전환(present)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        //1. 스토리보드 파일
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        //2. 스토리보드 내에 VC
        let vc = sb.instantiateViewController(withIdentifier: "BucketlistTableViewController") as! BucketlistTableViewController
        
        vc.textFieldPlaceholder = "도서를 입력해주세요"
        //네비게이션 컨트롤러
        let nav = UINavigationController(rootViewController: vc)
        
        // 뷰 컨트롤러 띄우는 옵션 설정
        nav.modalPresentationStyle = .fullScreen
        //3. 화면 전환(present)
        self.present(nav, animated: true, completion: nil)
        
        
    }
}
