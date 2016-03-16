#!/bin/bash
#抓去sina各大联赛积分榜
#author:brace
#
#last edit:2013.4.17
#2013.4.17 add  integral_edit.pl #Adrian提供的格式化输出perl脚本
#
#

export PATH=/home/bbs/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/bbs/scripts
#--------------------------------------------------------------
BBSHOME_BIN=/home/bbs/bin
Post_BIN=$BBSHOME_BIN/postfilealt
#WORK_PATH=/home/brace/src
WORK_PATH=/home/bbs/src
TITLE=""
SPA_SCORE="http://sports.sina.com.cn/global/score/Spain/"
ITA_SCORE="http://sports.sina.com.cn/global/score/Italy/"
GER_SCORE="http://sports.sina.com.cn/global/score/Germany/"
ENG_SCORE="http://sports.sina.com.cn/global/score/England/"

#-------------------------------------------------------------

#用于判断积分榜更新否的变量
SCORE_DAY=""
TODAY=""
DIFF_DAY=""
#--------------------------------------------------------------

FORMAT_PERL=/home/bbs/src/integral_edit.pl #测试机脚本
#FORMAT_PERL=/home/brace/src/integral_edit.pl #xbwbbs脚本
#处理网页的临时文件
FILE_1=file1_tmp
FILE_2=file2_tmp
FILE_3=file3_tmp
FILE_4=file4_tmp
FILE_FIN=""
#-------------------------------------------------------------
cd $WORK_PATH
for i in $SPA_SCORE $ITA_SCORE $GER_SCORE $ENG_SCORE
do
    FILE_FIN=file_`echo $i|cut -d '/' -f 6`
    wget  $i -O $FILE_1 >/dev/null 2>&1
    sed -i 's/
//g' $FILE_1  #删除行末的^M字符
    iconv -f euc-cn -t utf-8 $FILE_1 -o $FILE_2 #转换编码 utf8方便进行名字替换。。gbk会sed报错
    sed -i 's/<[^<]*>//g' $FILE_2 #删除html标识

#----------------------------------------------------------------------------------------
#通过对比积分榜内容中的日期和当前时间判断积分榜是否更新，差距超过七天，则视为本周未更新。
    SCORE_DAY=`grep -o '[0-9]\{4\}\-[0-9]\{1,2\}\-[0-9]\{1,2\}' $FILE_2 |uniq`
    SCORE_DAY=`date --date="$SCORE_DAY" +%s`
    TODAY=`date +%s`
    DIFF_DAY=`expr $TODAY - $SCORE_DAY`
    DIFF_DAY=`expr $DIFF_DAY / 60 / 60 / 24`
    if [ $DIFF_DAY -ge 7 ]
    then
        rm -rf $FILE_1
        rm -rf $FILE_2
        exit 1
    fi
#------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------
#匹配内容
    sed -n '/[0-9]\{4\}\-[0-9]\{1,2\}\-[0-9]\{1,2\}/,/[0-9]\{4\}\-[0-9]\{1,2\}\-[0-9]\{1,2\}/p' $FILE_2>$FILE_3
    sed -i '$d' $FILE_3
    sed -n '1p' $FILE_3 >$FILE_4
    sed -i '1d' $FILE_3
    sed -i 's/[[:space:]]//g' $FILE_3
    sed -i '/^$/d' $FILE_3
#-------------------------------------------------------------------------------------------

#格式化输出
    $FORMAT_PERL $FILE_3
    echo  "\n \033[1;32m欧冠联赛正赛资格\033[m\n \033[1;35m欧冠联赛预选赛资格\033[m\n \033[1;33m联盟杯资格\033[m\n \033[1;31m降级区\033[m\n" >>$FILE_4
    grep "名次" $FILE_3 >>$FILE_4
#-------------------------------------------------------------------------------------------
#添加欧洲联赛资格以及降级球队标识
#西甲
    echo $FILE_FIN|grep -i 'spa'  >/dev/null 2>&1 &&grep ^[0-9] $FILE_3|awk '{if(NR<=3) print "\033[1;32m"$0"\033[m";else if(NR==4)print "\033[1;35m"$0"\033[m";else if(NR>=5&&NR<=6) print "\033[1;33m"$0"\033[m";else if (NR>=18) print "\033[1;31m"$0"\033[m";else print $0}' >>$FILE_4
#德甲

    echo $FILE_FIN|grep -i 'ger'  >/dev/null 2>&1 &&grep ^[0-9] $FILE_3|awk '{if(NR<=3) print "\033[1;32m"$0"\033[m";else if(NR==4)print "\033[1;35m"$0"\033[m";else if(NR>=5&&NR<=6) print "\033[1;33m"$0"\033[m";else if (NR>=16) print "\033[1;31m"$0"\033[m";else print $0}' >>$FILE_4
#英超

    echo $FILE_FIN|grep -i 'eng'  >/dev/null 2>&1 &&grep ^[0-9] $FILE_3|awk '{if(NR<=3) print "\033[1;32m"$0"\033[m";else if(NR==4)print "\033[1;35m"$0"\033[m";else if(NR==5) print "\033[1;33m"$0"\033[m";else if (NR>=18) print "\033[1;31m"$0"\033[m";else print $0}' >>$FILE_4
#意甲
    echo $FILE_FIN|grep -i 'ita'  >/dev/null 2>&1 &&grep ^[0-9] $FILE_3|awk '{if(NR<=2) print "\033[1;32m"$0"\033[m";else if(NR==3)print "\033[1;35m"$0"\033[m";else if(NR>=4&&NR<=5) print "\033[1;33m"$0"\033[m";else if (NR>=18) print "\033[1;31m"$0"\033[m";else print $0}' >>$FILE_4

#-------------------------------------------------------------------------------------------
    echo '\n 来源 http://sports.sina.com.cn/global/ \n' >>$FILE_4

#---------------------------------------------------------------
    iconv -f utf-8 -t gbk $FILE_4 -o $FILE_FIN #再次蛋疼的转换成gbk
    rm -rf $FILE_1 $FILE_2 $FILE_3 $FILE_4
    TITLE=`head -1 $FILE_FIN`

#使用postfilealt程序发帖
    $Post_BIN $WORK_PATH/$FILE_FIN Paulownia $TITLE Football >/dev/null 2>&1
    #$Post_BIN $WORK_PATH/$FILE_FIN Eve $TITLE Test >/dev/null 2>&1
    rm -rf $FILE_FIN
done