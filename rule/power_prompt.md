Act as my coding mentor. Repo is open.

Goals:
1. Find entry point(s) and trace startup → core logic.
2. Map architecture (text diagram: components + arrows).
3. Identify 3–5 core modules/functions (most identity-critical).
4. Suggest 2–3 safe experiments to confirm I’ve found the core.

Process:
- Locate boot files (main.py, index.js, run_server.py, etc.), route/command definitions, and key config.
- Trace imports/calls from entry to main runtime loop.
- Mark which modules handle domain logic vs. adapters (UI, DB, API).
- List for each core fn/class: role, who calls it, what it calls, I/O.
- Propose minimal hands-on tweaks/logs to observe them.

Constraints:
- Assume I’m a CS grad — no basics.
- Keep output concise, actionable, step-by-step.
