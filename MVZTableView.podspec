Pod::Spec.new do |s|

s.name                = "MVZTableView"
s.version             = "0.0.1"
s.summary             = "UITableView with MVVM"
s.homepage            = "https://github.com/medvedzzz/MVZTableView"
s.license             = 'MIT'
s.author              = { "Evgeny Mikhaylov" => "evgenmikhaylov@gmail.com" }
s.source              = { :git => "https://github.com/medvedzzz/MVZTableView.git", :tag => s.version }
s.platform            = :ios, '8.0'
s.requires_arc        = true
s.source_files        = 'MVZTableView/*.{h,m}'
s.subspec 'ViewModel' do |ss|
  ss.source_files       = 'MVZTableView/ViewModel/*.{h,m}'
end
s.subspec 'SectionFactories' do |ss|
  ss.source_files       = 'MVZTableView/SectionFactories/*.{h,m}'
  ss.subspec 'SectionItemsFactory' do |sss|
    sss.source_files       = 'MVZTableView/SectionFactories/SectionItemsFactory/*.{h,m}'
  end
end
s.subspec 'Sections' do |ss|
  # ss.dependency 'RSBTableViewManager/Protocols'
  ss.source_files       = 'MVZTableView/Sections/*.{h,m}'
  ss.subspec 'Section' do |sss|
    sss.source_files       = 'MVZTableView/Sections/Section/*.{h,m}'
    sss.subspec 'SectionModel' do |ssss|
      ssss.source_files       = 'MVZTableView/Sections/Section/SectionModel/*.{h,m}'
    end
    sss.subspec 'CellFactories' do |ssss|
      ssss.source_files       = 'MVZTableView/Sections/Section/CellFactories/*.{h,m}'
      ssss.subspec 'CellItemsFactory' do |sssss|
        sssss.source_files       = 'MVZTableView/Sections/Section/CellFactories/CellItemsFactory/*.{h,m}'
      end
    end
    sss.subspec 'Cells' do |ssss|
      ssss.source_files       = 'MVZTableView/Sections/Section/Cells/*.{h,m}'
      ssss.subspec 'Cell' do |sssss|
        sssss.source_files       = 'MVZTableView/Sections/Section/Cells/Cell/*.{h,m}'
        sssss.subspec 'CellModel' do |ssssss|
          ssssss.source_files       = 'MVZTableView/Sections/Section/Cells/Cell/CellModel/*.{h,m}'
        end
      end
    end
  end
end
s.dependency 'ReactiveCocoa', '~> 2.5'
s.dependency 'RSBTableViewManager'
s.dependency 'MVZMutableArray'
s.dependency 'MVZExtensions'
end
