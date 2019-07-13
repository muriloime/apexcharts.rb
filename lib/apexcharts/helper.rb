require_relative 'series'
require_relative 'options_builder'
require_relative 'utils'
require_relative 'renderer'
require_relative 'charts'

module Apexcharts
  module Helper
    def line_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(LineChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def area_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(AreaChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def column_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(ColumnChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def bar_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(BarChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def scatter_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(ScatterChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def heatmap_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(HeatmapChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def bubble_chart series, options={}, &block
      bindings = eval("self", block.binding) if block_given?
      draw_chart(BubbleChart.new(bindings, *prepare_series_and_options(series, options), &block))
    end

    def radar_chart series, options={}
      draw_chart(RadarChart.new(nil, *prepare_series_and_options(series, options)))
    end

    def mixed_charts options={}, &block
      bindings = eval("self", block.binding)
      draw_chart(MixedCharts.new(bindings, deep_copy(options), &block))
    end
    alias_method :combo_charts, :mixed_charts

    def syncing_charts options={}, &block
      bindings = eval("self", block.binding)
      draw_chart(SyncingCharts.new(bindings, deep_copy(options), &block))
    end
    alias_method :synchronized_charts, :syncing_charts

    def pie_chart series, options={}
      draw_chart(PieChart.new(*prepare_series_and_options(series, options)))
    end

    def donut_chart series, options={}
      draw_chart(DonutChart.new(*prepare_series_and_options(series, options)))
    end

    def radial_bar_chart series, options={}
      draw_chart(RadialBarChart.new(*prepare_series_and_options(series, options)))
    end
    alias_method :circle_chart, :radial_bar_chart

  private

    def draw_chart chart
      chart = chart.render
      chart.respond_to?(:html_safe) ? chart.html_safe : chart
    end

    def prepare_series_and_options series, options
      series = deep_copy(series)
      options = deep_copy(options)
      options[:id] ||= apexcharts_id
      [series, options]
    end

    def apexcharts_id
      @_apexcharts_id ||= 0
      @_apexcharts_id += 1
      "chart-#{@_apexcharts_id}"
    end

    def apexcharts_group
      @_apexcharts_group ||= 0
      @_apexcharts_group += 1
      "chart-group-#{@_apexcharts_group}"
    end

    def deep_copy(options)
      Marshal.load(Marshal.dump(options))
    end
  end
end
