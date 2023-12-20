# 70B Model
export API_KEY=YOUR_API_KEY


############################################
# Vanilla Llama
############################################
echo "-----"
echo "Running Llama experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running Llama on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz
    echo "Evaluating model"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/original_position_scores.csv --position-idx ${gold_index}
    echo "Done running Llama on NQ-Open with 20 total documents, gold at ${gold_index}"
done



############################################
# Reordered Llama
############################################

# Calculating the reposition evals 20 docs
echo "-----"
echo "Calculating the reposition evals 20 docs"
echo "-----"
for gold_index in 0 4 9 14 19; do
    python -u ./scripts/evaluate_qa_responses_reorder.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama/original_position_scores_kfold.csv --position-idx ${gold_index}
done

echo "-----"
echo "Running reorder experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running Llama with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_reponses_from_llama_reorder.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --model llama-2-70b --max-new-tokens 100 --query-aware-contextualization --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_reordered/original_position_scores.csv
done

echo "-----"
echo "Evaluating reorder experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
#     echo "Running GPT with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_reordered/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_reordered/original_position_scores.csv --position-idx ${gold_index}
done

############################################
# COT Llama
############################################
echo "-----"
echo "Running Llama COT experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running Llama on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model llama-2-70b --max-new-tokens 250 --cot-prompting --llama-prompting --output-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz
    echo "Evaluating model"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_COT/original_position_scores.csv --position-idx ${gold_index}
    echo "Done running Llama on NQ-Open with 20 total documents, gold at ${gold_index}"
done


############################################
# TOT Llama
############################################

echo "-----"
echo "Running Llama TOT experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running Llama on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_responses_from_llama_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model llama-2-70b --max-new-tokens 500 --tot-prompting --llama-prompting --api-key $API_KEY --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz
    echo "Evaluating model"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-20_total_documents_gold_at_${gold_index}-llama-2-70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_tot/original_position_scores.csv --position-idx ${gold_index}
done