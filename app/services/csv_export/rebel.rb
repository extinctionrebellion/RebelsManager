module CsvExport
  class Rebel < ExportGenerator
    def header
      [ "ID", "Joined", "Local Group", "Name", "Email", "Phone", "Profile URL", "Language", "Status", "Postcode", "Willingness to be arrested", "Arrests #", "Skills", "Working groups", "Tags", "Availability", "IRL", "Source", "Notes", "Internal notes", "Updated profile" ]
    end

    def extract_info(rebel)
      [
        rebel.id,
        rebel.created_at.strftime("%b %d %Y"),
        rebel.local_group&.name,
        rebel.name,
        rebel.email,
        rebel.phone,
        rebel.profile_url,
        rebel.language,
        rebel.status,
        rebel.postcode,
        rebel.willingness_to_be_arrested,
        rebel.number_of_arrests,
        rebel.skills&.pluck(:name)&.join(", "),
        rebel.working_groups&.pluck(:name)&.join(", "),
        rebel.tags&.join(", "),
        rebel.availability,
        rebel.irl,
        rebel.source,
        rebel.notes,
        rebel.internal_notes,
        rebel.self_updated_at&.strftime("%b %d %Y")
      ]
    end
  end
end
