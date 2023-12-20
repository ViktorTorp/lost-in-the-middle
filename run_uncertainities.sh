
# # LLama regular
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores.csv --position-idx ${gold_index}
# done

# # # LLAMA reordered k=5
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_reordered/original_position_scores.csv --position-idx ${gold_index}
# done

# # # LLAMA reordered k=10
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_reordered_k10/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-k10-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_reordered_k10/original_position_scores.csv --position-idx ${gold_index}
# done


# # # LLAMA COT
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_COT/original_position_scores.csv --position-idx ${gold_index}
# done

# # LLAMA TOT
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_tot/original_position_scores.csv --position-idx ${gold_index}
# done

# # # LLama 70b regular
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx ${gold_index}
# done

# # # LLAMA  70b reordered k=5
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-reordered-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_reordered/original_position_scores.csv --position-idx ${gold_index}
# done


# # # LLAMA 70b COT
for gold_index in 0 4 9 14 19; do
    python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_COT/original_position_scores.csv --position-idx ${gold_index}
done

# # LLAMA 70b TOT
for gold_index in 0 4 9 14 19; do
    python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_tot/original_position_scores.csv --position-idx ${gold_index}
done


# # GPT
# # gpt regular
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt/original_position_scores.csv --position-idx ${gold_index}
# done

# gpt reordered k=5
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/gpt_reordered/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-reorder-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_reordered/original_position_scores.csv --position-idx ${gold_index}
# done


# gpt TOT
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/gpt_tot/nq-open-20_total_documents_gold_at_${gold_index}-tot-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_tot/original_position_scores.csv --position-idx ${gold_index}
# done

# gpt COT
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/get_uncertainities.py --input-path qa_predictions/20_total_documents/gpt_cot/nq-open-20_total_documents_gold_at_${gold_index}-cot-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_cot/original_position_scores.csv --position-idx ${gold_index}
# done