//
//  ApiService.swift
//  ESCOBOSS
//
//  Created by Praneeth Althuru on 08/08/18.
//  Copyright © 2018 Appailus. All rights reserved.
//

import UIKit

typealias Parameters = [String: String]


class ApiService: NSObject {
    
    static func callPost(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void)
    {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if methodType == "POST"  || methodType == "PUT" {
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            request.httpBody = httpBody
            
        }
        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                        
                    } catch {
                        print(error)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if(error != nil)
                    {
                        result.message = "Fail Error not null : \(error.debugDescription)"
                    }
                    else
                    {
                        
                        result.message = "Success"
                        result.data = data
                        result.tag = tag
                        
                    }
                    
                    finish(result)
                    
                    
                }
                
                }.resume()
            
        }
    }
    
    static func callPostToken(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void)
    {
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        let autho = "Bearer " + GlobalVariables.token

        print("API TOKEN = \(autho)")

        request.addValue(autho, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if methodType == "POST"  || methodType == "PUT" {
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
            request.httpBody = httpBody
            
        }
        DispatchQueue.global(qos: .background).async {
            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        print(json)
                        
                    } catch {
                        print(error)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if(error != nil)
                    {
                        result.message = "Fail Error not null : \(error.debugDescription)"
                    }
                    else
                    {
                        
                        result.message = "Success"
                        result.data = data
                        result.tag = tag
                        
                    }
                    
                    finish(result)
                    
                    
                }
                
                }.resume()
            
        }
    }
    
    static func callWithDevice(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void) {
            
            guard let url = URL(string: url) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = methodType
            let autho = "Bearer " + GlobalVariables.token
           let fcmToken = GlobalVariables.fcmToken
           print("fcmToken = \(fcmToken)")
           print("Auth Token = \(autho)")
           request.addValue(autho, forHTTPHeaderField: "Authorization")
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(fcmToken, forHTTPHeaderField: "deviceTokenId")
            
            if methodType == "POST"  || methodType == "PUT" {
                
                guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
                request.httpBody = httpBody
                
            }
            DispatchQueue.global(qos: .background).async {
                var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if let response = response {
                        print(response)
                    }
                    
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print(json)
                            
                        } catch {
                            print(error)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        
                        if(error != nil)
                        {
                            result.message = "Fail Error not null : \(error.debugDescription)"
                        }
                        else
                        {
                            
                            result.message = "Success"
                            result.data = data
                            result.tag = tag
                            
                        }
                        
                        finish(result)
                        
                        
                    }
                    
                    }.resume()
                
            }
        }
    
    static func callImageToken(url:String, params: Any ,methodType: String, tag : String ,  finish: @escaping ((message:String, data:Data?, tag : String)) -> Void)
       {
           
           guard let url = URL(string: url) else { return }
           var request = URLRequest(url: url)
           request.httpMethod = methodType
           let autho = "Bearer " + Preferences.getUserToken()
           print("API TOKEN = \(autho)")

           request.addValue(autho, forHTTPHeaderField: "Authorization")
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           
           if methodType == "POST"  || methodType == "PUT" {
               
               guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else { return }
               request.httpBody = httpBody
               
           }
           DispatchQueue.global(qos: .background).async {
               var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
               let session = URLSession.shared
               session.dataTask(with: request) { (data, response, error) in
                   if let response = response {
                       print(response)
                   }
                   
                   if let data = data {
                       do {
                           let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                           print(json)
                           
                       } catch {
                           print(error)
                       }
                   }
                   
                   DispatchQueue.main.async {
                       
                       if(error != nil)
                       {
                           result.message = "Fail Error not null : \(error.debugDescription)"
                       }
                       else
                       {
                           
                           result.message = "Success"
                           result.data = data
                           result.tag = tag
                           
                       }
                       
                       finish(result)
                       
                       
                   }
                   
                   }.resume()
               
           }
       }
    
//   static func apiCallingUsingFormData(parameters : [String : String]? , mediaImage : [Media]? , methodType : String ,url :String, tag : String ,finish: @escaping ((message:String, data:Data?, tag : String)) -> Void){
//
//        guard let url = URL(string: url) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = methodType
//
//        let boundary = generateBoundary()
//
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Accept")
//
//        let venderid =  UserDefaults.standard.string(forKey: "VendorId")
//        request.setValue(venderid, forHTTPHeaderField: "vendorid")
//        request.addValue(UserDefaults.standard.string(forKey: "role")!, forHTTPHeaderField: "role")
//
//
//
//       if methodType == "POST"  || methodType == "PUT" {
//
//            let lineBreak = "\r\n"
//            var body = Data()
//
//            if let parameters = parameters {
//                for (key, value) in parameters {
//                    body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)".data(using: .utf8)!)
//                    body.append("\(value + lineBreak)".data(using: .utf8)!)
//                }
//            }
//
//            if let media = mediaImage {
//                for photo in media {
//                    body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)".data(using: .utf8)!)
//                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)".data(using: .utf8)!)
//                    body.append(photo.data)
//                    body.append(lineBreak.data(using: .utf8)!)
//                }
//            }
//
//        body.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
//        request.httpBody = body
//
//    }
//
//       DispatchQueue.global(qos: .background).async {
//        var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//
//                print(response)
//            }
//
//            if let data = data {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(json)
//                } catch {
//                    print(error)
//                }
//            }
//
//            DispatchQueue.main.async {
//
//                if(error != nil)
//                {
//                    result.message = "Fail Error not null : \(error.debugDescription)"
//                }
//                else
//                {
//                    let httpResponse = response as? HTTPURLResponse
//                    result.message = String(describing:httpResponse!.statusCode)
//                    result.data = data
//                    result.tag = tag
//
//                }
//
//                finish(result)
//
//            }
//
//
//            }.resume()
//        }
//    }
//
//   static func generateBoundary() -> String {
//        return "Boundary-\(NSUUID().uuidString)"
//    }
//
//
//    static func apiCallingUsingFormDataVideo(parameters : [String : String]? , mediaImage : [VideoMedia]? , methodType : String ,url :String, tag : String ,finish: @escaping ((message:String, data:Data?, tag : String)) -> Void){
//
//        guard let url = URL(string: url) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = methodType
//
//        let boundary = generateBoundary()
//
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Accept")
//
//        let venderid =  UserDefaults.standard.string(forKey: "VendorId")
//        request.setValue(venderid, forHTTPHeaderField: "vendorid")
//        request.addValue(UserDefaults.standard.string(forKey: "role")!, forHTTPHeaderField: "role")
//
//
//
//        if methodType == "POST"  || methodType == "PUT" {
//
//            let lineBreak = "\r\n"
//            var body = Data()
//
//            if let parameters = parameters {
//                for (key, value) in parameters {
//                    body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)".data(using: .utf8)!)
//                    body.append("\(value + lineBreak)".data(using: .utf8)!)
//                }
//            }
//
//            if let media = mediaImage {
//                for photo in media {
//                    body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
//                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)".data(using: .utf8)!)
//                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)".data(using: .utf8)!)
//                    body.append(photo.data)
//                    body.append(lineBreak.data(using: .utf8)!)
//                }
//            }
//
//            body.append("--\(boundary)--\(lineBreak)".data(using: .utf8)!)
//            request.httpBody = body
//
//        }
//
//        DispatchQueue.global(qos: .background).async {
//            var result:(message:String, data:Data? , tag : String) = (message: "Fail", data: nil , tag: tag)
//            let session = URLSession.shared
//            session.dataTask(with: request) { (data, response, error) in
//                if let response = response {
//
//                    print(response)
//                }
//
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                        print(json)
//                    } catch {
//                        print(error)
//                    }
//                }
//
//                DispatchQueue.main.async {
//
//                    if(error != nil)
//                    {
//                        result.message = "Fail Error not null : \(error.debugDescription)"
//                    }
//                    else
//                    {
//                        let httpResponse = response as? HTTPURLResponse
//                        result.message = String(describing:httpResponse!.statusCode)
//                        result.data = data
//                        result.tag = tag
//
//                    }
//
//                    finish(result)
//
//                }
//
//
//                }.resume()
//        }
//    }
    
    

}
