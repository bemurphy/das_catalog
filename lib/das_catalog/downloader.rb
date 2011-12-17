module DasCatalog
  # TODO spec this
  class Downloader
    def self.process(screencast)
      # Mechanize was choking on large file downloads and keeps them in memory,
      # outsource to wget
      agent = DasCatalog.agent
      agent.redirect_ok = false
      result = agent.get screencast.download_link
      url = result.header["location"]
      url =~ /^http.+?([^\/]+\.mov)\?/
      output_filename = $1
      `wget --quiet #{Shellwords.escape url} -O #{DasCatalog.downloads_directory}/#{output_filename}`
    end
  end
end
