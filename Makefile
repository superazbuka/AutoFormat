compile: main.cpp
	clang++ -g -std=c++17 -Wall -Wextra -Wconversion -Wshadow main.cpp -o main

format: main.cpp
	cat main.cpp >prepared_tmp.cpp
	sed -i -e 's/ and / \&\& /g' prepared_tmp.cpp
	sed -i -e 's/ or / || /g' prepared_tmp.cpp
	clang-format prepared_tmp.cpp >prepared.cpp
	rm prepared_tmp.cpp
	make check

check: prepared.cpp
	python2 cpplint.py --filter=-,+build/include,-build/include_order,-build/include_what_you_use,+build/storage_class,+readability/alt_tokens,+readability/braces,+readability/casting,+readability/inheritance,+runtime/casting,+runtime/explicit,+whitespace/blank_line,+whitespace/braces,+whitespace/comma,+whitespace/comments,+whitespace/empty_conditional_body,+whitespace/empty_loop_body,+whitespace/end_of_line,+whitespace/ending_newline,+whitespace/forcolon,+whitespace/indent,+whitespace/line_length,+whitespace/newline,+whitespace/operators,+whitespace/parens,+whitespace/semicolon,+whitespace/tab --linelength=100 prepared.cpp
