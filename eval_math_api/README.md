Fork from https://github.com/QwenLM/QwQ.

New features:

1. support changing decoding paramters in `infer_multithread.py`

2. add GPQA-D/HMMT

3. support get major and pass rates, see `eval_major_pass.py`

First, start server with vllm, you may need parameters based on different machines.

```bash
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7
vllm serve deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B \
  --host 0.0.0.0 \
  --port 8000 \
  --data-parallel-size 8
```

Generate prediction
```bash
bash run_exp.sh
```

Evaluate

```bash
sh eval_score.sh
```