#!/bin/bash
set -ex

log_dir="../../logs"
model_name="Qwen3-30B-A3B"
file_name="hmmt25_bz64"
task_name="math_opensource/hmmt25"

input_path="${log_dir}/output/${model_name}/${file_name}.jsonl"
cache_path="${log_dir}/eval_res/${model_name}/${file_name}.jsonl"
result_path="${log_dir}/eval_res/${model_name}/${file_name}_res_result.txt"

mkdir -p "${log_dir}/eval_res/${model_name}"

{
    python -u eval/eval.py \
      --input_path "${input_path}" \
      --cache_path "${cache_path}" \
      --task_name "${task_name}"

    python -u eval/eval_major_pass.py \
      --file_path "${cache_path}"

    echo "eval finish"
} 2>&1 | tee "${result_path}"