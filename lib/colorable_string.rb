module ColorableString
  RGB_COLOR_MAP = {
    pink: "255;97;136",
    orange: "252;152;103",
    yellow: "255;216;102",
    green: "169;220;118",
    cyan: "120;220;232",
    purple: "171;157;242"
  }.freeze

  refine String do
    def fg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[38;2;#{rgb_val}m#{self}\e[0m"
    end

    def bg_color(color_name)
      rgb_val = RGB_COLOR_MAP[color_name]
      "\e[48;2;#{rgb_val}m#{self}\e[0m"
    end
  end
end
