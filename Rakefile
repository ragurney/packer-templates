require 'json'
require 'net/http'
require 'pathname'
require 'rainbow'
require 'rspec/core/rake_task'
require 'uri'

VAGRANT_PROVIDERS = {
  virtualbox: {
    builder_type: 'virtualbox-iso'
  },
  vmware_desktop: {
    builder_type: 'vmware-iso'
  }
}.freeze

task default: ['packer:validate', 'packer:check_iso_url']

namespace :packer do
  desc 'Validate all the packer templates'
  task :validate do
    Pathname.glob('*.json').sort.each do |template|
      puts Rainbow("Validating #{template}...").green
      unless system "packer validate #{template}"
        puts Rainbow("#{template} is not a valid packer template").red
        raise "#{template} is not a valid packer template"
      end
    end
  end

  task :build do |_t, args |

  end

  desc 'Check if all the ISO URLs are available'
  task :check_iso_url do
    Pathname.glob('*.json').sort.each do |template|
      json = JSON.parse(template.read)
      mirror = json['variables']['mirror']
      iso_urls = json['builders'].map do |builder|
        builder['iso_url'].sub('{{user `mirror`}}', mirror)
      end
      iso_urls.uniq.each do |iso_url|
        puts Rainbow("Checking if #{iso_url} is available...").green
        request_head(iso_url) do |response|
          unless available?(response)
            puts Rainbow("#{iso_url} is not available: #{response.message}").red
            raise "#{iso_url} is not available"
          end
        end
      end
    end
  end
end

def request_head(uri, &block)
  uri = URI(uri)
  Net::HTTP.start(uri.host, uri.port) do |http|
    http.request_head(uri, &block)
  end
end

def available?(response)
  response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPRedirection)
end
