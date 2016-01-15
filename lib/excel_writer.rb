
require 'axlsx'

class ExcelWriter

  @date_style
  @link_style

  def build_excel_file(file_name, all_results)
    p = Axlsx::Package.new
    wb = p.workbook
    write_auction_results(wb, all_results)
    p.serialize(file_name)
  end

  def setup_row_styles(wb)
    date = nil

    wb.styles do |style|
      @date_style = style.add_style(:num_fmt => Axlsx::NUM_FMT_YYYYMMDDHHMMSS)
      @link_style = style.add_style(:fg_color => '0000FF')
      # date = style.add_style(:format_code => "yy-mm-dd HH:MM:TT")
    end
  end

  def write_auction_results(wb, all_results)
    auction_sheet = wb.add_worksheet(:name => "Auctions")
    bin_sheet = wb.add_worksheet(:name => "BIN")
    setup_row_styles(wb)

    auction_sheet.add_row ["Type", "Date", "Price", "Title", "ViewItemURL"]
    bin_sheet.add_row ["Type", "Date", "Price", "Title", "ViewItemURL"]
    all_results.each do |result|
        row_result = create_row_array(result)
        if result[:type].include?("BIN")
          bin_sheet.add_row(row_result, :style => [nil, @date_style])
        else
          auction_sheet.add_row(row_result, :style => [nil,@date_style])
        end
    end

    auction_sheet.column_widths(nil, 20, nil, 60, 60)
    bin_sheet.column_widths(nil, 20, nil, 60, 60)
  end

  def create_row_array(result)
    row_result = []
    row_result.push(result[:type])
    row_result.push(Time.parse(result[:end_time]))
    row_result.push(result[:current_price])
    row_result.push(result[:title])
    row_result.push(result[:view_item_url])
    row_result
  end

end
