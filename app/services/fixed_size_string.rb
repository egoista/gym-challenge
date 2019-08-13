# frozen_string_literal: true

class FixedSizeString
  def self.convert(string, size, center_allign: false)
    if center_allign
      string.to_s[0..size - 1].center(size)
    else
      string.to_s[0..size - 1].ljust(size)
    end
  end
end
