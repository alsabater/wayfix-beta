module CalendarHelper	
	def monthCalendar(date = Date.today, &block)
		Calendar.new(self, date, block).table
	end

	class Calendar < Struct.new(:view, :date, :callback)
		HEADER = %w[Lunes Martes Miércoles Jueves Viernes Sábado Domingo]
		START_DAY = :monday 

		delegate :content_tag, to: :view

		def table
			content_tag :table, class: "calendar" do
				header + week_rows
			end
		end

		def header
			content_tag :tr do
				HEADER.map{ |day| content_tag :th, day }.join.html_safe
			end
		end

		def week_rows
			weeks.map do |week|
				content_tag :tr do
					week.map{ |day| day_cell(day) }.join.html_safe
				end
			end.join.html_safe
		end

		def day_cell(day)
			content_tag :td, view.capture(day, &callback), class: day_classes(day)
		end

		def day_classes(day)
			classes = []
			classes << "today" if day == Date.today
			classes << "notmonth" if day.month != date.month
			classes.empty? ? nil : classes.join(" ")
		end

		def weeks
			first = date.at_beginning_of_month.at_beginning_of_week(START_DAY)
			last = date.at_end_of_month.at_end_of_week(START_DAY)
			(first..last).to_a.in_groups_of(7)
		end
	end

	class WeeklyCalendar < Calendar
		def weeks
			first = date.at_beginning_of_week(START_DAY)
			last = date.at_end_of_week
			(first..last).to_a.in_groups_of(7)
		end
	end

	class DailyCalendar < Calendar
		def weeks
			first = date.at_beginning_of_week(START_DAY)
			last = date.at_end_of_week
			(first..last).to_a.in_groups_of(7)
		end
	end

end