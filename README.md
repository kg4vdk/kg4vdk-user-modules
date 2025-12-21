# Purpose

### This is an experiment in allowing for "daisy chaining" a user's git/GitHub managed USER modules.

# Context

USER modules are called at one of two places during `station-setup`...once ***before***, and once ***after*** the Cinnamon desktop environment is restarted (that's when the screen flashes black).

Module scripts with the suffix "`.pre.sh`" are called ***before*** the desktop restart. (e.g. `MY-COOL-MODULE.pre.sh`)

"Normal" module scripts are called ***after*** the desktop restart. (e.g. `SUPER-COOL-STUFF.sh`)

# Instructions

> **Note:**
>
> The `HANDOVER` module scripts included here are the ***ONLY*** ones that need to be activated at the ***top-level*** (`/arcHIVE/QRV/$CALLSIGN/arcos-linux-modules/USER`). All other modules will remain inside the repo directory...nice and tidy-er.


**To activate the HANDOVER module:**

1) Clone the repo into the top-level USER module directory.
2) Rename repo directory (if necessary) to reflect your callsign.
3) Copy the scripts from inside the `HANDOVER` directory into the top-level USER module directory.

```
/arcHIVE/QRV/KG4VDK/arcos-linux-modules/USER
├── HANDOVER.pre.sh       <-- copied here by user
├── HANDOVER.sh           <-- copied here by user
└── kg4vdk-user-modules      <-- rename (if necessary...am i me?)
    ├── ENABLED_MODULES      <-- edit to manage enabled modules 
    ├── MODULE-1             <-- a module directory
    │   └── MODULE-1.sh      <-- a "normal" module script
    ├── MODULE-2             <-- a second module directory
    │   └── MODULE-2.pre.sh  <-- this one runs before cinnamon restarts
    └── [...]
```

The top-level `HANDOVER` scripts will call any modules named in the `ENABLED_MODULES` file. See supplied file for en example.

Enabled modules will run in order of top-down inclusion in `ENABLED_MODULES`.

"`.pre.sh`" modules always run before the desktop restart, even if included after any normal '`.sh`" modules.

> **Note:**
>
> The lingering pre-numbering of module scripts (e.g. `00_MODULE-1.sh`) is a holdover from previous methods. There is no requirement to number them when creating new ones. 
