# Grocy — practical usage guide

For your wife (or anyone else who just wants to add stuff and track expiry). Ignore Grocy's other 30 menu items — you only need the 5 things below.

URL: **https://grocy.stoat-perch.ts.net** (phone Safari works great).

**On this page:** [0. First login (once)](#0-first-login-once) · [1. Add locations (one-time, 2 min)](#1-add-locations-one-time-2-min) · [2. Add a product (one-time per type of thing)](#2-add-a-product-one-time-per-type-of-thing) · [3. Add stock — when you buy something](#3-add-stock--when-you-buy-something) · [4. Consume — when you use something](#4-consume--when-you-use-something) · [5. See what's expiring or expired](#5-see-whats-expiring-or-expired) · [6. Barcode scanning (great on phone)](#6-barcode-scanning-great-on-phone) · [7. Shopping list (optional but useful)](#7-shopping-list-optional-but-useful) · [TL;DR — your wife's daily workflow](#tl;dr--your-wifes-daily-workflow) · [If something looks weird](#if-something-looks-weird)

---

## 0. First login (once)

1. Open the URL.
2. Username: `admin`, password: `admin`.
3. Top-right person icon → **Manage users** → click ✏ on `admin` → set a real password → **Save**.
4. Optional: click **+ New user** to create a separate login for your wife (e.g. `nithi`). Give her permission "Admin".

That's all the setup. Now use it.

---

## 1. Add locations (one-time, 2 min)

Locations = where you store stuff. Grocy needs to know about Pantry / Fridge / Freezer before you can add products.

1. Top-left ☰ menu → **Master data** → **Locations**.
2. **+ Add** → enter a name (e.g. `Pantry`) → **Save**.
3. Repeat for `Fridge`, `Freezer`, `Spice rack`, etc.

You'll probably add 4–6 locations total. Done forever.

---

## 2. Add a product (one-time per type of thing)

Each unique product (milk, rice, tomato sauce, etc.) is added once. Then you can have many "stock instances" of it with different expiry dates.

1. ☰ → **Master data** → **Products** → **+ Add**.
2. Fill in:
   - **Name**: `Milk` (or whatever)
   - **Default location**: `Fridge`
   - **Quantity unit (purchase)**: `Bottle` (or `Litre`, `Pack`, etc.) — pick from dropdown or click **+** to add a new unit
   - **Quantity unit (stock)**: same as purchase, usually
   - **Default best before days**: e.g. `7` for milk, `365` for canned beans — Grocy auto-fills the expiry date when you add stock
3. Optional: **Picture** — upload an image, or skip.
4. **Save**.

You'll have ~30-50 products over time. Each one is 30 seconds to add. Or use the barcode scanner (see §6) — barcoded products come pre-populated from a public database.

---

## 3. Add stock — when you buy something

You bought 2 bottles of milk, best-before 2026-06-10.

1. Top of any page → **Add stock** (or ☰ → **Stock** → **+ Purchase**).
2. **Product**: type "Milk" → pick from autocomplete.
3. **Amount**: `2`
4. **Best before**: `2026-06-10` (Grocy may pre-fill based on the product's default).
5. **Location**: `Fridge` (pre-filled from product default).
6. **Save**.

That single product now has **2 bottles**, both expiring 2026-06-10.

### Same product, different expiry dates (the question you asked)

Next week you buy 1 more bottle of milk, best-before 2026-06-17.

1. **Add stock** again → product `Milk` → amount `1` → best before `2026-06-17` → **Save**.

Grocy now tracks **3 bottles total**, as **2 separate stock entries**:
- 2 bottles expiring 2026-06-10
- 1 bottle expiring 2026-06-17

When you consume one, Grocy uses **FIFO** (first-in-first-out) by default — it removes from the oldest-expiry pile first. Click on any product to see the breakdown.

---

## 4. Consume — when you use something

You drank 1 bottle of milk.

### Quick way (from the Stock page)

1. ☰ → **Stock** → find Milk in the list.
2. Click the green **−1** button (or `Consume` icon).
3. Done. Quantity drops to 2.

### Detailed way (specify which expiry to consume)

1. Click the product name in the stock list.
2. **Consume** tab → choose **Specific stock entry** dropdown → pick the one with the earlier expiry.
3. **Consume amount**: `1` → **OK**.

For 99% of cases, just use the green **−1** button. FIFO does the right thing.

### Open vs consumed

For products like a 1L milk bottle where you "open" it but use it over days:
- Click product → **Open** button → marks it as opened. Grocy reduces best-before by the product's "default best before days after opening" (set in product settings).

---

## 5. See what's expiring or expired

The home dashboard shows two key cards:
- **Expiring products** — items with best-before in the next N days (default 5; configurable in Settings → Stock settings).
- **Expired products** — items past their best-before. Use these up or chuck them.

Click any item on the dashboard to consume or modify it directly.

For a fuller view:
- ☰ → **Stock**: shows ALL items, sortable by best-before date (click the column header).

---

## 6. Barcode scanning (great on phone)

Most packaged products have a barcode. Grocy can look them up via a public database (Open Food Facts).

1. Phone Safari → docs site URL must be **HTTPS** (`https://grocy.stoat-perch.ts.net`) — camera permission only works on HTTPS.
2. Top of page → **Add stock** → there's a barcode icon next to the product field.
3. Tap the icon → phone asks for camera permission → **Allow**.
4. Point at the barcode → Grocy auto-fills the product (or asks to create a new product if it's not in the DB yet).
5. Fill amount + expiry → **Save**.

Once a product is in your Grocy with that barcode, future scans are instant.

---

## 7. Shopping list (optional but useful)

When something runs low, Grocy can add it to a shopping list:

1. Edit a product (☰ → Master Data → Products → ✏) → set **Minimum stock amount** (e.g. `1` for milk — always have at least 1 bottle).
2. When stock drops below the minimum, the product appears on ☰ → **Shopping list**.
3. On your phone in the store, open the shopping list and check items off as you grab them.

---

## TL;DR — your wife's daily workflow

| Action | Where |
|---|---|
| Just bought groceries | Top-right "Add stock" → product + amount + expiry → Save |
| Just used something | Stock page → green **−1** button |
| What's expiring? | Home dashboard "Expiring" card |
| Need new product type | Master data → Products → + Add (one-time) |
| Phone-friendly bulk add | Barcode scan from Add stock |

That's the whole app for daily use. Ignore everything in the menu except **Add stock**, **Stock**, and the home dashboard. The recipes/meal plans/equipment/chores sections are bonus features you can explore later if curious.

---

## If something looks weird

- **No products listed**: you haven't added any yet — go to §2.
- **Can't pick a location when adding stock**: you haven't added any locations — go to §1.
- **Barcode scan asks for permission then fails**: must be on HTTPS — use `https://grocy.stoat-perch.ts.net`, not the LAN IP.
- **Forgot password**: see `apps/grocy/README.md` → "Lost admin password".
