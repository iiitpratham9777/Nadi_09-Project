# Nadi-9 Subtitle Agent

## Project Summary

This project is my implementation of the Nadi-9 AI Engineering challenge. The goal was to build a small, reliable system that can work with a fictional dialect when the available information is limited or contradictory.

I deliberately did not treat this as a normal translation task. A language model can easily produce a sentence that *sounds* correct even when there is no evidence behind it. My approach was therefore to make the system check the available evidence first and be comfortable asking for human review when the evidence is not strong enough.

> **Important:** The uploaded assignment brief describes the real Nadi-9 evidence pack, but it does not include that evidence pack itself. The included `sample_run` is therefore a clearly labelled synthetic engineering demo. It is used to show how the system handles conflicts, unsupported information, corrections and unsafe instructions; it is not presented as real Nadi-9 knowledge.

## What I built

The project follows a simple flow:

```text
Evidence
   ↓
Understand what is supported
   ↓
Build and test language hypotheses
   ↓
Process subtitle lines
   ↓
Verify the decision independently
   ↓
Translate only when evidence supports it
   ↓
Otherwise ask for human review
```

The implementation includes:

- structured evidence and source information
- conflict detection between sources
- simple hypothesis creation and testing
- conservative subtitle decisions
- evidence references for every decision
- confidence with an explanation rather than a bare number
- human-review questions for uncertain lines
- separate verification from translation
- correction impact tracking so only affected subtitles need to be revisited
- handling for unsupported terms and failed tools
- protection against instruction-like text inside retrieved evidence
- configurable model/tool call limits
- mock/replay-friendly execution so the project does not depend on my personal API key
- automated tests covering the important failure cases

## Why I designed it this way

The most important design choice was to avoid forcing the system to answer every question. If the evidence does not support a translation, the safer result is: **“I don't have enough evidence yet.”**

That makes the system easier for a language expert to review and makes mistakes visible instead of hiding them behind fluent AI output.

## Running the project

Requires Python 3.10+.

```bash
python -m venv .venv
# Windows
.venv\Scripts\activate
# macOS/Linux
source .venv/bin/activate

pip install -e .
python -m nadi9_agent.cli run --input sample_run/input/demo_pack.json --output sample_run/output
```

Run the tests:

```bash
pytest -q
```

Run the correction example:

```bash
python -m nadi9_agent.cli correction-demo --input sample_run/input/demo_pack.json --output sample_run/output/correction_demo.json
```

## Main outputs

After a run, the system produces:

- `subtitles.srt` — subtitle output
- `subtitle_decisions.jsonl` — the reasoning and evidence behind each subtitle decision
- `learned_rules.json` — learned/tested hypotheses
- `review_queue.json` — lines that need human attention
- `final_report.md` — a short release summary
- `run_state.json` — structured run information

## AI tools in my development workflow

I used AI coding assistants as a development partner for scaffolding, implementation ideas, test cases, debugging and documentation. I still ran the code, checked the behaviour and reviewed the generated changes.

I was especially careful not to use an LLM as the source of truth for Nadi-9 itself. The system's language decisions are tied to evidence, and unsupported suggestions are not presented as facts.

## Current scope

The repository is intentionally compact and focused on the reasoning pipeline. The real assignment evidence pack would allow the same pipeline to work with actual examples, grammar notes, dictionaries, expert notes, audio transcripts and the episode package.
