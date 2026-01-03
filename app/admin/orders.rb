ActiveAdmin.register Order do
  actions :all, except: [:new, :create, :destroy]
  permit_params :status

  index do
    selectable_column
    id_column
    column :user
    column :total_price do |order|
      number_to_currency order.total_price
    end
    column :status do |order|
      status_tag order.status, class: order.status == 'paid' ? 'yes' : 'no' 
    end
    column :items_count do |order|
      order.order_items.sum(:quantity)
    end
    column :created_at
    actions
  end

  filter :user
  filter :status, as: :select, collection: Order.statuses.keys
  filter :created_at
  filter :total_price

  show do
    attributes_table do
      row :id
      row :user
      row :total_price do |order|
        number_to_currency order.total_price
      end
      row :status do |order|
         status_tag order.status, class: order.status == 'paid' ? 'yes' : 'no'
      end
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product do |item|
          link_to item.product.name, admin_product_path(item.product)
        end
        column :quantity
        column :price do |item|
          number_to_currency item.price
        end
        column :total_price do |item|
          number_to_currency item.total_price
        end
        column "Image" do |item|
           if item.product.image.attached?
             image_tag url_for(item.product.image), height: '50'
           else
             image_tag "https://placehold.co/50x50", height: '50'
           end
        end
      end
    end
  end

  sidebar "Customer Details", only: :show do
    attributes_table_for order.user do
      row :email
      row :role
      row("Total Orders") { order.user.orders.count }
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :status, as: :select, collection: Order.statuses.keys
    end
    f.actions
  end
end
