# Grocy — advanced features (the other 80%)

The [USAGE guide](USAGE.md) covers daily use. This page is the rest of Grocy's features — dip in when curious, ignore otherwise. None are required for inventory tracking.

URL: https://grocy.stoat-perch.ts.net

**On this page:** [🍽 Recipes](#-recipes) · [📅 Meal planning](#-meal-planning) · [🛒 Shopping list (deeper than USAGE intro)](#-shopping-list-deeper-than-usage-intro) · [📜 Stock journal](#-stock-journal) · [🔋 Battery tracker](#-battery-tracker) · [🛠 Equipment](#-equipment) · [✅ Chores (Grocy's own)](#-chores-grocys-own) · [📋 Tasks](#-tasks) · [⚙ Settings worth knowing](#-settings-worth-knowing) · [🏷 Userfields & userentities (custom data)](#-userfields--userentities-custom-data) · [👥 Multi-user features](#-multi-user-features) · [🔌 API & integrations](#-api--integrations) · [📦 Master data — what each tab is for](#-master-data--what-each-tab-is-for) · [📊 Reports](#-reports) · [📱 Mobile apps (third-party)](#-mobile-apps-third-party) · [What I'd never bother with](#what-id-never-bother-with) · [More from Grocy](#more-from-grocy) · [TL;DR — the features that are actually worth your time](#tl;dr--the-features-that-are-actually-worth-your-time)

---

## 🍽 Recipes

Save recipes with ingredient lists tied to your stock. Grocy tells you which recipes you can make right now from what's in stock.

- ☰ → **Recipes** → **+ Add recipe**
- Add ingredients by picking from your existing products (with amounts)
- "Used in" tab on a product shows which recipes use it
- "Make this" button decrements all ingredients from stock at once
- "Need" tab shows missing ingredients that would auto-add to shopping list

Useful when you want "what can we cook tonight without going to the shop?"

---

## 📅 Meal planning

Drag recipes onto a calendar. Grocy aggregates the week's ingredients into a single shopping list.

- ☰ → **Meal plan**
- Click a day → add recipes or products
- Right sidebar shows the consolidated shopping list across the week

Useful if you do weekly meal prep.

---

## 🛒 Shopping list (deeper than USAGE intro)

- ☰ → **Shopping list** → multiple lists possible (e.g. "Aldi", "Costco")
- Items auto-populated from products that fall below their **minimum stock**
- Manual entries: type freely (e.g. "Birthday candles") — these don't need to be Grocy products
- Mobile-friendly check-off mode for in-store use
- Print as PDF if anyone insists on paper

---

## 📜 Stock journal

Complete audit log of every add/consume/transfer/open.

- ☰ → **Stock journal**
- Filterable by date, product, location, user
- Useful when you wonder "wait, did I really buy milk last week?"
- Can undo entries (within reason)

---

## 🔋 Battery tracker

Self-hosted "where did I put the AA spares" + replacement reminders.

- ☰ → **Batteries**
- Add each battery (type, location, last charged, charging cycle)
- Get reminders when batteries due for a recharge or replacement
- Good for: smoke alarms, remote controls, kids' toys

---

## 🛠 Equipment

Inventory of household equipment + warranty + manuals.

- ☰ → **Equipment**
- Add appliance/tool → upload manual PDF + warranty card photo
- Set warranty expiry date → get alerts before warranty runs out
- Search across all manuals from one place

Worth it if you own a lot of appliances with random manuals all over the house.

---

## ✅ Chores (Grocy's own)

Generic recurring tasks: change air filter, water plants, descale kettle, etc.

- ☰ → **Chores** → **+ Add chore**
- Set frequency: every X days/weeks, or specific weekday, or after each use
- Mark "Done" → resets the timer
- Optional: assign to a user

(You also have a dedicated kids-chores app, so for kids' tasks use that. Grocy chores are better for "non-kid" recurring household maintenance.)

---

## 📋 Tasks

One-off to-dos (vs Chores which recur). Lightweight task tracker.

- ☰ → **Tasks** → **+ Add task**
- Set due date + assignee
- Categories for grouping

Honestly, weakest feature in Grocy — use any real todo app instead. Mentioned for completeness.

---

## ⚙ Settings worth knowing

☰ → **Settings** (gear icon) → tabs across the top:

- **General**: language, currency (£), date format
- **Stock**: how many days = "expiring soon" (default 5), what to show on dashboard
- **Shopping list**: auto-add behavior, default list
- **Calendar**: meal plan settings, week start day
- **Recipes**: rounding behavior
- **API**: where to manage API keys for Siri / Home Assistant

---

## 🏷 Userfields & userentities (custom data)

Want to track something Grocy doesn't have built-in? Add custom fields.

- ☰ → **Manage userfields**
- Pick an entity (Products, Locations, Stock, Recipes, ...)
- Add field with type: text / number / date / checkbox / dropdown
- Field appears on that entity's add/edit form

Example: add a "Vegetarian" checkbox to recipes. Or "Lot number" to stock entries.

**Userentities** = create entirely new custom data types. Power user feature; skip until you have a specific need.

---

## 👥 Multi-user features

- ☰ → **Manage users**: separate logins per family member
- Each user has their own permissions (admin / regular / view-only)
- Stock journal records who did what (e.g. who consumed the last milk)
- Permission groups: ☰ → **Manage permissions** for fine-grained access (rare to need)

---

## 🔌 API & integrations

Grocy has a full REST API. Used by:

- **Siri Shortcuts** (the iPhone voice control we set up in `README.md`)
- **Home Assistant** integration (if you ever deploy HA)
- Anything you script yourself

Get your API key: ☰ → **Manage API keys** → **+ Add**

Docs at https://demo.grocy.info/api/

Example: `GET /api/stock/products/{id}` returns full stock info for a product.

---

## 📦 Master data — what each tab is for

☰ → **Master data** dropdown:

| Tab | What |
|---|---|
| **Products** | Each type of thing you stock (Milk, Rice, …) |
| **Locations** | Where you keep stuff (Fridge, Pantry, …) |
| **Stores** | Where you buy stuff (Tesco, Aldi, Costco) — track prices per store |
| **Quantity units** | Bottle, Litre, Pack, etc. + conversion rules (1 Pack = 6 Bottle) |
| **Product groups** | Categories (Dairy, Grains, Snacks) for organizing the Stock view |
| **Userfields** | Custom fields (see above) |
| **Userentities** | Custom data types (see above) |
| **Chores** | Recurring tasks (Grocy's own chore tracker) |

The first 2 are mandatory before you can use Grocy. The others are optional.

---

## 📊 Reports

☰ → **Reports** (some installs hide this under Settings → check there if missing):

- Stock value (total £ in your inventory)
- Items consumed per month
- Frequently bought products
- Money spent per store

Useful for the "are we wasting food?" questions.

---

## 📱 Mobile apps (third-party)

Grocy's PWA (the web UI on phone) is excellent and you don't need anything else. But if you really want a native app:

- **Grocy Android** (Play Store) — official-ish app
- **Grocy iOS** — fewer good options; Safari PWA is honestly better

Add Grocy to your iPhone home screen via Safari "Add to Home Screen" — gives an app-icon launcher.

---

## What I'd never bother with

- **Currency conversion** — only matters if you shop in multiple currencies
- **Calorie tracking** — exists but anaemic; use a dedicated app
- **The "Tasks" feature** — barely a todo list
- **Userentities** — only if you have a very specific custom-tracking need

---

## More from Grocy

- Official docs: https://docs.grocy.info
- Community forum: https://github.com/grocy/grocy/discussions
- Demo site (try features without messing yours up): https://demo.grocy.info

---

## TL;DR — the features that are actually worth your time

| Worth learning | Skip |
|---|---|
| Recipes + Meal planning (if you cook a lot) | Userentities |
| Shopping list min-stock auto-add | Tasks |
| Equipment + warranty tracker | Batteries (unless you have many) |
| Reports → "stock value" / "consumed" | Currency conversion |
| API + Siri Shortcuts | Calorie tracking |
