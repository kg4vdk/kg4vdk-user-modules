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
2) Copy the scripts from inside the `00_HANDOVER` directory into the top-level USER module directory.
```
/arcHIVE/QRV/KG4VDK/arcos-linux-modules/USER
├── 00_PRE_HANDOVER.sh
├── 00_HANDOVER.sh
└── kg4vdk-user-modules
    ├── ENABLED_MODULES
    ├── MODULE-1
    │   └── 00_MODULE-1.sh
    ├── MODULE-2
    │   └── 00_MODULE-2.sh
    └── [...]
```

The top-level `HANDOVER` scripts will call any modules named in the `ENABLED_MODULES` file. See supplied file for en example.
