project(parser)

set(INCLUDE_FILES Parser.h
	)
set(SRC_FILES Parser.cpp
	)

include(make_library)
make_library()
