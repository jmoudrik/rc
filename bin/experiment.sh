
EXPERIMENT_DB_FILE=~/.experiment_db


hash () {
	date +'%s %N' | md5sum | sed 's/^\(.\{,12\}\).*$/\1/'
}

e_save () {
	[ -z "$1" ] && { echo 'need prefix as $1' ; return 1 ; }
	NO_SPACE=$(echo "$1" | sed '/ /d')
	[ -z "$NO_SPACE" ] && { echo 'sry, $1 cannot contain spaces' ; return 1 ; }

	PREFIX="$1"
	FN_REL="$PREFIX.$(hash)"
	DIR=$(dirname "$FN_REL")
	BASE=$(basename "$FN_REL")
	DIR_ABS=$( cd "$DIR" ; pwd )
	FN_ABS="$DIR_ABS/$BASE"

	shift 1
	[ -z "$1" ] && { echo 'need name as $2-$...' ; return 1 ; }

	cat > "$FN_ABS"

	echo "$FN_ABS" "$@" >> $EXPERIMENT_DB_FILE

	FILESIZE=$(stat -c%s "$FN_ABS")
	echo
	echo "Written $FILESIZE bytes for $PREFIX"
}

e_describe () {
	[ -z "$1" ] && { echo 'need filename as $1' ; return 1 ; }

	MATCHES=$(cat "$EXPERIMENT_DB_FILE" | grep "$1" | wc -l)

	[ "$MATCHES" != 1 ] && { echo "got $MATCHES matches for '$1', specify further" ; return 1 ; } 

	cat "$EXPERIMENT_DB_FILE" | grep "$1" | sed 's/[^ ]* //'
}

#save "$@"
#e_describe "$1"
