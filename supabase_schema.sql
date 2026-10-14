-- ============================================================
-- Hifz Academy — Supabase Schema
-- Run this in: Supabase Dashboard → SQL Editor → New query
-- ============================================================

-- Enable UUID extension (already enabled by default in Supabase)
-- create extension if not exists "uuid-ossp";

-- ── students ──────────────────────────────────────────────
create table if not exists students (
  id text primary key,
  name text,
  "group" text,
  juz int,
  active boolean default true,
  loginUsername text,
  loginHash text,
  loginSalt text,
  loginIter int,
  loginPassword text,
  progressReview boolean,
  progressNote text,
  progressNoteAck text,
  enrolledAt bigint,
  updatedAt bigint,
  extra jsonb
);

-- ── dailyRecords ──────────────────────────────────────────
create table if not exists "dailyRecords" (
  id text primary key,
  studentId text,
  date text,
  status text,
  legacyStatus text,
  remarks text,
  createdAt bigint,
  updatedAt bigint,
  extra jsonb
);

-- ── sessions ──────────────────────────────────────────────
create table if not exists sessions (
  id text primary key,
  studentId text,
  date text,
  sessionNo int,
  type text,
  juz text,
  "fromPage" text,
  "toPage" text,
  mistakes int,
  result text,
  remarks text,
  createdAt bigint,
  extra jsonb
);

-- ── achievements ──────────────────────────────────────────
create table if not exists achievements (
  id text primary key,
  studentId text,
  date text,
  stars int,
  reason text,
  createdAt bigint,
  extra jsonb
);

-- ── tallies ───────────────────────────────────────────────
create table if not exists tallies (
  id text primary key,
  studentId text,
  date text,
  count int,
  reason text,
  manual boolean,
  createdAt bigint,
  extra jsonb
);

-- ── requests ──────────────────────────────────────────────
create table if not exists requests (
  id text primary key,
  studentId text,
  type text,
  date text,
  reason text,
  legacyReason text,
  status text,
  resolvedAt bigint,
  createdAt bigint,
  extra jsonb
);

-- ── competitions ──────────────────────────────────────────
create table if not exists competitions (
  id text primary key,
  name text,
  date text,
  marks jsonb,
  "marksEnteredAt" bigint,
  createdAt bigint,
  extra jsonb
);

-- ── users (teachers) ──────────────────────────────────────
create table if not exists users (
  id text primary key,
  name text,
  username text,
  "loginHash" text,
  "loginSalt" text,
  "loginIter" int,
  active boolean default true,
  permissions jsonb,
  "scopeAll" boolean default true,
  "studentIds" jsonb,
  "createdAt" bigint,
  extra jsonb
);

-- ── juzCompletions ────────────────────────────────────────
create table if not exists "juzCompletions" (
  id text primary key,
  "studentId" text,
  kind text,
  juz int,
  cycle int,
  "completedAt" bigint,
  extra jsonb
);

-- ── auditLog ──────────────────────────────────────────────
create table if not exists "auditLog" (
  id text primary key,
  action text,
  kind text,
  "entryId" text,
  "studentId" text,
  "entryDate" text,
  "removedQuantity" int,
  before jsonb,
  at bigint,
  by text,
  extra jsonb
);

-- ── settings ──────────────────────────────────────────────
create table if not exists settings (
  id text primary key,   -- 'admin'
  username text,
  hash text,
  salt text,
  iter int,
  "isDefault" boolean,
  "updatedAt" bigint,
  extra jsonb
);

-- ============================================================
-- Row Level Security — allow full access via anon key
-- (for a private academy app this is fine; tighten later)
-- ============================================================
alter table students enable row level security;
alter table "dailyRecords" enable row level security;
alter table sessions enable row level security;
alter table achievements enable row level security;
alter table tallies enable row level security;
alter table requests enable row level security;
alter table competitions enable row level security;
alter table users enable row level security;
alter table "juzCompletions" enable row level security;
alter table "auditLog" enable row level security;
alter table settings enable row level security;

-- Grant anon key full access (the app handles its own auth)
create policy "anon_all_students"      on students          for all to anon using (true) with check (true);
create policy "anon_all_dailyRecords"  on "dailyRecords"    for all to anon using (true) with check (true);
create policy "anon_all_sessions"      on sessions          for all to anon using (true) with check (true);
create policy "anon_all_achievements"  on achievements      for all to anon using (true) with check (true);
create policy "anon_all_tallies"       on tallies           for all to anon using (true) with check (true);
create policy "anon_all_requests"      on requests          for all to anon using (true) with check (true);
create policy "anon_all_competitions"  on competitions      for all to anon using (true) with check (true);
create policy "anon_all_users"         on users             for all to anon using (true) with check (true);
create policy "anon_all_juzCompletions" on "juzCompletions" for all to anon using (true) with check (true);
create policy "anon_all_auditLog"      on "auditLog"        for all to anon using (true) with check (true);
create policy "anon_all_settings"      on settings          for all to anon using (true) with check (true);
