# Purpose

### This is an experiment in allowing for "daisy chaining" a user's git/GitHub managed USER modules.

# Context

USER modules are called at one of two places during `station-setup`...once ***before***, and once ***after*** the Cinnamon desktop environment is restarted (that's when the screen flashes black).

Module scripts containing "`_PRE_`" in the name (e.g. `10_PRE_MY-COOL-MODULE.sh`) are called ***before*** the desktop restart.

"Normal" module scripts (e.g. `20_SUPER-COOL-STUFF.sh`) are called ***after*** the desktop restart.

# Instructions

> **Note:**
>
> The `00_HANDOVER` module scripts included here are the ***ONLY*** ones that need to be activated at the ***top-level*** (`/arcHIVE/QRV/$CALLSIGN/arcos-linux-modules/USER`). All other modules will remain inside the repo directory...nice and tidy-er.


**To activate the HANDOVER module:**

1) Clone the repo into the top-level USER module directory.
2) Rename repo directory (if necessary) to reflect your callsign.
3) Copy the scripts from inside the `00_HANDOVER` directory into the top-level USER module directory.

```
/arcHIVE/QRV/KG4VDK/arcos-linux-modules/USER
├── 00_PRE_HANDOVER.sh       <-- copied here by user
├── 00_HANDOVER.sh           <-- copied here by user
└── kg4vdk-user-modules      <-- rename (if necessary...am i me?)
    ├── ENABLED_MODULES      <-- edit to manage enabled modules 
    ├── MODULE-1
    │   └── 00_MODULE-1.sh
    ├── MODULE-2
    │   └── 00_MODULE-2.sh
    └── [...]
```

The top-level `00_HANDOVER` scripts will call any modules named in the `ENABLED_MODULES` file. See supplied file for en example.

> **Note:**
>
> The pre-numbering of module scripts is a holdover from previous methods. There is no requirement to number them when creating new ones. Enabled modules will run in order of top-down inclusion in `ENABLED_MODULES`.
>
> "`_PRE_`" modules always run before the desktop restart, even if included after any "normal" modules.
>
> When using the "`_PRE_`" functionality, *both* underscores are required.
