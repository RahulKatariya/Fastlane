# Fastlane

Sample AppFile

```ruby
apple_id "rahulkatariya@apple.com"

for_platform :ios do
  app_identifier "me.RahulKatariya.AppName"
    team_id "XXXXXXXRK"
end

ENV['XCODE_VERSION'] = "12.0"
ENV['APP_NAME'] = "CodeSwiftUI"
ENV['SCHEME'] = "CodeSwiftUI"

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
                version: "0.0.4")

build_number = Time.now.strftime('%Y%m%d%H%M')

platform :ios do
  lane :alpha do |options|
    configuration = options[:configuration]
    increment_build_number(build_number: build_number)
    makeIPA(
      configuration: configuration,
      force: options[:force] || false,
      use_match: options[:force] || false,
      export_options: { iCloudContainerEnvironment: "Production" }
    )
    copyIPA
    pilot(
      distribute_external: false,
      skip_waiting_for_build_processing: true,
      skip_submission: true
    )
  end

  private_lane :copyIPA do
    copy_artifacts(
      target_path: 'artifacts',
      artifacts: [
        '*.cer',
        '*.mobileprovision',
        '*.pem',
        '*.p12',
        '*.pkey',
        '*.ipa',
        '*.frameworks',
        '*.dSYM.zip'
      ]
    )
  end
end
```

Run with Command

```ruby
fastlane alpha configuration:Release force:true use_match:true
```
