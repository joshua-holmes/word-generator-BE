require "pry"
class Dictionary < ActiveRecord::Base
    belongs_to :user

    def parse_words
        self.words.split(",")
    end

    def generate_stats(segment)
        def add_combo_to_array(str, arr)
            if arr.find { |c| c[:id] == str }
                index = arr.index arr.find { |c| c[:id] == str }
                arr[index][:total] += 1
            else
                arr << { id: str, total: 1 }
            end
        end
        def count_combos_matching(segment)
            returned_arr = []
            words = self.parse_words
            words.each do |word|
                case segment
                when String
                    num_of_combos = word.length - segment.length
                    num_of_combos.times do |i|
                        combo = word.slice(i, segment.length + 1)
                        segment_in_combo = combo.slice(0, combo.length - 1) == segment
                        add_combo_to_array(combo, returned_arr) if segment_in_combo
                    end
                when Integer
                    num_of_combos = word.length - segment + 1
                    num_of_combos.times do |i|
                        combo = word.slice(i, segment)
                        add_combo_to_array(combo, returned_arr)
                    end
                else # Finds starting letter stats
                    1.times do
                        combo = word.first
                        add_combo_to_array(combo, returned_arr)
                    end
                end
            end
            returned_arr
        end
        def get_ratios_from(arr)
            returned_arr = arr.deep_dup
            total_combos = returned_arr.sum { |c| c[:total] }
            returned_arr.each { |c| c[:ratio] = c[:total].to_f / total_combos }
        end
        combos_totals = count_combos_matching segment
        complete_combos_data = get_ratios_from combos_totals
        complete_combos_data.sort_by { |c| c[:id] }
    end

    def get_letter(segment)
        # Initialization
        returned_letter = ""
        new_segment = segment.dup
        stats = []
        breakpoint = 0.0
        rand_num = rand
        # Looping until valid stats are gathered
        loop do
            stats = self.generate_stats new_segment
            break if stats.length > 0
            new_segment.slice!(0)
        end
        puts "'#{new_segment}' was used as segment"
        # Find letter based on stats
        stats.find do |s|
            breakpoint += s[:ratio]
            breakpoint > rand_num
        end[:id].last
    end

    def get_word(length)
        returned_word = ""
        length.times do |i|
            if i == 0
                returned_word += self.get_letter nil
            else
                returned_word += self.get_letter returned_word
            end
        end
        returned_word
    end
end