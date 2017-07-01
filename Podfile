# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'AwesomeQuotes' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AwesomeQuotes
  pod 'Cartography'
  pod 'ReSwift'
  pod 'Alamofire', '~> 4.4'
  pod "PromiseKit", "~> 4.0"
  pod 'PromiseKit/Alamofire', '~> 4.0'

  target 'AwesomeQuotesTests' do
    inherit! :search_paths
    
    # Pods for testing
    pod 'Quick'
    pod 'Nimble', :inhibit_warnings => true
  end

  target 'AwesomeQuotesUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
