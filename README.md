Code for evaluating math benchmarks

Refactor from https://github.com/QwenLM/Qwen2.5-Math 

```bash
cd evaluation
huggingface-cli download --resume-download Qwen/Qwen3-1.7B --local-dir ../models/Qwen3-1.7B
sh scripts/test.sh
```
GSM8K, Qwen3-1.7B, 77% acc
