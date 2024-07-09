# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TestTiki' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SnapKit', '~> 4.0.0'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RxDataSources', '~> 4.0'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SDWebImage'

  # Pods for TestTiki

  target 'TestTikiTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

  target 'TestTikiUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
