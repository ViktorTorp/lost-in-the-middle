# bash script to run GPT baseline on NQ-open

############################################
# Oracle setting GPT
############################################
# Regular
python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 100 --output-path qa_predictions/20_total_documents/gpt/nq-open-oracle-gpt-35-predictions.jsonl.gz --oracle
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt/nq-open-oracle-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt/nq-open-oracle-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt/oracle_position_scores.csv --position-idx 0


# TOT
python -u ./scripts/get_qa_responses_from_gpt_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 512 --output-path qa_predictions/20_total_documents/gpt_tot/nq-open-oracle-gpt-35-predictions.jsonl.gz --oracle --tot-prompting
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_tot/nq-open-oracle-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_tot/nq-open-oracle-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_tot/oracle_position_scores.csv --position-idx 0


# COT
python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 256 --output-path qa_predictions/20_total_documents/gpt_cot/nq-open-oracle-gpt-35-predictions.jsonl.gz --oracle --cot-prompting
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_cot/nq-open-oracle-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_cot/nq-open-oracle-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_cot/oracle_position_scores.csv --position-idx 0


############################################
# Closed-book setting GPT
############################################
# Regular
python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 100 --output-path qa_predictions/20_total_documents/gpt/nq-open-closedbook-gpt-35-predictions.jsonl.gz --closedbook
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt/nq-open-closedbook-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt/nq-open-closedbook-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt/closedbook_position_scores.csv --position-idx 0

# TOT
python -u ./scripts/get_qa_responses_from_gpt_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 512 --output-path qa_predictions/20_total_documents/gpt_tot/nq-open-closedbook-gpt-35-predictions.jsonl.gz --closedbook --tot-prompting
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_tot/nq-open-closedbook-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_tot/nq-open-closedbook-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_tot/closedbook_position_scores.csv --position-idx 0

# COT
python -u ./scripts/get_qa_responses_from_gpt.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model gpt-3.5-turbo-1106 --max-new-tokens 256 --output-path qa_predictions/20_total_documents/gpt_cot/nq-open-closedbook-gpt-35-predictions.jsonl.gz --closedbook --cot-prompting
python -u ./scripts/evaluate_qa_responses.py --input-path qa_predictions/20_total_documents/gpt_cot/nq-open-closedbook-gpt-35-predictions.jsonl.gz --output-path qa_predictions/20_total_documents/gpt_cot/nq-open-closedbook-gpt-35-predictions-scored.jsonl.gz --position-csv qa_predictions/20_total_documents/gpt_cot/closedbook_position_scores.csv --position-idx 0
