ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock, :category_id, :image

  scope :all
  scope :low_stock do |products|
    products.where('stock < ?', 10)
  end

  index do
    selectable_column
    id_column
    column :image do |product|
      if product.image.attached?
        image_tag url_for(product.image), height: '50'
      else
        div class: "empty-image" do "No Image" end
      end
    end
    column :name
    column :category
    column :price do |product|
      number_to_currency product.price
    end
    column :stock do |product|
      if product.stock < 10
        span product.stock, class: "status_tag no"
      else
        product.stock
      end
    end
    actions
  end

  filter :name
  filter :category
  filter :price
  filter :stock

  form do |f|
    f.inputs "Product Components" do
      f.input :category
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), height: '100') : content_tag(:span, "Upload an image")
    end
    f.actions
  end
  
  show do
    attributes_table do
      row :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), height: '200'
        end
      end
      row :name
      row :category
      row :description
      row :price do |product|
        number_to_currency product.price
      end
      row :stock
    end
  end
end
