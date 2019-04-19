# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'KChecker' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KChecker

inhibit_all_warnings!

    pod 'AFNetworking', '~> 3.2.1'
    pod "FMDB", "~>2.6.2"
    pod "MJExtension","~>3.0.13"

#    下拉刷新
    pod "MJRefresh" , "~>2.4.12"
#    判断网络
    pod "Reachability", "~>3.2"
#    弹窗提示
    pod "MBProgressHUD","~>1.0.0"
    pod "JSONKit-NoWarning","1.2"
#    读取相册
    pod "UzysAssetsPickerController","0.9.9"
    pod "SwiftyJSON","4.1.0"
#    Dictionary To Model
    pod "HandyJSON",'5.0.0-beta'
    pod "EGOImageLoading","0.0.1"
    pod "Masonry","1.1.0"
#    source 'https://github.com/aliyun/aliyun-specs.git'
    pod 'AlicloudPush', '~> 1.9.8'
    
#   A UITextView subclass that adds support for multiline placeholder written in swift
    pod "KMPlaceholderTextView","1.4.0"
    
    pod 'Cache'
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            # Cache pod does not accept optimization level '-O', causing Bus 10 error. Use '-Osize' or '-Onone'
            if target.name == 'Cache'
                target.build_configurations.each do |config|
                    level = '-Osize'
                    config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = level
                    puts "Set #{target.name} #{config.name} to Optimization Level #{level}"
                end
            end
        end
    end

end
