Minimal code for evaluation


## Math (local)
Refactor from https://github.com/QwenLM/Qwen2.5-Math 

```bash
huggingface-cli download --resume-download Qwen/Qwen3-1.7B --local-dir models/Qwen3-1.7B
cd eval_math
sh scripts/test.sh
```
Accuracy is 77% for `Qwen3-1.7B` on GSM8K.

## Math (OpenAI-SDK)
See `eval_math_api`

## MMLU
TODO
```bash
cd eval_mmlu
```
