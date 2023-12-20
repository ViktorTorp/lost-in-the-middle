# 20 Doc experiment

############################################
# Vanilla GPT
############################################
echo "-----"
echo "Running GPT experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running GPT-3.5 on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 100 --query-aware-contextualization --output-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions.jsonl.gz
    echo "Evaluating model"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt/original_position_scores.csv --position-idx ${gold_index}
    echo "Done running GPT-3.5 on NQ-Open with 20 total documents, gold at ${gold_index}"
done

############################################
# Reordered GPT
############################################

# Calculating the reposition evals 20 docs
echo "-----"
echo "Calculating the reposition evals 20 docs"
echo "-----"
for gold_index in 0 4 9 14 19; do
    python -u ./scripts/evaluate_qa_responses_reorder.py --input-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt/original_position_scores_kfold.csv --position-idx ${gold_index}
done

echo "-----"
echo "Running reorder experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
#     echo "Running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_reponses_from_gpt_reorder.py --input-path qa_predictions/20_total_documents/gpt/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-predictions.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 100 --output-path qa_predictions/20_total_documents/gpt_reordered/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-reorder-predictions.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_reordered/original_position_scores.csv
done

echo "-----"
echo "Evaluating reorder experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
#     echo "Running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_reordered/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-reorder-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_reordered/nq-open-20_total_documents_gold_at_${gold_index}-gpt-35-reorder-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt/original_position_scores.csv --position-idx ${gold_index}
done

############################################
# COT GPT
############################################
echo "-----"
echo "Running GPT COT experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running GPT-3.5 on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 256 --output-path qa_predictions/20_total_documents/gpt_cot/nq-open-20_total_documents_gold_at_${gold_index}-cot-gpt-35-predictions.jsonl.gz --cot-prompting
    echo "Evaluating model"
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_cot/nq-open-20_total_documents_gold_at_${gold_index}-cot-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_cot/nq-open-20_total_documents_gold_at_${gold_index}-cot-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_cot/original_position_scores.csv --position-idx ${gold_index}
    echo "Done running GPT-3.5 on NQ-Open with 20 total documents, gold at ${gold_index}"
done

############################################
# TOT GPT
############################################

echo "-----"
echo "Running GPT TOT experiments"
echo "-----"
for gold_index in 0 4 9 14 19; do
    echo "Running GPT-3.5 on NQ-Open with 20 total documents, gold at ${gold_index}"
    python -u ./scripts/get_qa_responses_from_gpt_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_${gold_index}.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 256 --output-path qa_predictions/20_total_documents/gpt_tot/nq-open-20_total_documents_gold_at_${gold_index}-tot-gpt-35-predictions.jsonl.gz --tot-prompting
    python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_tot/nq-open-20_total_documents_gold_at_${gold_index}-tot-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_tot/nq-open-20_total_documents_gold_at_${gold_index}-tot-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_tot/original_position_scores.csv --position-idx ${gold_index}
    echo "Done running GPT-3.5 with reorder on NQ-Open with 20 total documents, gold at ${gold_index}"
done
