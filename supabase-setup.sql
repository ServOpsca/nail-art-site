-- =====================================================
--  C&D Nail@rt – Supabase Database Setup Script
--  Run this in your Supabase SQL Editor
-- =====================================================

-- 1. GALLERY TABLE
CREATE TABLE IF NOT EXISTS gallery (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title       TEXT,
  description TEXT,
  category    TEXT DEFAULT 'other',
  image_url   TEXT NOT NULL,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- 2. SERVICES TABLE
CREATE TABLE IF NOT EXISTS services (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  description TEXT,
  price       TEXT,
  duration    TEXT,
  icon        TEXT DEFAULT '💅',
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- 3. BOOKINGS TABLE
CREATE TABLE IF NOT EXISTS bookings (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name     TEXT NOT NULL,
  last_name      TEXT,
  email          TEXT NOT NULL,
  phone          TEXT,
  service        TEXT,
  preferred_date DATE,
  notes          TEXT,
  status         TEXT DEFAULT 'new',
  created_at     TIMESTAMPTZ DEFAULT now()
);

-- =====================================================
--  ROW LEVEL SECURITY (RLS) POLICIES
-- =====================================================

-- Enable RLS
ALTER TABLE gallery  ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- GALLERY: Public can read, only authenticated users can write
CREATE POLICY "Public can view gallery"
  ON gallery FOR SELECT TO anon, authenticated USING (true);

CREATE POLICY "Authenticated can insert gallery"
  ON gallery FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Authenticated can delete gallery"
  ON gallery FOR DELETE TO authenticated USING (true);

CREATE POLICY "Authenticated can update gallery"
  ON gallery FOR UPDATE TO authenticated USING (true);

-- SERVICES: Public can read, only authenticated users can write
CREATE POLICY "Public can view services"
  ON services FOR SELECT TO anon, authenticated USING (true);

CREATE POLICY "Authenticated can insert services"
  ON services FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Authenticated can delete services"
  ON services FOR DELETE TO authenticated USING (true);

-- BOOKINGS: Anyone can insert, only authenticated can read
CREATE POLICY "Anyone can book"
  ON bookings FOR INSERT TO anon, authenticated WITH CHECK (true);

CREATE POLICY "Authenticated can view bookings"
  ON bookings FOR SELECT TO authenticated USING (true);

CREATE POLICY "Authenticated can update booking status"
  ON bookings FOR UPDATE TO authenticated USING (true);

-- =====================================================
--  STORAGE BUCKET SETUP
--  Run this in Supabase Dashboard → Storage → New Bucket
--  OR via SQL:
-- =====================================================

-- Create storage bucket (run in SQL editor or via Dashboard)
INSERT INTO storage.buckets (id, name, public)
VALUES ('nail-art-photos', 'nail-art-photos', true)
ON CONFLICT (id) DO NOTHING;

-- Storage policies
CREATE POLICY "Public can view photos"
  ON storage.objects FOR SELECT TO anon, authenticated
  USING (bucket_id = 'nail-art-photos');

CREATE POLICY "Authenticated can upload photos"
  ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'nail-art-photos');

CREATE POLICY "Authenticated can delete photos"
  ON storage.objects FOR DELETE TO authenticated
  USING (bucket_id = 'nail-art-photos');

-- =====================================================
--  REALTIME SUBSCRIPTIONS
--  Enable realtime on these tables in Supabase Dashboard
--  Database → Replication → Supabase Realtime → Add tables:
--  ✅ gallery  ✅ services  ✅ bookings
-- =====================================================
