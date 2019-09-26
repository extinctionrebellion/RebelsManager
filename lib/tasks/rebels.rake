require 'csv'

namespace :rebels do
  desc "Generate token for all rebels missing one"
  task generate_token: :environment do
    Rebel.where(token: nil).find_each do |rebel|
      rebel.update_column(:token, SecureRandom.hex(16).to_i(16).to_s(36))
    end
  end

  task import: :environment do
    CSV.foreach(Rails.root.join("rebels.csv"), headers: false) do |row|
      email = row[1]
      begin
        rebel = Rebel.find_or_create_by(email: email) do |rebel|
          rebel.name = row[0]
          rebel.phone = row[2]
          rebel.postcode = row[3]
          rebel.language = row[4]
          rebel.interests = row[5]
          rebel.notes = row[6]
          rebel.consent = true
        end
        if rebel.persisted?
          puts "Imported rebel"
        else
          puts "Invalid rebel: #{row.inspect}"
          puts rebel.errors.inspect
        end
      rescue StandardError => error
        puts "Error when importing #{email}"
        puts error.inspect
      end
    end
  end
end
