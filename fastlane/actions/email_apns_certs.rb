module Fastlane
  module Actions
    # Adds a git tag to the current commit
    class EmailApnsCertsAction < Action
      def self.run(options)
        
      end

      def self.description
        "This will email all the APNS Push Certs to Backend"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :html_template,
                                       env_name: "APNS_CERTS_HTML_TEMPLATE",
                                       description: "The Template",
                                       optional: true)
        ]
      end

      def self.author
        "Rahul Katariya"
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
