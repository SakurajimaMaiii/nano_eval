mkdir -p output
#!/bin/bash

IO_ARGS=(
  --input_file "./data/gpqa_diamond.jsonl"
  --output_file "./output/gpqa_diamond_bz64.jsonl"
)

MODEL_ARGS=(
  --base_url "http://127.0.0.1:8000/v1"
  --model_name "deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"
)

GEN_ARGS=(
  --temperature 0.6
  --top_p 0.95
  --top_k -1
  --max_tokens 32768
)

set -e

python ./generate_api_answers/infer_multithread.py \
  "${IO_ARGS[@]}" \
  "${MODEL_ARGS[@]}" \
  "${GEN_ARGS[@]}"



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