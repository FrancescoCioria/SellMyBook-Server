# encoding: utf-8

require "./parse_setup_lib.rb"
require "./parse_setup_schema.rb"

class ParseSetupBookBazaar < ParseSetup

	def load_parse

		university({name: "Hogwarts"}) do |hogwarts|
		  campus({university: hogwarts, name: "Main Castle"})
		  campus({university: hogwarts, name: "Egyptian Campus"})
		  campus({university: hogwarts, name: "Underwater Mermaid Area"})
		  campus({university: hogwarts, name: "Scottish Wasteland"})
		  
		  batch_create {
			  professor({university: hogwarts, first_name: "albus", last_name: "dumbledore"})
			  professor({university: hogwarts, first_name: "severus", last_name: "snape"})
			  professor({university: hogwarts, first_name: "filius", last_name: "flitwick"})
			  professor({university: hogwarts, first_name: "rubeus", last_name: "hagrid"})
			  professor({university: hogwarts, first_name: "alastor", last_name: "moody"})
		  }
		end

		university({name: "Durmstrang"}) do |durmstrang|
		  campus({university: durmstrang, name: "Unplottable Fortress"})
		  campus({university: durmstrang, name: "Underwater Ship"})
		  
		  professor({university: durmstrang, first_name: "igor", last_name: "karkaroff"})
		  professor({university: durmstrang, first_name: "gellert", last_name: "poliakoff"})
		end
	end

end

bazaar = ParseSetupBookBazaar.new
bazaar.init_parse
bazaar.clear_parse
bazaar.load_parse