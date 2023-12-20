# bash script to run llama baseline on NQ-open

# Create an api variable
export API_KEY=YOUR_API_KEY

############################################
# Closed-book setting llama
############################################
# Regular
python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 100 --output-path qa_predictions/20_total_documents/llama/nq-open-closedbook-llama-predictions.jsonl.gz --closedbook --llama-prompting


# TOT
python -u ./scripts/get_qa_responses_from_llama_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 512 --output-path qa_predictions/20_total_documents/llama_tot/nq-open-closedbook-llama-predictions.jsonl.gz --closedbook --tot-prompting --api-key $API_KEY --llama-prompting


# COT
python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 256 --output-path qa_predictions/20_total_documents/llama_cot/nq-open-closedbook-llama-predictions.jsonl.gz --closedbook --cot-prompting --llama-prompting


############################################
# Oracle setting llama
############################################
# Regular
python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 100 --output-path qa_predictions/20_total_documents/llama/nq-open-oracle-llama-predictions.jsonl.gz --oracle --llama-prompting



# TOT
python -u ./scripts/get_qa_responses_from_llama_tot.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 512 --output-path qa_predictions/20_total_documents/llama_tot/nq-open-oracle-llama-predictions.jsonl.gz --oracle --tot-prompting --api-key $API_KEY --llama-prompting


# COT
python -u ./scripts/get_qa_responses_from_llama.py --input-path qa_data/20_total_documents/nq-open-20_total_documents_gold_at_0.jsonl.gz --model llama-2-7b --max-new-tokens 256 --output-path qa_predictions/20_total_documents/llama_COT/nq-open-oracle-llama-predictions.jsonl.gz --oracle --cot-prompting --llama-prompting

