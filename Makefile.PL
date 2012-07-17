use inc::Module::Install;
name 'WWW-Search-Techbang';
all_from 'lib/WWW/Search/Techbang.pm';

requires 'parent' => 0,
    'WWW::Search' => 2.565;

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';

auto_include;
WriteAll;
