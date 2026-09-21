# HishabiAI — Master Build Prompt v3

## ROLE

You are a senior product engineer, UX/UI engineer, offline-first application architect, Flutter engineer, Android/Kotlin engineer, iOS/Swift engineer, JavaScript engineer, local-database engineer, voice-interface engineer, Excel/export engineer, and QA engineer.

You must inspect the existing HishabiAI prototype before changing architecture or functionality.

The existing prototype file is:

`HashabiAI_V2_UPDATED.html`

The product's official name is:

# HishabiAI

Never use `HashabiAI`, `Hashabi AI`, or `HisabAI` as the product name in the final application.

---

# 1. PRODUCT

HishabiAI is a smart, offline-first personal daily expense manager.

Primary purpose:

* Quickly record expenses
* Organize expenses using unlimited category hierarchy
* Use voice commands to add expenses
* View transaction history
* Generate reports
* Export data to Excel
* Attach multiple receipt/product/memo photos
* Work without an internet connection
* Work responsively on phones, tablets, and desktop

The application must feel like a real polished consumer mobile application, not a desktop website squeezed into a phone.

---

# 2. EXISTING FUNCTIONALITY

Do not unnecessarily remove existing working functionality.

First inspect the existing prototype and preserve all valid functionality.

Only modify or replace functionality when required by this specification.

Do not create fake buttons, placeholder features, or UI controls that do nothing.

Every visible action must work.

---

# 3. BRANDING

Official application name:

**HishabiAI**

Subtitle:

**Smart Personal Expense Manager**

Use the provided existing SVG/logo/icon assets where available.

Do NOT generate a replacement logo unless explicitly requested.

Correct all visible occurrences of:

* HashabiAI
* HisabAI
* Hashabi AI

to:

**HishabiAI**

Update:

* HTML title
* app title
* browser title
* Android application label
* iOS application display name
* manifest
* splash screen
* navigation
* settings
* about page
* export metadata
* notifications
* accessibility labels
* icon metadata

---

# 4. OFFLINE-FIRST IS NON-NEGOTIABLE

The application must remain fully usable without internet access.

Core functionality must never depend on:

* Tailwind CDN
* external CSS
* Google Fonts CDN
* Font Awesome CDN
* external icon CDN
* Chart.js CDN
* SheetJS CDN
* external API
* remote database
* remote image
* remote JavaScript library

The current prototype must not break visually when internet is disconnected.

No blank page.
No broken layout.
No missing mandatory styles.
No missing mandatory icons.
No unusable controls.

Use local/embedded assets for core UI.

If an optional remote enhancement fails, the application must continue operating normally.

---

# 5. RESPONSIVE DESIGN

The entire application must be responsive and adaptive.

Target:

* Small Android phones
* Large Android phones
* iPhone
* iPad/tablets
* Desktop/laptop
* portrait
* landscape

The layout must never overflow horizontally.

Avoid:

* fixed desktop widths
* hardcoded screen assumptions
* clipped buttons
* overlapping cards
* overflowing tables
* unusable modal dialogs
* fields wider than the viewport

Use responsive layouts and adaptive navigation.

The interface must fit the available screen.

---

# 6. MOBILE-FIRST UI

On mobile:

* large enough touch targets
* readable typography
* compact spacing
* bottom navigation where appropriate
* sticky primary actions where useful
* forms optimized for one-hand use
* no unnecessary desktop sidebar

On tablets:

* use additional available space
* avoid simply stretching mobile UI

On desktop:

* use available horizontal space intelligently
* allow multi-column layouts where useful

---

# 7. DATA STORAGE

Use a reliable local-first storage architecture.

For the prototype:

* IndexedDB is acceptable.

For the production Flutter application:

* use a robust local database such as SQLite/Drift or an equivalent reliable local persistence solution.

All core expense/category/settings data must be available offline.

No cloud connection should be required to:

* add expense
* edit expense
* delete expense
* create category
* create subcategory
* view reports
* search transactions
* export data
* attach local photos

---

# 8. CATEGORY SYSTEM

Support unlimited hierarchy:

```text
Parent Category
    └── Child Category
          └── Sub-child
                └── Sub-sub-child
```

There must be no artificial two-level limitation.

Example:

```text
Transportation
    └── Local Transport
          └── Rickshaw
```

Category creation must support:

* English name
* Bangla name
* parent category
* optional icon
* optional color
* active/inactive status

Prevent obvious duplicate categories.

Detect similar existing categories before blindly creating another one.

---

# 9. ADD EXPENSE — SIMPLE DEFAULT FORM

When opening Add Expense, initially show ONLY:

* Date
* Time
* Category
* Amount
* Note

Do not overwhelm the user.

Show:

**Add more details**

as a checkbox/toggle.

---

# 10. ADD MORE DETAILS

When enabled, show:

* Brand
* Shop Name
* Shop Location
* Shop Address
* Shop Phone Number

Also support:

**Add Photos**

The user must be able to attach multiple photos to a single expense.

Examples:

* shop receipt
* handwritten memo
* product photo
* price tag
* card receipt
* invoice

Photos must remain associated with the transaction.

---

# 11. TRANSPORTATION-SPECIFIC DETAILS

Only when the selected category belongs to transportation/journey-related categories, show:

* Journey Started From
* Journey End To
* Journey Started Time
* Journey Ended Time

Do NOT show these fields for unrelated categories.

Example:

```text
Rickshaw
Bus
CNG
Uber
Train
Launch
Transport
```

may expose journey details.

Food, medicine, shopping, education, etc. should not expose journey fields unless explicitly configured as transportation categories.

---

# 12. TRANSACTION CRUD

Every transaction must support:

* Create
* Read
* Update
* Delete

Transaction list must provide:

* Edit
* Delete

Delete must have confirmation.

Prefer an Undo mechanism after deletion where practical.

There must be no situation where a wrongly added expense cannot be removed.

---

# 13. VOICE-FIRST EXPENSE ENTRY

Voice control is a primary feature, not a decorative microphone button.

Example command:

> "HishabiAI, একটা expense add করো, rickshaw ভাড়া 80 টাকা।"

The system should interpret this as:

```json
{
  "intent": "ADD_EXPENSE",
  "description": "rickshaw ভাড়া",
  "amount": 80,
  "currency": "BDT"
}
```

Then resolve the category.

---

# 14. VOICE CATEGORY RESOLUTION

When a voice expense command is received:

1. Extract intent.
2. Extract amount.
3. Extract description.
4. Search all category levels.
5. Match existing category/subcategory/sub-subcategory.
6. If an appropriate category exists, select it automatically.
7. If no appropriate category exists, create an appropriate category automatically.
8. Save the transaction.
9. Confirm the completed action.

Example:

User:

> "HishabiAI, rickshaw vara 80 taka expense add koro."

If Rickshaw already exists:

```text
Select Rickshaw
→ Add ৳80
```

If Rickshaw does not exist:

```text
Transportation
    └── Rickshaw
```

Create it if appropriate, then:

```text
Add ৳80
```

The user should NOT be dumped into the Category Add screen and left there.

The voice workflow must complete the requested operation.

---

# 15. VOICE COMMAND ENGINE

Implement voice processing as a proper pipeline:

```text
Speech Input
      ↓
Speech-to-Text
      ↓
Intent Detection
      ↓
Entity Extraction
      ↓
Category Resolution
      ↓
Validation
      ↓
Local Transaction Command
      ↓
Persistence
      ↓
Confirmation
```

Support natural language combinations of:

* Bangla
* English
* Banglish
* mixed Bangla-English

Examples:

```text
রিকশা ভাড়া ৮০ টাকা
rickshaw vara 80 taka
add rickshaw expense 80
আজকে রিকশায় ৮০ টাকা
```

Do not rely on exact phrase matching only.

---

# 16. SCREEN-OFF / BACKGROUND VOICE

Native applications must support the strongest voice capability permitted by the operating system.

Architecture:

```text
Flutter Voice Interface
        │
        ├── Android Native Voice Adapter
        │       └── Kotlin
        │
        ├── iOS Native Voice Adapter
        │       └── Swift
        │
        └── Web Voice Adapter
```

Do NOT assume that unrestricted always-listening is possible on every platform.

Respect Android and iOS microphone/background restrictions.

Where supported, provide:

* wake phrase integration
* system assistant integration
* notification action
* lock-screen/system entry point
* microphone shortcut
* app shortcut
* Siri/App Intent integration on iOS
* appropriate Android native integration

The product must never falsely claim that screen-off continuous listening is supported if the OS does not permit it.

---

# 17. WEB VOICE

For web/PWA:

Use available browser speech APIs where supported.

Voice flow:

```text
Microphone
→ Speech recognition
→ Intent parser
→ Category resolver
→ Transaction creation
```

If browser speech recognition is unavailable, show a clear fallback:

```text
Voice input is not supported by this browser.
```

Do not crash.

---

# 18. EXCEL EXPORT

Excel export is mandatory.

Provide export functionality in:

### Transactions

`Export to Excel`

### Reports

`Export to Excel`

### Settings

`Download All Data as Excel`

All export functions must work on:

* Web
* Android
* iOS

Do not create a fake download button.

---

# 19. FULL DATA EXPORT

The full export should preferably create one XLSX workbook containing multiple sheets such as:

```text
Transactions
Categories
Balances
Settings
Attachments
```

Use appropriate columns and readable formatting.

Dates and amounts must be preserved accurately.

Bangla text must export correctly.

BDT values must remain numeric where appropriate.

---

# 20. WEB EXCEL IMPLEMENTATION

The standalone HTML prototype must work without internet.

Therefore:

Do NOT make XLSX export depend on SheetJS CDN.

If true XLSX generation cannot be implemented without an external library, implement a robust local fallback and clearly separate it from optional enhancements.

The production native application must generate real `.xlsx` files locally and provide platform-appropriate save/share behavior.

---

# 21. REPORTS

Provide reports such as:

* Daily
* Weekly
* Half-month
* Monthly
* Yearly
* Custom date range

Allow filtering by:

* category
* parent category
* child category
* date range
* amount
* keyword

Show totals and category breakdowns.

Reports must continue working offline.

---

# 22. TRANSACTION HISTORY

Transaction history should provide:

* search
* filtering
* date grouping
* category display
* amount
* note
* edit
* delete
* attachment indicator

Do not hide the delete functionality.

---

# 23. SETTINGS

Settings should include appropriate options such as:

* language
* theme
* currency
* data management
* export all data
* import/restore where supported
* backup/restore
* voice settings
* about
* privacy

The Settings page MUST contain:

**Download All Data as Excel**

---

# 24. LANGUAGE

Support:

* English
* Bangla

Category names may contain both Bangla and English.

The UI should be localizable without breaking layout.

Never assume English text length.

Never assume Bangla text length.

---

# 25. DATA SAFETY

Never silently destroy user data.

Before:

* reset
* delete all data
* import replacement data

show a clear confirmation.

Provide backup/export options.

---

# 26. PRODUCTION MOBILE ARCHITECTURE

Recommended production architecture:

```text
Flutter
│
├── Presentation
│
├── Domain
│
├── Application
│
├── Local Data
│
├── Voice
│
├── Export
│
└── Platform Services
       │
       ├── Android/Kotlin
       └── iOS/Swift
```

Keep business logic platform-independent.

Use native platform code only where OS-level capabilities require it.

---

# 27. UI ARCHITECTURE

Use reusable components for:

* buttons
* cards
* form fields
* category selector
* transaction rows
* dialogs
* bottom sheets
* date/time selectors
* attachment picker
* export actions
* voice controls

Avoid duplicating UI logic.

---

# 28. ACCESSIBILITY

Support:

* readable contrast
* large touch targets
* screen-reader labels
* semantic controls
* keyboard navigation on web
* dynamic text where practical

Do not rely only on color to communicate state.

---

# 29. PERFORMANCE

The app should remain responsive with:

* thousands of transactions
* hundreds of categories
* many attachments

Do not load every large photo into memory simultaneously.

Use lazy loading and thumbnails where appropriate.

---

# 30. ERROR HANDLING

Never crash because:

* internet is unavailable
* voice recognition is unavailable
* Excel export encounters a platform limitation
* photo permission is denied
* microphone permission is denied
* storage permission is denied
* a category does not exist
* a browser does not support a feature

Show useful user-facing messages.

---

# 31. TESTING

Test at minimum:

### Web

* Chrome
* Safari where practical
* offline mode
* responsive mobile viewport
* tablet viewport
* desktop viewport

### Android

* older Android device
* modern Android device
* screen on
* background
* lock screen where OS permits
* microphone permission
* photo permission
* Excel export
* delete/edit

### iOS

* iPhone
* iPad
* foreground voice
* system voice integration where supported
* permissions
* Excel export
* photo attachments
* offline operation

---

# 32. CRITICAL ACCEPTANCE TESTS

The implementation is NOT complete unless all of these work.

### Test 1

Turn off internet.

Open HishabiAI.

Result:

Application remains visually intact and functional.

### Test 2

Add:

```text
Rickshaw
৳80
```

Save.

Result:

Transaction appears immediately.

### Test 3

Edit the transaction.

Result:

Updated data persists.

### Test 4

Delete it.

Result:

Transaction disappears after confirmation.

### Test 5

Export transactions to Excel.

Result:

Real Excel file is produced.

### Test 6

Open Settings.

Result:

Full-data Excel export is available.

### Test 7

Open Add Expense.

Result:

Only basic fields are initially visible.

### Test 8

Enable Add More Details.

Result:

Brand, shop and related fields appear.

### Test 9

Select transportation category.

Result:

Journey fields appear.

Select Food.

Result:

Journey fields disappear.

### Test 10

Attach multiple photos.

Result:

All photos remain associated with the expense.

### Test 11

Say:

> "HishabiAI, rickshaw vara 80 taka add koro."

Result:

The system should create/select Rickshaw and create the ৳80 transaction.

It must NOT simply navigate to Category Add.

### Test 12

If Rickshaw category does not exist:

Result:

Create the appropriate category automatically and add the transaction.

---

# 33. DO NOT OVERENGINEER THE PROTOTYPE

The existing single HTML prototype is useful for validating:

* UX
* flows
* requirements
* data model
* interaction design

Do not unnecessarily introduce:

* backend
* API
* authentication
* cloud database
* server dependency

into the offline prototype.

The production Flutter application can later add optional synchronization/cloud backup without breaking local-first behavior.

---

# 34. FINAL PRINCIPLE

HishabiAI should feel like this:

> Open it.
> Say what you spent.
> HishabiAI understands it.
> If the category exists, it uses it.
> If it doesn't, it creates it.
> The expense is saved.
> No internet required.
> No unnecessary form filling.
> No broken layout.
> No fake buttons.
> No lost data.

The user should spend less time managing expenses than they spent earning the money.

Build the product around that principle.
