module ProducsHelper
  def display_pictures(imgs_str)
    content_tag(:ul, class: ['pictures', 'w-100' ]) do
      imgs_str.split(',').map.with_index do |src, i|
        content_tag(:li, class: ["#{i > 0 ? 'd-none' : 'd-block'}"], data: { order: i }) do
          content_tag(:img, '', src: src).html_safe
        end
      end.join.html_safe
    end
  end

  def display_miniatures(imgs_str)
    content_tag(:ul, class: ['miniatures', 'w-100', 'row', 'list-unstyled' ]) do
      imgs_str.split(',').map.with_index do |src, i|
        content_tag(:li, class: ['d-inline', 'col'], style: 'width: 25%; height: 25%', data: { order: i, action: 'click->product#display' }) do
          content_tag(:img, '', src: src, class: 'img-fluid').html_safe
        end
      end.join.html_safe
    end
  end
end
