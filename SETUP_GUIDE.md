# 🌸 C&D Nail@rt – Setup & Deployment Guide

## Step 1: Supabase Database Setup

1. Go to **https://supabase.com/dashboard** → Select your project
2. Navigate to **SQL Editor** (left sidebar)
3. Click **"New Query"**
4. Copy the entire contents of `supabase-setup.sql` and paste it in
5. Click **"Run"** ✅

### Enable Realtime (important for live updates):
1. Go to **Database → Replication**
2. Under **"Supabase Realtime"**, enable these tables:
   - ✅ `gallery`
   - ✅ `services`
   - ✅ `bookings`

### Create Storage Bucket (if not created by SQL):
1. Go to **Storage** in left sidebar
2. Click **"New Bucket"**
3. Name: `nail-art-photos`
4. ✅ Check **"Public bucket"**
5. Click **Create**

---

## Step 2: Create Admin User

1. Go to **Authentication → Users** in Supabase
2. Click **"Add User"**
3. Enter your admin email and a strong password
4. Click **"Create User"**

> This user will be used to log into the Admin Panel on the website.

---

## Step 3: Upload to GitHub

```bash
# 1. Create a new folder and move your files there
mkdir cd-nailart-website
cd cd-nailart-website
cp /path/to/index.html .
cp /path/to/supabase-setup.sql .

# 2. Initialize Git
git init
git add .
git commit -m "Initial commit: C&D Nail@rt website"

# 3. Create a new GitHub repository at https://github.com/new
#    Name it: cd-nailart  (or any name you prefer)
#    Keep it Public or Private

# 4. Connect and push
git remote add origin https://github.com/YOUR-USERNAME/cd-nailart.git
git branch -M main
git push -u origin main
```

---

## Step 4: Deploy on Netlify

### Option A – Netlify Drag & Drop (Fastest):
1. Go to **https://netlify.com** → Log in
2. Click **"Add new site" → "Deploy manually"**
3. Drag your project folder onto the drop zone
4. 🎉 Your site is live in seconds!

### Option B – Connect to GitHub (Recommended for auto-deploy):
1. Go to **https://netlify.com** → Log in
2. Click **"Add new site" → "Import an existing project"**
3. Click **"GitHub"** → Authorize Netlify
4. Select your `cd-nailart` repository
5. Set build settings:
   - **Build command:** *(leave empty)*
   - **Publish directory:** `.` (or leave as is)
6. Click **"Deploy site"** ✅

### Custom Domain (Optional):
1. In Netlify → **Domain settings**
2. Add your custom domain
3. Follow DNS instructions

---

## How to Use the Admin Panel

1. Open your website
2. Click **"Admin"** in the navigation bar
3. Sign in with your Supabase credentials
4. You'll see the dashboard with 4 tabs:

| Tab | What you can do |
|-----|-----------------|
| **Upload Photos** | Upload new nail art photos to the gallery |
| **Manage Gallery** | View and delete existing photos |
| **Services** | Add or remove services (with price & duration) |
| **Bookings** | View all appointment requests from clients |

---

## Live Updates
- When you upload photos → **Gallery updates instantly** for all visitors
- When you add/remove services → **Services section updates live**
- When clients book → **You see it in Admin → Bookings tab**

---

## Tech Stack
- **Frontend:** Vanilla HTML, CSS, JavaScript (single file)
- **Database:** Supabase (PostgreSQL)
- **Storage:** Supabase Storage (for photos)
- **Auth:** Supabase Authentication
- **Realtime:** Supabase Realtime subscriptions
- **Hosting:** Netlify
