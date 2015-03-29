task :deploy do

  require "rubygems"
  require "google_drive_v0"

      password = File.open(".secret", "r").read
      password.gsub!("\n", '')

      session = GoogleDriveV0.login("brian.dorton@theironyard.com", password)

      google_spreadsheet_key = '1kQEIK_rDVLe9lY3DTCQen67WKVHj_DDjV0XwhZB3K0M'
      rows = session.spreadsheet_by_key(google_spreadsheet_key).worksheets[0].rows

      responses = Array.new

      rows[1..-1].each do |row|
        responses << { timestamp: row[0], name: row[1], class: row[2], app_name: row[3], tech: row[4], rationale: row[5], app_url: row[6], github: row[7], email: row[8], pic: row[9], portfolio: row[10] }
      end

      File.open('data/responses.json', 'w') { |f| f << responses.to_json }

      system("middleman build")
      system("middleman deploy")

end
