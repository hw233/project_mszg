erl -name 1@127.0.0.1 -setcookie efg -pz ../deps/erlsom/ebin -pz ../deps/erlcron/ebin -pz ../deps/boss_db/ebin -pz ../deps/boss_db/deps/poolboy/ebin -pz ../deps/boss_db/deps/mysql/ebin -pz ../deps/boss_db/deps/tiny_pq/ebin -pz ../deps/boss_db/deps/uuid/ebin -pz ../boss_db/deps/protobuffs/ebin -pz ../boss_db/deps/meck/ebin -pz ../boss_db/deps/jsx/ebin -pz ../boss_db/deps/gen_server2/ebin -pz ../boss_db/deps/aleppo/ebin -pz ../deps/boss_db/deps/ets_cache/ebin -pz ../deps/boss_db/deps/erlydtl/ebin -pz ../deps/thrift/ebin ../deps/boss_db/deps/redo/ebin -boot start_sasl -config elog -s inets -s reloader -eval "application:start(game)"
pause