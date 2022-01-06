class Lexicon < ActiveRecord::Base
    has_many :lexicon_words
    has_many :words, through: :lexicon_words

    has_many :favorite_words

    def generate_stats(segment)
        def count_combos_matching(segment)
            returned_arr = []
            words = self.words.map {|w_instance| w_instance.word}
            words.each do |word|
                case segment
                when String
                    num_of_combos = word.length - segment.length
                    num_of_combos.times do |i|
                        combo = word.slice(i, segment.length + 1)
                        segment_in_combo = combo.slice(0, combo.length - 1) == segment
                        add_combo_to_array combo, returned_arr if segment_in_combo
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
                        add_combo_to_array combo, returned_arr
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

    def add_combo_to_array(str, arr)
        if arr.find { |c| c[:id] == str }
            index = arr.index arr.find { |c| c[:id] == str }
            arr[index][:total] += 1
        else
            arr << { id: str, total: 1 }
        end
    end

    def get_letter(segment, is_auto = false)
        # Initialization
        returned_letter = ""
        new_segment = segment.dup
        stats = []
        breakpoint = 0.0
        rand_num = rand
        # Looping until valid stats are gathered
        loop do
            stats = generate_stats new_segment
            break if stats.length > 0
            return nil if is_auto # Signifies to get_word method that this is the end of the word
            new_segment.slice!(0)
        end
        # Find letter based on stats
        stats.find do |s|
            breakpoint += s[:ratio]
            breakpoint > rand_num
        end[:id].last
    end

    def get_word(length = rand(6) + 3)
        # If length is 0, the length of the word will be set to automatic
        is_auto = length == 0
        if is_auto
            numberOf = 100
        else
            numberOf = length
        end
        returned_word = ""
        segment = ""
        end_of_word = false
        numberOf.times do |i|
            if i == 0
                returned_word += get_letter nil
                segment = returned_word
            elsif !end_of_word
                # segment var and this loop are both to help the algo run faster
                # by not checking for stats for the same segments every iteration
                while generate_stats(segment).length == 0
                    segment.slice!(0)
                end unless is_auto
                letter = get_letter segment, is_auto
                end_of_word = is_auto && !letter # End of word
                returned_word += letter unless end_of_word
                segment += letter unless end_of_word
            end
        end
        return returned_word unless words.find_by word: returned_word
        get_word length
    end
end