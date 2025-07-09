# 🌾 Farm Report Entry Flow (Per Batch)

This document outlines the step-by-step flow for entering a farm report in the Ikuku Farm Manager app. It includes user-friendly UI guidance and important notes on data logic (e.g., inventory and batch updates).

---

## ✅ Step 1: Select Batch
- **Page Title**: *Select a Batch to Report On*
- **UI**: A list of all active batches (cards or list view with name, type, and age).
- **Action**: Tap on a batch to start the report for that specific batch.
- **Why**: Ensures that each batch is reported on individually and data remains organized.

---

## 🔻 Step 2: Chicken Reduction
- **Question**: “Have your chickens reduced today?”
  - **Options**: Yes / No (Radio buttons)

### If Yes is selected:
- **Follow-up Question**: “What is the reason for the reduction?”
  - **Options**: Curled, Stolen, Death

### If No is selected:
- Move to the next section (Eggs or Feeds depending on batch type).

📌 **Note**: If **Death** is selected as the reason, the number of chickens should be deducted from the **selected batch’s population** immediately after the report is submitted.

---

## 🥚 Step 3: Egg Production *(Only for Layers & Kienyeji Batches)*

> 💡 Skip this section entirely if the batch is a **Broiler**.

- **Question**: “Have you collected eggs today?”
  - **Options**: Yes / No

### If Yes:
- **Question 1**: “How many eggs have you collected?”
- **Question 2**: “Would you like to grade your eggs?”
  - If **Yes**, show grading fields:
    - “Number of big eggs”
    - “Number of deformed eggs”
    - “Number of broken eggs”

### If No:
- Skip grading and move to the Feeds section.

---

## 🍗 Step 4: Feeds
- **Question 1**: “Select the feed type you used today.”
  - **Dropdown**: Auto-populated from the **Farm Store inventory**
- **Question 2**: “Select the amount used today (in Kg).”

📌 **Note**: Upon saving the report, the specified amount of feed should be **deducted from the feed stock** in the inventory.

---

## 💉 Step 5: Vaccines
- **Question**: “Have you used any vaccines today?”
  - **Options**: Yes / No

### If Yes:
- **Question 1**: “Select the vaccine you used today.”
  - **Dropdown**: Populated from the vaccine inventory
- **Question 2**: “Select the amount used today (in Litres).”

📌 **Note**: Upon saving, the vaccine amount should be **deducted from the vaccine inventory**.

### If No:
- Skip to the next section.

---

## 🧪 Step 6: Other Materials Used
- **Question**: For each additional material in inventory (not feeds or vaccines), ask:
  - “Select the amount of *[Item Name]* used today”

📌 **Note**: Each specified amount should be deducted from the item's inventory stock.

---

## 📝 Step 7: Additional Notes
- **Prompt**: “Write any additional notes for this batch (*Batch Name - Batch Type*)”
- **Input**: Multi-line text box for open feedback or observations.

---

## 📄 Step 8: Review Report
- **Section Header**: *Review Today's Report*
- **Summary Display**:
  - Batch Info: Name, type, and age
  - Reduction details
  - Egg production (if applicable)
  - Feed and vaccine usage
  - Other materials
  - Additional notes

- **Button**: **Save Report**
  - Submits the report to the database
  - Triggers these actions:
    - Chicken count updates (if deaths reported)
    - Feed/vaccine/material inventory deduction

✅ A success confirmation screen should appear after saving:  
“Report for *[Batch Name]* has been saved and inventory updated.”

---

## ✅ UX/UI Design Tips
- Use **clear section headers** and **simple navigation buttons** (Next, Back).
- Show **conditional fields** only when required (e.g., egg grading after egg collection).
- Display **real-time inventory quantities** next to dropdowns for context.
- Provide **validation and error handling** (e.g., can’t use more feed than available in store).
- Allow users to **edit before saving** in the review page.