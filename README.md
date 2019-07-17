# WebViewDemo
Web View FrameWork

With the Help of this framework you can open the webview by just passing the URL which you want to be open in your project. You Don't 
have to integrate all the methods and initialize the web view.

Just Install this frameworks through cocoapods. Rest It will Work.

# CocoaPods Version
CustomWebView (0.1.1)

# https://cocoapods.org/pods/CustomWebView

The another advantage of this framework, if you have to detect something, and your backend developer has passed the things into webView.
And you need that json into view controller when ever you click on any button of Webview.

You will get that json data in your view controller by passing the simple data.

I will tell you how to use this framework.

Just Import this framework in your view Controller.


     import CustomWebView
     
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.openWebView()
    }

     private func openWebView() {
        var config = WebViewConfig.shared
        config.isOneView = false
        config.webURL = "https://www.google.com"
        
        let vc = WebModel(config: config)
        vc.getData { [weak self] (snapShot, isCancel) in
            
            guard let weakSelf = self else {return}
            
            guard isCancel == false else {
                print("User has close the WebView!")
                return
            }
            
            if let model = snapShot {
                weakSelf.getServer(model)
            }
            
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    
If your Webview is closed by user, You would get the notification by the callBack with the bool value true that Webview has been Closed.
If you get any kind of data from Call Back, it means your back end developer has done the rest of the work,

Just Sit back and relax and use this framework.

If you guys are facing any issue. Please lemme know.

# Author:-
 Mandeep Singh
 
 # Email:- 
 mandeep.singh671@gmail.com
