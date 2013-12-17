# this operator/value has been discarded (but kept in the dom to override the one stored in the various links of the page)
return if operator == '_discard' || value == '_discard'

# filtering data with unary operator, not type dependent
if operator == '_blank' || value == '_blank'
  return ["(#{column} IS NULL OR #{column} = '')"]
elsif operator == '_present' || value == '_present'
  return ["(#{column} IS NOT NULL AND #{column} != '')"]
elsif operator == '_null' || value == '_null'
  return ["(#{column} IS NULL)"]
elsif operator == '_not_null' || value == '_not_null'
  return ["(#{column} IS NOT NULL)"]
elsif operator == '_empty' || value == '_empty'
  return ["(#{column} = '')"]
elsif operator == '_not_empty' || value == '_not_empty'
  return ["(#{column} != '')"]
end

# now we go type specific
case type
  when :boolean
    return ["(#{column} IS NULL OR #{column} = ?)", false] if ['false', 'f', '0'].include?(value)
    return ["(#{column} = ?)", true] if ['true', 't', '1'].include?(value)
  when :integer, :decimal, :float
    case value
      when Array then
        val, range_begin, range_end = *value.map do |v|
          if (v.to_i.to_s == v || v.to_f.to_s == v)
            type == :integer ? v.to_i : v.to_f
          else
            nil
          end
        end
        case operator
          when 'between'
            if range_begin && range_end
              ["(#{column} BETWEEN ? AND ?)", range_begin, range_end]
            elsif range_begin
              ["(#{column} >= ?)", range_begin]
            elsif range_end
              ["(#{column} <= ?)", range_end]
            end
          else
            ["(#{column} = ?)", val] if val
        end
      else
        if value.to_i.to_s == value || value.to_f.to_s == value
          type == :integer ? ["(#{column} = ?)", value.to_i] : ["(#{column} = ?)", value.to_f]
        else
          nil
        end
    end
  when :belongs_to_association
    return if value.blank?
    ["(#{column} = ?)", value.to_i] if value.to_i.to_s == value
  when :string, :text
    return if value.blank?
    value = case operator
              when 'default', 'like'
                "%#{value.downcase}%"
              when 'starts_with'
                "#{value.downcase}%"
              when 'ends_with'
                "%#{value.downcase}"
              when 'is', '='
                "#{value.downcase}"
              else
                return
            end
    ["(LOWER(#{column}) #{like_operator} ?)", value]
  when :date
    start_date, end_date = get_filtering_duration(operator, value)

    if start_date && end_date
      ["(#{column} BETWEEN ? AND ?)", start_date, end_date]
    elsif start_date
      ["(#{column} >= ?)", start_date]
    elsif end_date
      ["(#{column} <= ?)", end_date]
    end
  when :datetime, :timestamp
    start_date, end_date = get_filtering_duration(operator, value)

    if start_date && end_date
      ["(#{column} BETWEEN ? AND ?)", start_date.to_time.beginning_of_day, end_date.to_time.end_of_day]
    elsif start_date
      ["(#{column} >= ?)", start_date.to_time.beginning_of_day]
    elsif end_date
      ["(#{column} <= ?)", end_date.to_time.end_of_day]
    end
  when :enum
    return if value.blank?
    ["(#{column} IN (?))", Array.wrap(value)]
end
