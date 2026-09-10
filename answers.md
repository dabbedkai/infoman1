# INFOMAN1 — Week 3 Lab Answers

## Task 1 — Classify Attributes and Identify Weak Entities

| Classification Type | Attributes | Justification |
|---|---|---|
| Composite Attributes | `full_name` (Pet Owner & Veterinarian) | Contains multiple atomic components (`first_name` and `last_name`) that must be split into distinct columns for relational normalization. |
| Multivalued Attributes | `vaccination history` | A pet can receive zero, one, or multiple vaccinations over time; cannot be stored in a single column in normalized schemas. |
| Simple / Atomic Attributes | `owner_id`, `phone_number`, `pet_id`, `name`, `species`, `age`, `appointment_id`, `appointment_date`, `reason_for_visit`, `vet_id`, `specialization`, `vaccine_name`, `vaccination_date` | Single-valued, indivisible data values. |
| Derived Attributes | None | No derived attributes are explicitly specified in the scenario. |

## Task 2 — Specify Participation Constraints
_Answer here_


## Task 3 — Build the Logical ERD
_ERD here_

## Task 4 — Translate to Relational Schema Notation
_Answer here_


## Task 5 — Key Justification & Schema Validation
_Answer here_

## Self-Check

- [ ] All tasks committed with individual, meaningful commit messages
- [ ] All files placed inside `week3/`
- [ ] This file completed `answers.md`
- [ ] Repository link pasted into Moodle (no files uploaded)
