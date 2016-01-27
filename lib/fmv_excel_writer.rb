
require 'axlsx'

class FmvExcelWriter

  def build_excel_file(file_name, all_results)
    p = Axlsx::Package.new
    wb = p.workbook
    write_fmv_values(wb, all_results)
    p.serialize(file_name)
  end

  def freeze_top_row(sheet)
    ## Totally stolen from alsx site no clue how this works
    sheet.sheet_view.pane do |pane|
          pane.top_left_cell = "A2"
          pane.state = :frozen_split
          pane.y_split = 1
          pane.x_split = 0
          pane.active_pane = :bottom_right
    end
  end

  def write_fmv_values(wb, all_results)
    bold_with_background = wb.styles.add_style(bg_color: "E2D3EB", b: true)

    all_results.keys.each do |key|
      coin_value_sheet = wb.add_worksheet(:name => key.to_s)
      freeze_top_row(coin_value_sheet)
      coin_value_sheet.add_row(["Date", "MS61", "MS62", "MS63", "MS64", "MS65", "MS66", "MS67", "MS68", "MS69", "MS70"], :style => bold_with_background)

      year_values_hash = all_results[key]
      year_values_array = year_values_hash.keys[0..-2]
      year_values_array.each do |year_key|
        value_row = [year_key]
        year_values_hash[year_key].each { |single_value| value_row << single_value.to_s.gsub(/,/, "") }
        # need to use string to keep formatting look OK..  Values are mix of numbers and text
        type_array = [:string, :string, :string, :string, :string, :string, :string, :string, :string, :string, :string, :string]
        # type_array = [:string, :integer, :integer, :integer, :integer, :integer, :integer, :integer, :integer, :integer, :integer]
        coin_value_sheet.add_row(value_row, :types => type_array)
      end
    end
  end

end
