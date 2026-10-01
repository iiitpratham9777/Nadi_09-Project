@echo off
set PYTHONPATH=src
python -m nadi9_agent.cli run --input sample_run/input/demo_pack.json --output sample_run/output
python -m nadi9_agent.cli correction-demo --input sample_run/input/demo_pack.json --output sample_run/output/correction_demo.json
