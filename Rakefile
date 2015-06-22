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
          responses << { timestamp: row[0], name: row[1], class: row[2], app_name: row[3], tech: row[4], rationale: row[5], app_url: row[6], github: row[7], email: row[8], pic: row[9], portfolio: row[10], city: row[11] }
        end

        File.open('data/responses.json', 'w') { |f| f << responses.to_json }


      # system("middleman build")
      # system("middleman deploy")

end


task :staff do

    require "rubygems"
    require "google_drive_v0"

        password = File.open(".secret", "r").read
        password.gsub!("\n", '')

        session = GoogleDriveV0.login("brian.dorton@theironyard.com", password)

        google_spreadsheet_key = '1DGD-ZMY7mWNy9zMUsr96mAMgwfGSmOo_yE4AQYC0r_s'
        rows = session.spreadsheet_by_key(google_spreadsheet_key).worksheets[0].rows

        staff = Array.new

        rows[1..-1].each do |row|
          staff << { name: row[0], title: row[1], bio: row[2], pic: row[3], city: row[4] }
        end

        File.open('data/staff.json', 'w') { |f| f << staff.to_json }


end
