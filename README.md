Code for evaluation

Refactor from https://github.com/QwenLM/Qwen2.5-Math 

```bash
huggingface-cli download --resume-download Qwen/Qwen3-1.7B --local-dir models/Qwen3-1.7B
cd eval_math
sh scripts/test.sh
```
GSM8K, Qwen3-1.7B, 77% acc


eval mmlu
```bash
cd eval_mmlu
```