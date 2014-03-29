module JobPostingsHelper
 def major_currencies(hash)
      hash.inject([]) do |array, (id, attributes)|
      priority = attributes[:priority]
      if priority && priority < 10
        array ||= []
        array << [attributes[:name], attributes[:symbol],attributes[:iso_code]]
      end
      array
    end
  end

  def all_currencies(hash)
    hash.inject([]) do |array, (id, attributes)|
      array ||= []
      array << [attributes[:name], attributes[:symbol], attributes[:iso_code]]
      array
    end
  end
end
