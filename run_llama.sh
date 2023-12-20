# 7B Model
export API_KEY=YOUR_API_KEY

# 20 Doc experiment
# echo "-----"
# echo "Running GPT experiments"
# echo "-----"

# Regular llama
# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_0-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/0.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_4.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_4-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/4.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_9.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_9-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/9.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_14.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_14-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/14.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_19.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_19-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/19.log &



# Cot llama
# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 250 --cot-prompting --llama-prompting --output-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_0-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/0.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_4.jsonl.gz --model llama-2-7b --max-new-tokens 250 --cot-prompting --llama-prompting --output-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_4-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/4.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_9.jsonl.gz --model llama-2-7b --max-new-tokens 250 --cot-prompting --llama-prompting --output-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_9-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/9.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_14.jsonl.gz --model llama-2-7b --max-new-tokens 250 --cot-prompting --llama-prompting --output-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_14-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/14.log &

# nohup python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_19.jsonl.gz --model llama-2-7b --max-new-tokens 250 --cot-prompting --llama-prompting --output-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_19-llama-2-7b-predictions.jsonl.gz > logs/llama_qa/19.log &



# echo "-----"
# echo "Evaluating LLAMA experiments"
# echo "-----"
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores.csv --position-idx ${gold_index}
# done

# Reposition evals 20 docs
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/evaluate_qa_responses_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_k10fold.csv --position-idx ${gold_index}
# done


# for gold_index in 9 14 19; do
# #     echo "Running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
#     python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered_k10/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-k10-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_k10fold.csv
#     echo "Done running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"

#     python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_reordered_k10/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-k10-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_reordered_k10/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-k10-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_reordered_k10/original_position_scores.csv --position-idx ${gold_index}
# done

# python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_0-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_0-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv

# python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_4-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_4-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv

# python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_9-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_9-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv

# python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_14-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_14-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv

# python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_19-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_19-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv

# python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_14-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_14-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv

# echo "-----"
# echo "Running reorder experiments"
# echo "-----"
# for gold_index in 0 4 9 14 19; do
# #     echo "Running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
#     python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions.jsonl.gz --model llama-2-7b --max-new-tokens 100 --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv
#     echo "Done running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
# done


# # # # Reposition evals 20 docs
# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-reordered-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_reordered/reordered_position_scores.csv --position-idx ${gold_index}
# done





# Regular llama 70b
# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_0-llama-2-70b-predictions.jsonl.gz

# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_0-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_0-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx 0

# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_4.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_4-llama-2-70b-predictions.jsonl.gz

# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_4-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_4-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx 4

# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_9.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_9-llama-2-70b-predictions.jsonl.gz

# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_9-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_9-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx 9

# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_14.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_14-llama-2-70b-predictions.jsonl.gz

# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_14-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_14-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx 14
# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_19.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_19-llama-2-70b-predictions.jsonl.gz

# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_19-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_19-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx 19

for gold_index in 19; do
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-7b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_COT/original_position_scores.csv --position-idx ${gold_index}
done



# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/evaluate_qa_responses_reorder.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores_kfold.csv --position-idx ${gold_index}
# done

# for gold_index in 0 4 9 14 19; do
#     echo "Running llama 70b with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
#     python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --model llama-2-70b --max-new-tokens 100 --output-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-reordered-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores_kfold.csv
#     echo "Done running llama 70b with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
# done

# for gold_index in 0 4 9 14 19; do
#     python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-reordered-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-reordered-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_reordered/original_position_scores.csv --position-idx ${gold_index}
# done





# 70B llama tot
for gold_index in 4 9 14 19; do
#     echo "Running llama on NQ-Open with 20 total documents, gold at ${gold_index}"
#     python -u ./scripts/get_qa_responses_from_llama_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model llama-2-70b --max-new-tokens 500 --tot-prompting --llama-prompting --api-key $API_KEY --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz
#     echo "Done running llama on NQ-Open with 20 total documents, gold at ${gold_index}"
#     python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_tot/original_position_scores.csv --position-idx ${gold_index}
# done