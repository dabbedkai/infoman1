# INFOMAN1 — Week 3 Lab Answers

## Task 1 — Classify Attributes and Identify Weak Entities

### Attribute Classifications

- **Composite Attribute:** `full_name` (Pet Owner)
  - **Justification:** The scenario explicitly states that `full_name` consists of `first_name` and `last_name`. In logical ERD modeling, composite attributes are decomposed into atomic attributes (`first_name`, `last_name`).
- **Multivalued Attribute:** `vaccination_history` (Pet)
  - **Justification:** The scenario notes that "a pet may have zero, one, or several vaccination records." Because a single pet can have multiple associated vaccination records, storing this directly inside `Pet` would violate First Normal Form (1NF).
- **Derived Attributes:** None
  - **Justification:** The scenario stores `age` directly without referencing a birth date or dynamic date calculation.

### Weak Entity Identification

- **Weak Entity:** `Vaccination Record`
  - **Justification:** A weak entity cannot be uniquely identified by its own attributes alone and depends on a strong parent entity for identification and existence. The scenario explicitly notes that a vaccination record "cannot be uniquely identified or looked up on its own" and "only makes sense in relation to the specific pet it belongs to."
  - **Partial Key (Discriminator):** `vaccine_name` and `vaccination_date`
  - **Identifying Parent Entity:** `Pet`

## Task 2 — Specify Participation Constraints

| Relationship | Entity A | Symbol A (A → B) | Entity B | Symbol B (B → A) | Scenario Evidence |
|---|---|---|---|---|---|
| Owner - Pet | Owner | Optional Many (`O<`) | Pet | Mandatory One (`||`) | "A pet owner ... is not required to have any pets on file at a given time [Optional Many], but every pet must belong to exactly one owner [Mandatory One]." |
| Pet - Appointment | Pet | Optional Many (`O<`) | Appointment | Mandatory One (`||`) | A pet can exist in the system prior to having visits [Optional Many], but "an appointment cannot exist without both [Mandatory One]." |
| Veterinarian - Appointment | Veterinarian | Optional Many (`O<`) | Appointment | Mandatory One (`||`) | A veterinarian "can conduct multiple appointments over time or none at all [Optional Many]", but an appointment "must specify exactly one veterinarian [Mandatory One]." |
| Pet - Vaccination Record | Pet | Optional Many (`O<`) | Vaccination Record | Mandatory One (`||`) | "A pet may have zero, one, or several vaccination records [Optional Many]", and each record "only makes sense in relation to the specific pet it belongs to [Mandatory One]." |

*Crow's Foot Notation Key:*
- `O<` = Optional Many (Inner: Optional `O`, Outer: Many `<`)
- `||` = Mandatory One (Inner: Mandatory `|`, Outer: One `|`)

## Task 3 — Build the Logical ERD

![Logical ERD](erd_diagram.png)