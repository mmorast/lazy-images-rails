require 'lazy_images/rails/placeholder'

module LazyImages
  module Rails
    mattr_accessor :placeholder

    module TagHelper
      def self.included(base)
        base.send(:include, LazyImages::Rails::TagHelper)
      end

      def image_tag_with_lazy_images(source, options={})
        options.merge!(
          class: "#{options[:class]}",
          src: path_to_image(source)
        )

        placeholder = LazyImages::Rails::Placeholder.new(
          LazyImages::Rails.placeholder, options
        )

        content_tag(:div, class: 'rli-wrapper') do
          (source ? image_tag_without_lazy_images(source, options)\
                  : placeholder.to_s.html_safe)
        end
      end
    end
  end
end
