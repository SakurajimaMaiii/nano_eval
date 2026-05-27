#!/bin/bash
set -ex

log_dir="../../logs"
model_name="deepseek_8b"
file_name="hmmt25_bz64"
task_name="math_opensource/hmmt25"

input_path="${log_dir}/output/${model_name}/${file_name}.jsonl"
cache_path="${log_dir}/eval_res/${model_name}/${file_name}.jsonl"
result_path="${log_dir}/eval_res/${model_name}/${file_name}_res_result.txt"

mkdir -p "${log_dir}/eval_res/${model_name}"

python eval/eval.py \
  --input_path "${input_path}" \
  --cache_path "${cache_path}" \
  --task_name "${task_name}" \
  > "${result_path}"

python eval/eval_major_pass.py \
  --file_path "${cache_path}"

echo "eval finish"