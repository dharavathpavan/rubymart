ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name
  filter :created_at

  form do |f|
    f.inputs "Category Details" do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row "Total Products" do |c|
        c.products.count
      end
      row :created_at
    end
    
    panel "Products in this Category" do
      table_for category.products do
        column :name
        column :price do |product|
          number_to_currency product.price
        end
        column :stock
        column "Image" do |product|
          if product.image.attached?
            image_tag url_for(product.image), height: '50'
          end
        end
      end
    end
  end
end
