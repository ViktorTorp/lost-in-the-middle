# bash script to run llama baseline on NQ-open

export API_KEY=YOUR_API_KEY

############################################
# Closed-book setting llama
############################################
# Regular
python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 100 --output-path qa_predictions/20_total_documents/llama_70b/nq-open-closedbook-llama_70b-predictions.jsonl.gz --closedbook --llama-prompting
# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-closedbook-llama_70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-closedbook-llama_70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/closedbook_position_scores.csv --position-idx 0


# TOT
python -u ./scripts/get_qa_responses_from_llama_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 512 --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-closedbook-llama_70b-predictions.jsonl.gz --closedbook --tot-prompting --api-key $API_KEY --llama-prompting
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-closedbook-llama_70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-closedbook-llama_70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_tot/closedbook_position_scores.csv --position-idx 0

# COT
# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 256 --output-path qa_predictions/20_total_documents/llama_70b_cot/nq-open-closedbook-llama_70b-predictions.jsonl.gz --closedbook --cot-prompting --llama-prompting
# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_cot/nq-open-closedbook-llama_70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_cot/nq-open-closedbook-llama_70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_cot/closedbook_position_scores.csv --position-idx 0
############################################
# Oracle setting llama
############################################
# Regular
# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 100 --output-path qa_predictions/20_total_documents/llama_70b/nq-open-oracle-llama_70b-predictions.jsonl.gz --oracle --llama-prompting
# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b/nq-open-oracle-llama_70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b/nq-open-oracle-llama_70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b/oracle_position_scores.csv --position-idx 0

# TOT
python -u ./scripts/get_qa_responses_from_llama_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 512 --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-oracle-llama_70b-predictions.jsonl.gz --oracle --tot-prompting --api-key $API_KEY --llama-prompting
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-oracle-llama_70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_tot/nq-open-oracle-llama_70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_tot/oracle_position_scores.csv --position-idx 0

# COT
# python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-70b --max-new-tokens 256 --output-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-oracle-llama_70b-predictions.jsonl.gz --oracle --cot-prompting --llama-prompting
# python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-oracle-llama_70b-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/llama_70b_COT/nq-open-oracle-llama_70b-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/llama_70b_COT/oracle_position_scores.csv --position-idx 0


