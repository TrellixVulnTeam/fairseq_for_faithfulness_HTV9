BEAM_SIZE=6
MAX_LEN_B=128
MIN_LEN=10
LEN_PEN=1.0
DATA=/scratch/tw2112/codes/ablation/giga

DATA_PATH=$DATA/giga_binarized
MODEL_PATH=$DATA/ckpt2/checkpoint_best.pt
RESULT_PATH=./outdir/giga


fairseq-generate $DATA_PATH \
    --path $MODEL_PATH --results-path $RESULT_PATH \
    --task translation \
    --beam $BEAM_SIZE --max-len-b $MAX_LEN_B --min-len $MIN_LEN --lenpen $LEN_PEN \
    --no-repeat-ngram-size 3 \
    --batch-size 32 --fp16 \
    --truncate-source --gen-subset test;


python  convert_bart_test.py --generate-dir $RESULT_PATH