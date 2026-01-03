# Create Admin User
if User.where(email: 'admin@rubymart.com').empty?
  User.create!(
    email: 'admin@rubymart.com',
    password: 'password',
    password_confirmation: 'password',
    role: :admin
  )
  puts "Admin user created: admin@rubymart.com / password"
end

# Ensure Categories exist
categories_data = ['Electronics', 'Clothing', 'Home & Kitchen', 'Sports & Outdoors', 'Beauty & Health']
categories = {}

categories_data.each do |cat_name|
  categories[cat_name] = Category.find_or_create_by!(name: cat_name)
end
puts "Categories calibrated."

# Helper to create product if not exists
def create_product(category, name, price, stock, description)
  Product.find_or_create_by!(name: name) do |p|
    p.category = category
    p.price = price
    p.stock = stock
    p.description = description
  end
end

# --- Electronics ---
create_product(categories['Electronics'], 'Ultra 4K Smart TV', 799.99, 15, 'Experience cinematic clarity with our latest 55-inch 4K HDR Smart TV.')
create_product(categories['Electronics'], 'Noise-Cancelling Headphones Pro', 249.99, 30, 'Immersive sound with active noise cancellation and 30-hour battery life.')
create_product(categories['Electronics'], 'Smartphone Galaxy Z', 999.99, 10, 'Foldable display technology meets flagship performance.')
create_product(categories['Electronics'], 'Wireless Earbuds Basic', 49.99, 100, 'Crystal clear audio with compact charging case.')
create_product(categories['Electronics'], 'Gaming Laptop Xtreme', 1499.99, 5, 'High-performance gaming with RTX graphics and 144Hz display.')

# --- Clothing ---
create_product(categories['Clothing'], 'Classic Denim Jacket', 89.99, 50, 'Timeless style with durable denim and comfortable fit.')
create_product(categories['Clothing'], 'Cotton Crew Neck T-Shirt', 24.99, 200, 'Premium organic cotton essential tee available in multiple colors.')
create_product(categories['Clothing'], 'Athletic Running Sneakers', 119.99, 45, 'Lightweight, breathable, and designed for maximum impact absorption.')
create_product(categories['Clothing'], 'Wool Blend Coat', 199.99, 20, 'Elegant winter coat keeping you warm and stylish.')
create_product(categories['Clothing'], 'Slim Fit Chinos', 59.99, 60, 'Versatile trousers suitable for both office and casual weekends.')

# --- Home & Kitchen ---
create_product(categories['Home & Kitchen'], 'Smart Coffee Maker', 129.99, 25, 'WiFi-enabled coffee machine. Schedule your brew from your phone.')
create_product(categories['Home & Kitchen'], 'Robotic Vacuum Cleaner', 299.99, 12, 'Keep your floors spotless with automated mapping and self-charging.')
create_product(categories['Home & Kitchen'], 'Ceramic Cookware Set', 149.99, 20, 'Non-stick, eco-friendly ceramic pots and pans for healthy cooking.')
create_product(categories['Home & Kitchen'], 'Modern LED Floor Lamp', 79.99, 35, 'Adjustable brightness and color temperature for any mood.')

# --- Sports ---
create_product(categories['Sports & Outdoors'], 'Yoga Mat Premium', 34.99, 80, 'Non-slip, extra thick yoga mat for ultimate comfort during practice.')
create_product(categories['Sports & Outdoors'], 'Dumbbell Set Adjustable', 199.99, 10, 'Space-saving adjustable weights ranging from 5 to 50 lbs.')
create_product(categories['Sports & Outdoors'], 'Camping Tent 4-Person', 149.99, 15, 'Waterproof and easy-setup tent for your next outdoor adventure.')

# --- Beauty ---
create_product(categories['Beauty & Health'], 'Organic Face Serum', 45.00, 50, 'Rejuvenating vitamin C serum for glowing skin.')
create_product(categories['Beauty & Health'], 'Electric Toothbrush Sonic', 69.99, 40, 'Advanced sonic technology for a dentist-clean feeling every day.')

puts "Inventory fully stocked with realistic products."
