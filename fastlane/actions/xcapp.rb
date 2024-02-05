module Fastlane
  module Actions
    module SharedValues
    end

    class XcappAction < Action
      def self.is_supported?(platform)
        [:ios, :mac].include? platform
      end

      def self.run(params)
        unless Helper.test?
          UI.user_error!("xcodebuild not installed") if `which xcodebuild`.length == 0
        end

        # platform
        platform = params[:platform] || "macOS"
        
        if params[:workspace].to_s.empty? && params[:project].to_s.empty?
            UI.user_error!("No workspace or project specified.")
        end

        if params[:scheme].to_s.empty?
            UI.user_error!("No scheme name specified.")
        end

        # workspace
        workspace = params[:workspace]
    
        # project
        project = params[:project]

        # scheme
        scheme = params[:scheme]

        # output path
        output_path = params[:outputPath] || "./.build"

        # artifacts path
        artifacts_path = "#{output_path}/artifacts/#{platform}"

        # archive path
        archive_path = "#{artifacts_path}/#{platform}.xcarchive"

        # export options plist
        export_options_plist = params[:exportOptions] || "fastlane/exportOptions.plist"

        # The args we will build with
        xcodebuild_args = Array[]

        xcodebuild_args << "-workspace #{workspace}"
        xcodebuild_args << "-project #{project}" if project
        xcodebuild_args << "-scheme #{scheme}"
        xcodebuild_args << "-configuration Release -allowProvisioningUpdates"
        xcodebuild_args << "-skipMacroValidation -disableAutomaticPackageResolution"
        xcodebuild_args << "-destination generic/platform=#{platform}"
        xcodebuild_args << "-derivedDataPath #{output_path}/derivedData/#{platform}"
        xcodebuild_args << "-archivePath #{archive_path}"

        # Joins args into space delimited string
        xcodebuild_args = xcodebuild_args.join(" ")

        # Supported ENV vars
        buildlog_path = ENV["XCODE_BUILDLOG_PATH"]

        # By default we put xcodebuild.log in the Logs folder
        buildlog_path ||= File.expand_path("#{FastlaneCore::Helper.buildlog_path}/fastlane/xcbuild/#{Time.now.strftime('%F')}/#{Process.pid}")

        xcbeautify_command = "| xcbeautify"
        pipe_command = "| tee '#{buildlog_path}/xcodebuild.log' #{xcbeautify_command}"

        FileUtils.mkdir_p buildlog_path
        UI.message("For a more detailed xcodebuild log open #{buildlog_path}/xcodebuild.log")

        FastlaneCore::CommandExecutor.execute(
          command: "set -o pipefail && rm -rf #{artifacts_path}",
          print_all: true,
          print_command: true,
          error: proc do |output|
            UI.build_failure!("Error building the application - see the log above", error_info: output)
          end
        )

        FastlaneCore::CommandExecutor.execute(
          command: "set -o pipefail && xcodebuild archive #{xcodebuild_args} #{pipe_command}",
          print_all: true,
          print_command: true,
          error: proc do |output|
            UI.build_failure!("Error building the application - see the log above", error_info: output)
          end
        )

        FastlaneCore::CommandExecutor.execute(
          command: "set -o pipefail && xcodebuild -exportArchive -allowProvisioningUpdates -archivePath #{archive_path} -exportOptionsPlist #{export_options_plist} -exportPath #{artifacts_path} #{pipe_command}",
          print_all: true,
          print_command: true,
          error: proc do |output|
            UI.build_failure!("Error building the application - see the log above", error_info: output)
          end
        )

        FastlaneCore::CommandExecutor.execute(
          command: "set -o pipefail && cp -r #{archive_path}/dSYMs/ #{artifacts_path}/dSYMs && pushd #{artifacts_path} && zip -r #{platform}_dSYMs.zip dSYMs && popd",
          print_all: true,
          print_command: true,
          error: proc do |output|
            UI.build_failure!("Error building the application - see the log above", error_info: output)
          end
        )
      end

      def self.description
        "Use the `xcapp` command to archive and export your app"
      end

      def self.details
        "**Note**: `xcapp` is a command that uses sensible defaults to archive and export the apps."
      end

      def self.available_options
        ['platform', 'Set to either ios or mac']
      end

      def self.authors
        "rahul0x24"
      end
    end
  end
end
