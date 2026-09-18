# HisabAI — Master Build Prompt

You are an expert product engineer, UX engineer, JavaScript engineer, Android/iOS wrapper engineer, offline-first data engineer, and QA engineer.

Build a production-quality personal finance application named **HisabAI** with the subtitle **Smart Personal Expense Manager**.

## 0. Non-negotiable product goals

1. The core app must remain a **single self-contained HTML file** that can be opened directly without Node, npm, React, Angular, Vue, .NET, a server, REST API, or a database server.
2. The single HTML file must be **offline-first**. The UI must not depend on Tailwind CDN, external CSS, external fonts, Chart.js CDN, SheetJS CDN, or any other network resource for core functionality.
3. Use embedded CSS and vanilla JavaScript. IndexedDB is the primary local database.
4. If external libraries are used as optional enhancements, the app must still work when they fail to load or there is no internet.
5. Never create fake buttons or fake features. Every visible action must work or clearly explain why it is unavailable.
6. The app must be comfortable on old Android phones such as **Redmi 9C**, modern Android phones such as **Redmi 13**, tablets such as **iPad 11th generation**, and desktop browsers.
7. The mobile layout must be mobile-first, not a desktop layout squeezed into a phone.

## 1. Branding

Official product spelling: **HisabAI**.

Use English/Latin script for the primary product name so the icon and wordmark remain globally readable. Bengali may be used as the localized app name/tagline.

Brand:
- HisabAI
- Smart Personal Expense Manager
- Owner: MD IKRAMUL ISLAM SIDDIQUE POROSH
- Title: SENIOR SOFTWARE ENGINEER
- Phone: +8801672896992

Use a premium, friendly, age-neutral, gender-neutral fintech/SaaS visual identity. The icon must work without text at small sizes. Avoid dollar-specific imagery. A subtle ledger/check/AI-spark visual is acceptable.

## 2. Offline-first architecture

Use these logical services inside the single file:

- App
- DatabaseService
- TransactionService
- CategoryService
- BalanceService
- ReportService
- AnalyticsService
- SpeechService
- ExportService
- BackupService
- PrintService
- SyncService
- LocalizationService
- UIService
- ValidationService
- Utilities

Use IndexedDB stores for:

- transactions
- categories
- balances
- settings
- optional sync metadata

The application must continue working with no network.

Do NOT use Tailwind CDN for core styling. Embed the required CSS directly in the HTML.

Do NOT make core reports/charts/export depend on Chart.js or SheetJS CDN. Either implement lightweight native CSS/SVG/canvas charts and an offline Excel-compatible SpreadsheetML `.xls` exporter, or bundle the libraries locally inside the single HTML file.

## 3. Category system

Implement unlimited nested categories:

Root → child → grandchild → deeper levels.

Every category must have:
- id
- English name
- Bengali name
- normalized English name
- normalized Bengali name
- parentId
- deleted flag
- timestamps

Example:

Food / খাবার
  Grocery / মুদিখানা
    Rice / চাল
    Oil / তেল
    Tea / চা

Transport / যাতায়াত
  Rickshaw Fare / রিকশা ভাড়া
  Bus / বাস
  CNG / সিএনজি

When creating or renaming a category:
- detect duplicates under the same parent
- compare normalized English and Bengali names
- prevent confusing duplicates
- show the complete existing path when a duplicate is found
- e.g. “Rice already exists under Food → Grocery → Rice / খাবার → মুদিখানা → চাল”
- never silently create a duplicate

Deletion must be safe:
- do not physically destroy historical category references
- soft-delete categories
- preserve the saved historical category path on transactions
- warn the user before deletion

Category creation UX:
- Add category
- choose root or any existing parent
- optional child/subchild creation
- allow unlimited nesting
- show parent path before saving
- allow creation directly from Add Expense without forcing the user to leave and lose the current transaction
- if a category is missing during Add Expense, show an “Add category” action at the bottom of the category selector/search area
- after creating the category, return to Add Expense and preserve all previously typed fields

Category names:
- store both English and Bengali names
- display according to current localization
- keep both values during export/import

## 4. Add Expense / Add Income

The Add Expense screen must be designed specifically for phones.

Required fields:
- date
- time
- amount
- quantity
- unit
- category
- payment method
- type
- note

Optional metadata fields:
- brand
- price per unit
- shop name
- shop location
- shop phone
- shop address
- journey started from
- journey ended at / destination
- journey started date/time
- journey ended date/time
- product photo

Product photo:
- accept camera/gallery images on supported devices
- preview before save
- store locally in IndexedDB or an appropriate local object store
- never require a server just to save the photo
- avoid crashing on large images; resize/compress before storage when practical

For travel/transport entries, support:
- From
- To
- Journey start time
- Journey end time

Do not require optional fields.

## 5. Duplicate transaction handling

Do NOT block legitimate repeated expenses just because they use the same category.

Example: buying rice today and buying rice again tomorrow must be allowed.

Detect only likely duplicate records, such as same:
- date
- time
- amount
- type
- category
- note

If a likely duplicate exists:
- warn the user
- explain that the same category can still be used multiple times
- provide “Save anyway” and “Cancel”
- never silently reject a valid repeated expense

## 6. Category-aware reports

Reports must support selecting a category and seeing its own data.

Add a checkbox/toggle:

**Include child categories / সাব-ক্যাটাগরিও ধরুন**

When OFF:
- only the selected category's own transactions

When ON:
- selected category + all descendants recursively

Example:

Food selected + Include child categories ON:
- Food
- Grocery
- Rice
- Oil
- Tea
- Restaurant
- etc.

Show:
- total expense
- transaction count
- average expense
- total quantity
- unit consumption
- category/subcategory breakdown
- transaction list
- product/shop/journey metadata where available
- percentage contribution

Support:
- today
- yesterday
- current week
- previous week
- first half of month
- second half of month
- current month
- previous month
- current year
- previous year
- custom date range

Also support period comparison.

## 7. Dashboard

Create a premium responsive dashboard with:
- today's expense
- today's income
- starting balance
- ending/current balance
- transaction count
- top categories
- recent transactions
- spending trend
- category breakdown
- monthly comparison

Charts must still degrade gracefully offline.

## 8. Transaction history

Support:
- search
- category filter
- transaction type filter
- date filtering
- amount sorting
- newest first
- oldest first
- edit
- delete with confirmation
- no silent deletion

Search must include useful metadata such as:
- category path
- note
- brand
- shop name
- journey from/to

For large datasets, do not render tens of thousands of rows at once. Use pagination or incremental rendering.

## 9. Voice command system

Voice command is a first-class feature.

Support natural Bangla and English commands such as:

- “রিকশা ভাড়া ৮০ টাকা”
- “আজ ৫ কেজি চাল ৪৫০ টাকা”
- “বাজার থেকে ১ লিটার তেল ১৯০ টাকা”
- “রিকশায় আতি বাজার থেকে কেরানীগঞ্জ ৮০ টাকা”
- “add 500 taka grocery”

Extract where possible:
- intent
- amount
- quantity
- unit
- category
- category path
- date
- time
- note
- journey from
- journey to

Use smart category matching:
1. exact English
2. exact Bengali
3. normalized name
4. synonym map
5. fuzzy/semantic fallback if available locally

If category is not found:
- do NOT create a random category silently
- show the recognized text
- offer Add Category
- preserve amount/quantity/note and return to Add Expense after category creation

### Critical native-wrapper requirement

Web Speech API alone is NOT sufficient for guaranteed offline voice on Android/iOS WebViews.

Implement a provider architecture:

SpeechService
  ├─ NativeSpeechProvider
  ├─ WebSpeechProvider
  └─ UnsupportedProvider

The HTML must expose a native bridge contract:

window.HisabAI.receiveNativeSpeech(text)

Android native wrapper should expose something equivalent to:

window.AndroidSpeechBridge.startListening(language)
window.AndroidSpeechBridge.stopListening()

Native Android implementation should use Android SpeechRecognizer and prefer offline recognition when the device/language pack supports it.

The HTML should fall back to SpeechRecognition/webkitSpeechRecognition when native bridge is unavailable.

Never claim “offline voice is guaranteed” in pure HTML. Explain that true offline speech depends on the native speech engine/language pack.

## 10. Android compatibility

The app must be tested conceptually for:
- Redmi 9C / older Android WebView
- Redmi 13 / modern Android

Do not depend on modern browser-only APIs without feature detection.

Feature-detect:
- IndexedDB
- File API
- Web Speech
- camera/file input
- downloads
- Web Share API

If a feature is unavailable, the app must remain usable.

The Android wrapper must:
- use a stable WebView configuration
- enable JavaScript
- enable DOM storage
- enable file/content access as required
- expose the Speech Bridge
- handle download requests
- handle local files carefully
- avoid crashing when external network resources are unavailable

Do not assume html2app.dev provides configurable minSdk/targetSdk. If native configuration is required, use Capacitor or a normal Android Studio wrapper where minSdk/targetSdk are under your control.

## 11. iOS/iPad distribution

The HTML must be PWA-ready:
- manifest metadata
- app icon metadata
- viewport-fit
- safe-area handling
- touch-friendly controls
- responsive layout

For an actual `.ipa`, use a native wrapper such as **Capacitor** around the web app.

Expected architecture:

HisabAI HTML/JS
      ↓
Capacitor
      ├── Android
      └── iOS/iPadOS

The iOS wrapper must provide a microphone/native speech bridge if offline speech is required.

The project must be able to open in Xcode, build for an iPad, archive, and export an IPA for registered test devices or TestFlight.

Do not pretend that a single HTML file itself is an IPA.

## 12. Excel export

Excel export must work without internet.

Preferred:
- local bundled SheetJS, OR
- native SpreadsheetML `.xls` exporter

Do not depend on CDN availability.

Export sheets:
1. Summary
2. Transactions
3. Category Analysis
4. Subcategory Analysis
5. Quantity Consumption
6. Monthly Comparison
7. Categories / Configuration
8. Balances

Include optional metadata columns:
- brand
- unit price
- shop
- shop location
- shop phone
- shop address
- journey from
- journey to
- journey start
- journey end
- photo-present flag

If browser download is blocked, provide a Web Share / Save / Files fallback where supported.

## 13. Backup and transfer

Provide a full portable JSON backup.

The backup must contain:
- schema/version
- categories including English/Bengali names and hierarchy
- transactions
- balances
- settings
- localization/theme
- sync metadata where applicable

Support:
- Export full backup
- Import full backup
- Replace local data
- Merge data

Also provide:
- Categories-only export
- Categories-only import

This must make it easy to transfer all categories/configuration from one phone to another.

Import must validate the backup before changing data.

## 14. Online sync

The standalone single-file app must NOT pretend that it has cloud sync.

IndexedDB is local only.

If cloud sync is implemented in a future build, use a real SyncService with:
- authentication
- device/user identity
- outbox queue
- retry
- conflict handling
- last-write/version metadata
- idempotent upsert
- offline queue
- online reconciliation

Recommended future backend:
- Supabase/PostgreSQL OR
- ASP.NET Core API + PostgreSQL

Never upload financial data anywhere without explicit user configuration and consent.

In the current standalone V1/V2 HTML, clearly show “Local only / Cloud not configured”.

## 15. PWA

Prepare the app for PWA deployment.

The core UI must work if hosted over HTTPS.

A proper production PWA should have:
- manifest.webmanifest
- service worker
- cached app shell
- offline navigation
- icons
- installability metadata

If strict single-file mode prevents a real service worker/manifest file, explain the limitation rather than faking it.

## 16. Mobile UX

Mobile must be the priority.

Requirements:
- no horizontal desktop layout on normal phone screens
- no duplicated Add Expense buttons
- one obvious primary Add Expense action
- compact top bar
- bottom navigation
- large touch targets
- safe-area support
- sticky action areas where useful
- modal forms must fit inside phone viewport
- no accidental overflow
- no tiny desktop tables as the only interface
- use cards on phones where tables are too wide
- keep important fields above the fold
- advanced optional fields can be collapsible

## 17. Localization

English + Bengali.

Store category names in both languages.

Do not translate technical strings literally if the Bengali UX sounds unnatural.

Use:
- BDT / ৳
- locale-aware number formatting
- locale-aware dates
- Bengali labels that sound natural

## 18. Data safety

Handle:
- IndexedDB unavailable
- corrupted/invalid data
- empty database
- duplicate categories
- likely duplicate transactions
- invalid amounts
- invalid quantity
- invalid dates
- month/year boundaries
- deleted categories referenced by old transactions
- photo storage failures
- browser download failures
- speech unavailable
- native bridge unavailable
- large transaction lists
- large photos

Never lose existing financial records because a category was renamed/deleted.

## 19. Migration

If upgrading from an older HisabAI IndexedDB schema, migrate old stores safely.

Old category fields such as `name` must be migrated into both English/Bengali fields when no separate language value exists.

Old transactions must gain new optional fields with safe defaults:
- brand
- unitPrice
- shopName
- shopLocation
- shopPhone
- shopAddress
- journeyFrom
- journeyTo
- journeyStart
- journeyEnd
- photoData
- syncStatus

Never destroy the old database during migration.

## 20. QA checklist

Before delivery, test:

1. Open HTML directly with internet disabled.
2. Reload repeatedly.
3. Create root category.
4. Create child category.
5. Create grandchild category.
6. Try duplicate category in same parent.
7. Verify duplicate warning shows full path.
8. Rename category.
9. Delete category.
10. Verify historical transaction path remains readable.
11. Add two legitimate transactions to the same category.
12. Try a likely exact duplicate and verify warning + Save Anyway.
13. Add expense with only required fields.
14. Add expense with all optional metadata.
15. Save a product photo.
16. Add a rickshaw journey with from/to/start/end.
17. Search categories during Add Expense.
18. Create category directly from Add Expense and return with draft preserved.
19. Voice command with Bangla.
20. Voice command with English.
21. Native speech bridge path.
22. Browser speech fallback.
23. Unsupported speech fallback.
24. Report category without child categories.
25. Report category with child categories.
26. Custom report.
27. Excel export with internet disabled.
28. Full JSON backup.
29. Restore backup using Replace.
30. Restore backup using Merge.
31. Categories-only export/import.
32. Test on Redmi 9C.
33. Test on Redmi 13.
34. Test on iPad Safari/PWA.
35. Test Capacitor Android wrapper.
36. Test Capacitor iOS/iPadOS wrapper.
37. Test dark mode.
38. Test English/Bengali.
39. Test print/PDF.
40. Test 10,000+ transactions without rendering all rows simultaneously.

## 21. Delivery format

Deliver:

A. `HisabAI.html` — complete single-file offline-first application.

B. If native mobile packaging is requested:
- Android Capacitor/native wrapper source
- iOS/iPadOS Capacitor/native wrapper source
- native Speech Bridge implementation
- exact build commands
- exact signing/build steps

C. A short README explaining:
- what is truly offline
- what requires internet
- what is local-only
- how backup/restore works
- how Android voice works
- how iPad/IPA build works
- how cloud sync can be added later

Never claim a feature is complete if it is only a placeholder.
