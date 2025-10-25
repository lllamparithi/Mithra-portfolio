/*
  # Create Contact Submissions Table

  1. New Tables
    - `contact_submissions`
      - `id` (uuid, primary key) - Unique identifier for each submission
      - `name` (text) - Full name of the person contacting
      - `email` (text) - Email address of the contact
      - `service` (text) - Type of service they're interested in
      - `message` (text) - Project details and requirements
      - `created_at` (timestamptz) - Timestamp when submission was created
      - `status` (text) - Status of the inquiry (new, contacted, completed)
      
  2. Security
    - Enable RLS on `contact_submissions` table
    - Add policy for public to insert their contact information
    - Add policy for authenticated users to view all submissions
*/

CREATE TABLE IF NOT EXISTS contact_submissions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  service text NOT NULL,
  message text NOT NULL,
  status text DEFAULT 'new',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;

-- Allow anyone to submit contact forms
CREATE POLICY "Anyone can submit contact form"
  ON contact_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Allow authenticated users to view all submissions
CREATE POLICY "Authenticated users can view submissions"
  ON contact_submissions
  FOR SELECT
  TO authenticated
  USING (true);

-- Allow authenticated users to update status
CREATE POLICY "Authenticated users can update submissions"
  ON contact_submissions
  FOR UPDATE
  TO authenticated
  USING (true)
  WITH CHECK (true);