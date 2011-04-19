#!/bin/sh
 
# (C) Adriweb (Adrien Bertrand) & Lionel Debroux & ExtendeD 2011
# Contact : adrienbertrand@msn.com , lionel_debroux@yahoo.fr , olivier.calc@gmail.com

# Version 1.6

# .lua script to .tns Nspire document converter

# Visit http://www.ti.bank.free.fr, http://www.omnimaga.org and http://www.cemetech.net for more incredible stuff about TI Calculators !

echo '----------------------------------------------'
echo '             Lua to TNS Converter'
echo ' (C) Adriweb & Lionel Debroux & ExtendeD, 2011'
echo '----------------------------------------------'
echo ''

# Force overwrite output file ?
if [ "x$1" = "x-f" ]; then
    shift;
elif [ -f "$1" ]; then
    echo "Usage: LuaToTNS.sh [-f to force overwrite] <output TNS file> <input Lua file>"
    exit 1
fi

if [ -f "$2" ]; then
    TEMPFOLDER="`mktemp -d -t XXXXXXXXXXXX`"
    iscygwin=`uname -a | grep Cygwin`
    if [ "x$iscygwin" != "x" ]; then
        TEMPFOLDER=`cygpath --windows "$TEMPFOLDER"`
    fi
    TEMPXML="$TEMPFOLDER/Problem1.xml";
    message='';
    exitcode=1
    echo 'Adding prolog'
    cat << EOF > "$TEMPXML"
<?xml version="1.0" encoding="UTF-8" ?><prob xmlns="urn:TI.Problem" ver="1.0" pbname=""><sym></sym><card clay="0" h1="10000" h2="10000" w1="10000" w2="10000"><isDummyCard>0</isDummyCard><flag>0</flag><wdgt xmlns:sc="urn:TI.ScriptApp" type="TI.ScriptApp" ver="1.0"><sc:mFlags>0</sc:mFlags><sc:value>-1</sc:value><sc:script>
EOF
    echo 'Adding the Lua script'
    cat "$2" | sed -e 's/\&/\&amp;/g' | sed -e "s/'/\&apos;/g" | sed -e 's/"/\&quot;/g' | sed -e 's/</\&lt;/g' | sed -e 's/>/\&gt;/g' >> "$TEMPXML"
    echo 'Adding epilog'
    cat << EOF >> "$TEMPXML"
</sc:script></wdgt></card></prob>
EOF
    echo 'Zipping the xml...'
    TEMPZIP="$TEMPFOLDER/zipfile.zip"
    WORK="`pwd`"
    cd "$TEMPFOLDER"
    zip -9 -q -X -j "$TEMPZIP" "$TEMPXML" || 7za a "$TEMPZIP" "$TEMPXML" || message='FAILED'
    if [ "x$message" = "x" ]; then
        cd "$WORK"
        echo "Concatenating the files..."
        cat << EOF | awk 'BEGIN{ORS=""}{printf("%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16)}' - > "$1"
42 84 73 77 76 80 48 53 48 48 20 0 0 0 13 0
60 23 141 62 115 69 104 68 64 1 0 0 147 2 0 0
12 0 0 0 68 111 99 117 109 101 110 116 46 120 109 108
15 206 216 210 129 6 134 91 98 129 194 166 33 165 253 8
35 15 146 174 56 69 42 5 102 187 199 223 152 135 85 19
97 71 117 36 102 249 113 31 205 229 179 65 93 19 51 78
114 14 8 251 118 135 230 29 143 147 24 50 231 6 146 106
88 240 119 34 9 186 202 37 179 142 123 82 152 197 84 154
95 140 52 158 53 245 107 117 69 199 122 16 138 95 110 13
230 74 30 144 146 186 28 209 150 176 193 25 205 92 13 39
155 25 47 88 111 73 20 149 13 241 58 200 153 130 46 163
173 54 158 183 19 40 170 155 137 181 48 252 63 212 210 69
190 196 127 134 135 113 37 9 209 237 179 211 146 105 223 181
148 114 166 55 88 88 196 212 41 209 186 175 132 74 46 207
46 123 251 189 145 172 153 186 168 204 192 149 91 33 228 61
88 250 143 196 33 199 102 197 123 167 49 159 112 45 30 206
55 138 19 225 232 30 136 103 17 124 62 125 117 82 189 154
64 215 175 61 161 16 58 235 145 200 141 74 36 155 56 133
143 56 181 60 181 163 250 27 190 74 202 147 215 65 105 2
13 173 48 109 186 8 84 252 19 232 250 235 192 253 232 173
81 26 74 137 149 58 39 212 242 204 64 70 205 201 138 20
213 131 223 96 220 206 6 94 158 46 177 211 84 151 247 123
174 111 81 79 116 220 87 106 212 127 55 42 73 186 134 42
EOF
        cat "$TEMPZIP" >> "$1"
        message="Done ! ($1)"
        exitcode=0
    fi
else
    echo "Usage: LuaToTNS.sh [-f to force overwrite] <output TNS file> <input Lua file>"
    exit 1
fi

echo "Cleaning up"
rm -f "$TEMPXML"
rm -f "$TEMPZIP"
rmdir "$TEMPFOLDER"
echo "$message"
exit $exitcode