# Ruby Mart - E-Commerce Application

A production-ready E-Commerce application built with Ruby on Rails 7.

## Tech Stack
- **Framework:** Ruby on Rails 7
- **Database:** PostgreSQL
- **Authentication:** Devise
- **Authorization:** Pundit
- **Admin:** ActiveAdmin
- **Payments:** Stripe
- **Frontend:** Bootstrap (via cssbundling-rails)

## Setup
1. **Install Dependencies:**
   ```bash
   bundle install
   yarn install # or npm install
   ```

2. **Database Setup:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

3. **Environment Config:**
   Create a `.env` file in the root directory:
   ```env
   STRIPE_PUBLISHABLE_KEY=pk_test_...
   STRIPE_SECRET_KEY=sk_test_...
   ```

4. **Run Server:**
   ```bash
   bin/dev
   ```

## User Roles
- **Customer:** Can browse and purchase products.
- **Admin:** Managed via ActiveAdmin at `/admin`.
