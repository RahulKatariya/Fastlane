# Fastlane

Sample AppFile

```ruby
apple_id "rahulkatariya@apple.com"

for_platform :ios do
  app_identifier "me.RahulKatariya.AppName.enterprise"
  team_id "XXXXXXXRK"

  for_lane :alpha do
    app_identifier "me.RahulKatariya.AppName"
    team_id "XXXXXXXRK"
  end

end

ENV['XCODE_VERSION'] = "9.0"
ENV['APP_NAME'] = "RahulKatariya"
ENV['SCHEME'] = "RahulKatariya"

ENV['SERVICES'] = "--app_group --associated_domains --icloud cloudkit"
ENV['EXTENSIONS'] = "Share,Today"
ENV['EXTENSIONS_SERVICES'] = "--app_group,--app_group"
```

Sample MatchFile

```ruby
git_url "https://github.com/RahulKatariya/ios-certificates"
readonly false
force true
force_for_new_devices true
```

Sample Fastfile

```ruby
import_from_git(url: 'https://github.com/RahulKatariya/fastlane.git',
                path: 'fastlane/Fastfile',
                version: "0.0.3")
```
