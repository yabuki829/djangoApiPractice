//
//  ViewController.swift
//  api-django
//
//  Created by Yabuki Shodai on 2021/10/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let decoder: JSONDecoder = JSONDecoder()
    var jobs = [Job]()
    var count = 0
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tap(_ sender: Any) {
        getApi()
    }
    @IBAction func tap2(_ sender: Any) {
        postApi()
    }
    private func  getApi(){
        AF.request("http://127.0.0.1:8000/api/jobs/?format=json").responseJSON { [self] response in
                switch response.result {
                case .success:
                    do {
                        self.jobs = try self.decoder.decode([Job].self, from: response.data!)
                        label1.text = jobs[count].companyName
                        label2.text = jobs[count].jobTitle
                        label3.text = jobs[count].jobDescription
                        label4.text = String(jobs[count].salary)
                        label5.text = jobs[count].perfectures
                        label6.text = jobs[count].city
                        label7.text = jobs[count].createdAt
                        count+=1
                        if count == jobs.count {
                            count = 0
                        }
                    } catch {
                        print("デコードに失敗しました")
                    }
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    
    //モバイルからApiにpostしてもid は自動で振られる。
    func postApi(){
        let parameters:[String: Any] = [
            "companyName": "Facebook",
            "companyEmail": "facebook@facebook.com",
            "jobTitle": "WebEngineer",
            "jobDescription": "react",
            "salary": 1000,
            "perfectures": "USA",
            "city": "Silicon valley",
            "createdAt": "2021-10-29"
               ]
        AF.request("http://127.0.0.1:8000/api/jobs/?format=json",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                    switch response.result {
                    case .success:
                        do{
                            print("成功")
                        }catch {
                            print("デコードに失敗しました")
                        }
                        
                    case .failure(let error):
                        print("error", error)
                    }
                    
                 
        }
    
    }
    
}


struct Job:Codable{
    let companyName:String
    let companyEmail:String
    let jobTitle:String
    let jobDescription:String
    let salary:Int
    let perfectures:String
    let city:String
    let createdAt:String
    
}

