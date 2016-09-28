# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  TSV_NEWLINE = "\n".freeze
  TSV_TAB = "\t".freeze

  def tsv_to_array(tsv)
    tsv.split(TSV_NEWLINE).map { |line| line.split(TSV_TAB) }
  end

  def array_to_hash(array)
    array[1..-1].map { |row| array.first.zip(row).to_h }
  end

  def hash_to_array(hash)
    [hash.first.keys] + hash.map(&:values)
  end

  def array_to_tsv(array)
    array.map { |row| row.join(TSV_TAB) }
         .join(TSV_NEWLINE) << TSV_NEWLINE
  end

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    @data = array_to_hash tsv_to_array tsv
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    array_to_tsv hash_to_array(data)
  end
end
