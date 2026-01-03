# Local Setup Instructions

Since I cannot run the server directly (Ruby is missing in this terminal environment), follows these steps to run the app locally:

1. **Install Ruby**:
   - Download **Ruby+Devkit** from [RubyInstaller](https://rubyinstaller.org/downloads/).
   - Run the installer and **check "Add Ruby executables to your PATH"**.

2. **Run the App**:
   - Open the folder `c:\website\ruby_mart`.
   - Double-click **`run_local.bat`**.
   
   *OR manually run:*
   ```powershell
   bundle install
   rails db:create
   rails db:migrate
   rails db:seed
   rails s
   ```

3. **Access**:
   - Open browser: [http://localhost:3000](http://localhost:3000)
   - Admin Login: `admin@rubymart.com` / `password`
