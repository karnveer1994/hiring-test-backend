module Entries
  def merge_and_sort(csv_files, order)
    csv_files.flat_map(&method(:csv_to_hash_array)).sort_by{ |row| row[order.to_s] }.map do |hash|
      hash['birthdate'] = Date.parse(hash['birthdate']).strftime('%-m/%-d/%Y') if hash['birthdate']
      hash
    end
  end

  def formatted_csv(sorted_hash_array)
    headers = ['first_name', 'city', 'birthdate']
    CSV.generate(col_sep: ', ', quote_char: '') do |merged_csv|
      sorted_hash_array.each do |row|
        merged_csv << row.values_at(*headers)
      end
    end
  end

  private

  def csv_to_hash_array(csv)
    csv.to_a[1..-1].map { |row| csv.headers.zip(row).to_h }
  end
end