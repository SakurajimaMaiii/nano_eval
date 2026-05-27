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
GEN_ARGS=(
  --temperature 0.6
  --top_p 0.95
  --top_k -1
  --max_tokens 65536
)
# qwen3-8b
# GEN_ARGS=(
#   --temperature 0.6
#   --top_p 0.95
#   --top_k 20
#   --max_tokens 38912
# )

MODEL_ARGS=(
  --base_url "http://127.0.0.1:8000/v1"
  --model_name "models/deepseek-ai/DeepSeek-R1-0528-Qwen3-8B"
)

echo "=====>AIME24"
IO_ARGS=(
  --input_file "./data/aime24.jsonl"
  --output_file "../../logs/output/deepseek_8b/aime24_bz64.jsonl"
)
python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"

echo "=====>AIME25"
IO_ARGS=(
  --input_file "./data/aime25.jsonl"
  --output_file "../../logs/output/deepseek_8b/aime25_bz64.jsonl"
)
python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"


echo "=====>GPQA"
IO_ARGS=(
  --input_file "./data/gpqa_diamond.jsonl"
  --output_file "../../logs/output/deepseek_8b/gpqa_diamond_bz64.jsonl"
)
python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"


echo "=====>HMMT"
IO_ARGS=(
  --input_file "./data/hmmt25.jsonl"
  --output_file "../../logs/output/deepseek_8b/hmmt25_bz64.jsonl"
)

python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"





# TODO:  HMMT25 for qwen3-8b is not finish!!!!!!!!!!!!!!!!!!!!!!!!!!!!



###########################################################################
# aime24 (repeated sample 64 times)
# python ./generate_api_answers/infer_multithread.py --input_file "./data/aime24.jsonl" \
#                                                    --output_file "./output/aime24_bz64.jsonl"  \
#                                                    --base_url "http://127.0.0.1:8000/v1"\
#                                                    --model_name "models/deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B" \
#                                                    --temperature 0.6 --top_p 0.95 --top_k -1 --max_tokens 32768

# # # aime25 (repeated sample 64 times)
# python ./generate_api_answers/infer_multithread.py --input_file "./data/aime25.jsonl" \
#                                                    --output_file "./output/aime25_bz64.jsonl"  \
#                                                    --base_url "http://127.0.0.1:8000/v1"\
#                                                    --model_name "models/deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B" \
#                                                    --temperature 0.6 --top_p 0.95 --top_k -1 --max_tokens 32768
# # livebench 2408-2502 (repeated sample 8 times)
# python ./generate_api_answers/infer_multithread.py --input_file "./data/livecodebench_v5.jsonl" --output_file "./output/livecodebench_v5_bz8.jsonl"  --base_url "http://127.0.0.1:8030/v1" --model_name "Qwen/QwQ-32B" --n_samples 8

# # IFEval
# python ./generate_api_answers/infer_multithread.py --input_file "./data/ifeval.jsonl" --output_file "./output/ifeval_bz1.jsonl"  --base_url "http://127.0.0.1:8030/v1" --model_name "Qwen/QwQ-32B" --n_samples 1