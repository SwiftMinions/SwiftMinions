Pod::Spec.new do |s|
  s.name             = 'SwiftMinions'
  s.version          = '5.0.4'
  s.summary          = 'Save your day.'

  s.description      = <<-DESC
  
  This project is a collection of offen used swift functions, the purpose is to save your day.
  
  There are lots of frameworks that better than us. 

  Instead of being a framework warriors, we choice create our own.

  We inspire from SwifterSwift and strict follow naming conventions

  DESC
   
  s.homepage         = 'https://github.com/SwiftMinions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }


  s.author           = { 

    'Chen Stephen'  => 'tasb00429@gmail.com',
    'Natalie'       => 'nwy0206@gmail.com',
    'Ohlulu'        => 'z30262226@gmail.com',
    'Michael Chen ' => 'helloworldsmart3@gmail.com',
    'Hank'          => 'su3895623@gmail.com',
    'Oyster'        => 'jenhausu@icloud.com',
    'KuoChingHao'   => 'zxm55547@gmail.com'
  }

  s.source                = { :git => 'https://github.com/SwiftMinions/SwiftMinions.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.cocoapods_version     = '>= 1.4.0'
  s.swift_version         = '5.1'
  s.requires_arc          = true
  s.default_subspec       = 'Core'

  # Foundation Extensions and this is core library
  s.subspec 'Core' do |ss|
    ss.source_files  = 'Sources/SwiftMinions/*.swift', 'Sources/SwiftMinions/**/*.swift'
  end

end
