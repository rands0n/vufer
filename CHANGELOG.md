# v1.0.0

- Create `Vufer::Target.dups` to view duplated related targets.
- Create `Vufer::Target.summary` to get a summary of a target.

# v0.5.1

- Create `Vufer::Target.destroy` to delete a specific target on the database.

# v0.4.1

- Create `Vufer::Target.create` method to add a new target on the database.
- Create `Vufer::Target.update` to update a created target on the database.

# v0.3.1

- Create `Vufer::Target.all` method to load all ids from Vuforia associated with the server key.

# v0.2.1

- Create `Vufer.summary` to load info about targets, quota, requests, etc.. from Vuforia.
- Implement a proper CI to run tests.

# v0.1.1

- Create `Vufer::Target.find(target_id)` method to get target from Vuforia.
- Enable `.env.example` example on how to use environment variables.
