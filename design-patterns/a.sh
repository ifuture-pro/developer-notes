
function step(){

    echo -e "\n\033[4;31m $1\033[0m - \033[4;36m${@:2}\033[0m \n"
}

function highlight(){
    echo -e "\033[36m${@:1}\033[0m"
}

function info(){
    echo -e "\033[32m${@:1}\033[0m"
}

function warn(){
    echo -e "\033[33m${@:1}\033[0m"
}

function print_line()
{
  name=${@:1}
  l=`echo $name |awk -F "" '{print NF}'`
  outword=-
  shellwidth=`stty size|awk '{print $2}'`
  ll=`expr $shellwidth - $l`
  lll=`expr $ll / 2`
  tmp=3
  lll=`expr $lll - $tmp`
  yes `echo -e "\033[36m \033[0m"` | sed $tmp'q' | tr -d '\n'
  printf "`echo -e "\033[36m$name\033[0m"`"
  yes `echo -e "\033[36m \033[0m"` | sed $tmp'q' | tr -d '\n'
  yes `echo -e "\033[36m$outword\033[0m"` | sed $lll'q' | tr -d '\n'
}

function split_file(){
    split -l 1000 $1 split-
}

folder="."
files=$(ls $folder)
for filename in $files;do
    if [[ $filename = "*md" ]];
    then
        data_file=`basename $filename`
        split_file $filename
        info "$filename"
        sleep 2
        split_files=$(ls $folder)
        for filename in $split_files;do
            info "$filename"
            if [[ $filename =~ "split-" ]];
                then
                info "$filename"
                #curl  -H 'Content-Type: application/json' -XPOST  "$api/_bulk?pretty" --data-binary "@$filename" > test.log
            fi
        done
        rm -rf split-*
    fi
done
