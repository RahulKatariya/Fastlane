# Fastlane

Sample AppFile

```ruby
app_identifier "com.rahulkatariya.appname"
apple_id "rahulkatariya@apple.com"

ENV['XCODE_VERSION'] = "9.0"

ENV['APP_NAME'] = "APP_NAME"
ENV['P12_PASSWORD'] = "P12_PASSWORD"

ENV['SCHEME'] = "SCHEME"
ENV['TEAM_ID'] = "TEAM_ID"
ENV['ENTERPRISE_TEAM_ID'] = "ENTERPRISE_TEAM_ID"

ENV['EXTENSIONS'] = "EXTENSION1,EXTENSION2"
ENV['EXTENSIONS_SERVICES'] = "--app_group,--app_group"
ENV['SERVICES'] = "--app_group --associated_domains --icloud cloudkit"

ENV['MATCH_URL'] = "https://github.com/rahulkatariya/ios-certificates"

ENV["CRASHLYTICS_API_TOKEN"] = "870a7dfd59c619242a9ac17d040daa2c05d4"
ENV["CRASHLYTICS_BUILD_SECRET"] = "5076236afadfas8085d72df23f3e499f1021fc2854d374168a"

ENV['FASTLANE_XCODE_LIST_TIMEOUT'] = "120"
ENV['FASTLANE_XCODE_LIST_RETRIES'] = "10"
ENV['FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT'] = "120"
ENV['FASTLANE_XCODEBUILD_SETTINGS_RETRIES'] = "10"
```

Sample Fastfile

```ruby
import_from_git(url: 'https://github.com/JetpackSwift/fastlane.git',
               path: 'fastlane/Fastfile')
```
