//
//  BackupViewController.swift
//  TrendMedia
//
//  Created by 윤여진 on 2022/08/25.
//

import UIKit

import SnapKit
import Then
import Zip

class BackupViewController: UIViewController {

    let backupButton = UIButton().then {
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemMint.cgColor
        $0.setTitle("백업하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let restoreButton = UIButton().then {
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemMint.cgColor
        $0.setTitle("복구하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        
        
        backupButton.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(100)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.top.equalTo(backupButton.snp.bottom).offset(50)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(100)
        }
        
        backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        }
        
    
@objc func backupButtonClicked() {
    
    var urlPaths = [URL]()
    
    //MARK: 1. Document 위치에 백업할 파일이 존재하는지 확인
    guard let path = documentDirectoryPath() else {
        showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
        return
    }
    // realmFile의 경로를 찾는 과정
    let realmFile = path.appendingPathComponent("default.realm")
    // 경로에 백업 파일이 존재하는지 확인하는 과정
    guard FileManager.default.fileExists(atPath: realmFile.path) else {
        showAlertMessage(title: "백업할 파일이 없습니다.")
        return
    }
    
    urlPaths.append(URL(string: realmFile.path)!)
    
    //백업 파일이 있다면 압축 : URL -> Zip opensourceLibrary 사용
    do {
        let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList_1") // 파일 이름
        print("Archive Location: \(zipFilePath)")
        
        //ActivityViewController - 성공을 했을 때만 띄워줘야 하기 때문
        showActivityViewController()
        
    }
    catch {
       showAlertMessage(title: "압축에 실패했습니다.")
    }
}

func showActivityViewController() {
    
    guard let path = documentDirectoryPath() else {
        showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
        return
    }
    // realmFile의 경로를 찾는 과정
    let backupFileURL = path.appendingPathComponent("ShoppingList_1.zip") //별도의 경로를 가져올 때, 확장자까지 작성해야함.
    
    let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [] )
    self.present(vc, animated: true)
}

@objc func restoreButtonClicked() {
    
    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
    documentPicker.delegate = self
    documentPicker.allowsMultipleSelection = false
    self.present(documentPicker, animated: true)
    
}

}

//MARK: DocumentPickerDelegate
extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    //MARK: Document 선택 시
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else { //URL의 first를 통해 어떤 파일을 선택했는지
            showAlertMessage(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        //Document 위치 확인
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent) //가장 마지막 생성된 것 가져옴
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("ShoppingList_1.zip")
            
            do { //Zip 파일 해제
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progree: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.")
                })
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
        } else {
            
            do {
                //파일 앱의 zip -> Document 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("ShoppingList_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progree: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가 완료되었습니다.")
                })
                
            } catch {
                showAlertMessage(title: "압축 해제에 실패했습니다.")
            }
            
        }
    }
    
}

