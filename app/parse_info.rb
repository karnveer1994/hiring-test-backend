require 'csv'

module ParseInfo
  def parse(params)
    [CSV.parse(params[:dollar_format].gsub(' $ ', ',').gsub('LA', 'Los Angeles').gsub('NYC', 'New York City'), headers: true), CSV.parse(params[:percent_format].gsub(' % ', ','), headers: true)]
  end
end
