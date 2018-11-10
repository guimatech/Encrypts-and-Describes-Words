#!/bin/bash

n() { echo "a b c d e f g h i j k l m n o p q r s t u v w x y z" | cut -d $1 -f1 | tr " " "\n" | wc -l; }

rdn() { echo "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" | cut -d " " -f$(((($RANDOM % 25)) +1)); }

c() { echo "z y x w v u t s r q p o n m l k j i h g f e d c b a" | cut -d " " -f$1 ; }

if [ "$1" == "" ]; then
  exit;
fi

echo "Palavra original: $1"

phrase0=$1

echo

phrase1="$(echo "$phrase0" | tr "[A-Z]" [a-z])"

phrase2="$(echo "$phrase1" | tr "abcdefghijklmnopqrstuvwxyz" "zyxwvutsrqponmlkjihgfedcba")"

phrase3="$(echo "$phrase2" | tr " " "$")"

phrase4="$(echo "$phrase3" | tr "\n" "@")"

phrase5="$(for p in $(seq "$(echo -n "$phrase4" | wc -c)");do
  char="$(echo -n "$phrase4" | cut -b$p )"
  ischar="$(echo "$char" | grep [a-z])"
  if [ "$ischar" != "" ]; then
    n $char;
  else
    echo "$char";
  fi
done | tr "\r" " ")"

phrase6="$(for p in $phrase5;do
  let count++;
  isnum="$(echo "$p" | grep [0-9])"
  if [ "$isnum" != "" ]; then
      echo -n "$(($p * $count)) $(rdn)";
  else
      echo -n "$p $(rdn)";
  fi
done | tr -d " ")"

echo "Palavra criptografada: $phrase6"

echo

echo "Descriptografando: $phrase6"

dphrase0="$(for p in $(seq "$(echo -n "$phrase6" | tr "[A-Z]" " " | tr " " "\n" | wc -l)");do
  charac="$(echo "$phrase6" | tr "[A-Z]" " " | cut -d " " -f$p)"
  isnum="$(echo "$charac" | grep "[0-9]")"
    if [ "$isnum" != "" ]; then
      echo "$(($charac/$p))";
    else
      echo "$charac";
    fi
done)"

dphrase1="$(for p in $dphrase0;do
  isnum="$(echo "$p" | grep "[0-9]")"
    if [ "$isnum" != "" ]; then
      c $p;
    else
      echo "$p";
    fi
done | tr -d "\n")"

dphrase2="$(echo "$dphrase1" | tr "$" " ")"

dphrase3="$(echo "$dphrase2" | tr "@" "\n")"

echo

echo  "Palavra Descriptografada: $dphrase3"