# frozen_string_literal: true

module ApexCharts::Options
  class FillOptions < Schema
    define do
      optional(:colors)
      optional(:gradient)
      optional(:image)
      optional(:opacity)
      optional(:pattern)
      optional(:type)
    end
  end
end
