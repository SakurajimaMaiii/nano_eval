#!/bin/bash
set -ex
# decoding parameters for different models
# deepseek 1.5B
# GEN_ARGS=(
#   --temperature 0.6
#   --top_p 0.95
#   --top_k -1
#   --max_tokens 32768
# )
# deepseek 8B
# GEN_ARGS=(
#   --temperature 0.6
#   --top_p 0.95
#   --top_k -1
#   --max_tokens 65536
# )
# qwen3-8b/1.7b, for 1.7B, max tokens set to 32K is OK because 1.7B has only 32K context.
GEN_ARGS=(
  --temperature 0.6
  --top_p 0.95
  --top_k 20
  --max_tokens 38912
  --n_samples 64
)

MODEL_ARGS=(
  --base_url "http://127.0.0.1:8000/v1"
  --model_name "Qwen/Qwen3-30B-A3B"
)

echo "=====>AIME24"
IO_ARGS=(
  --input_file "./data/aime24.jsonl"
  --output_file "../../logs/output/Qwen3-30B-A3B/aime24_bz64.jsonl"
)
python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"

echo "=====>AIME25"
IO_ARGS=(
  --input_file "./data/aime25.jsonl"
  --output_file "../../logs/output/Qwen3-30B-A3B/aime25_bz64.jsonl"
)
python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"


echo "=====>GPQA"
IO_ARGS=(
  --input_file "./data/gpqa_diamond.jsonl"
  --output_file "../../logs/output/Qwen3-30B-A3B/gpqa_diamond_bz64.jsonl"
)
python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"


echo "=====>HMMT"
IO_ARGS=(
  --input_file "./data/hmmt25.jsonl"
  --output_file "../../logs/output/Qwen3-30B-A3B/hmmt25_bz64.jsonl"
)

python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"