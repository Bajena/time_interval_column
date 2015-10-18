module TimeIntervalColumn
  InvalidIntervalType = Class.new(StandardError)
  InvalidIntervalValue = Class.new(StandardError)

  extend ActiveSupport::Concern

  module ClassMethods
    def time_interval_column(column_name, options = {})
      attr_accessible "#{column_name}_type".to_sym, "#{column_name}_value".to_sym if options[:attr_accessible] == true

      if !kind_of?(Enumerize)
        extend Enumerize
      end

      enumerize "#{column_name}_type".to_sym, in: { year: 0, month: 1, day: 2, hour: 3, minute: 4, second: 5 }

      class_eval <<-EOF
        def #{column_name}
          return if #{column_name}_value.blank?

          if ['year', 'month', 'day', 'hour', 'minute', 'second'].include?(#{column_name}_type)
            #{column_name}_value.send(#{column_name}_type)
          else
            raise InvalidIntervalType, "Unknown interval type:" + #{column_name}_type
          end
        end

        def #{column_name}=(value)
          if value.nil?
            self.#{column_name}_value = nil
            return
          end

          parts = value.inspect.split
          i_value = parts[0].try(:to_i)
          i_type  = parts[1]

          self.#{column_name}_type = case i_type
          when 'year', 'years'
            'year'
          when 'month', 'months'
            'month'
          when 'day', 'days'
            'day'
          when 'hour', 'hours'
            'hour'
          when 'minute', 'minutes'
            'minute'
          when 'second', 'seconds'
            if i_value % 3600 == 0
              i_value /= 3600
              'hour'
            elsif i_value % 60 == 0
              i_value /= 60
              'minute'
            else
              'second'
            end
          else
            raise InvalidIntervalValue, "Invalid time interval value (Must be in format of ActiveSupport::Duration)"
          end

          self.#{column_name}_value = i_value

          #{column_name}
        end
      EOF
    end
  end
end

ActiveRecord::Base.send :include, TimeIntervalColumn