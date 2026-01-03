ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # --- Management Console ---
    columns do
      column do
        panel "Quick Actions" do
          div style: "display: flex; gap: 15px; padding: 10px 0;" do
            link_to new_admin_product_path, class: "button" do
              span "➕ Add New Product"
            end
            link_to new_admin_category_path, class: "button" do
               span "📂 Add Category"
            end
            link_to admin_products_path, class: "button" do
               span "📦 View Inventory"
            end
          end
        end
      end
    end

    # --- KPI Stats ---
    columns do
      column do
        panel "Calculated Revenue" do
          div class: "dashboard-stat positive" do
            h1 number_to_currency(Order.where(status: :paid).sum(:total_price))
            span "Total Paid Revenue"
          end
        end
      end

      column do
        panel "Total Orders" do
           div class: "dashboard-stat neutral" do
            h1 Order.count
            span "#{Order.where(status: :paid).count} Paid"
          end
        end
      end

      column do
        panel "Total Customers" do
           div class: "dashboard-stat neutral" do
            h1 User.where(role: :customer).count
            span "Registered Users"
          end
        end
      end

      column do
        panel "Low Stock Alert" do
          low_stock_count = Product.where("stock < ?", 10).count
           div class: "dashboard-stat negative" do
            h1 low_stock_count
            span "Products needing restock"
          end
        end
      end
    end

    # --- Recent Activity ---
    columns do
      column do
        panel "Recent Orders" do
          table_for Order.order(created_at: :desc).limit(10) do
            column("Order ID") { |order| link_to "Order ##{order.id}", admin_order_path(order) }
            column :user
            column :status do |order|
              status_tag order.status, class: order.status == 'paid' ? 'yes' : 'no'
            end
            column :total_price do |order|
              number_to_currency order.total_price
            end
          end
        end
      end

      column do
        panel "New Customers" do
          table_for User.where(role: :customer).order(created_at: :desc).limit(10) do
            column :email
            column :created_at
            column("") { |user| link_to "View", admin_user_path(user) }
          end
        end
      end
    end
  end
end
