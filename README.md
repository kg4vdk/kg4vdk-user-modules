# Purpose

### This is an experiment in allowing for "daisy chaining" a user's git/GitHub managed USER modules.

# Context

USER modules are called at one of two places during `station-setup`...once ***before***, and once ***after*** the Cinnamon desktop environment is restarted (that's when the screen flashes black).

Module scripts containing "`_PRE_`" in the name (e.g. `10_PRE_MY-COOL-MODULE.sh`) are called ***before*** the desktop restart.

"Normal" module scripts (e.g. `20_SUPER-COOL-STUFF.sh`) are called ***after*** the desktop restart.

# Instructions

> **Note:**
>
> The `00_HANDOVER` module included here is the ***ONLY*** one that needs to be activated at the ***top-level*** (`/arcHIVE/QRV/$CALLSIGN/arcos-linux-modules/USER`). All other modules will remain inside the repo directory.


**To activate the HANDOVER module:**

1) Clone the repo into the top-level USER module directory.
2) Copy the `00_HANDOVER` directory into the top-level USER module directory.
3) Copy the scripts inside `00_HANDOVER` into the top-level USER module directory, as well.

```
/arcHIVE/QRV/KG4VDK/arcos-linux-modules/USER
├── 00_PRE_HANDOVER.sh
├── 00_HANDOVER.sh
├── 00_HANDOVER
└── kg4vdk-user-modules
    ├── MODULE-1
    ├── 00_MODULE-1.sh
    ├── MODULE-2
    │   └── 00_MODULE-2.sh
    └── [...]
```

The top-level `HANDOVER` scripts will call any enabled modules at the correct time. In the above file listing:

- `00_MODULE-1.sh` is **ENABLED** by being "exposed" at the same level as its parent
- `00_MODULE-2.sh` is **DISABLED** by remaining "nested" in its parent
