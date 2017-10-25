CHCP 65001
cd config
start werl -smp -pa ../ebin -name server@127.0.0.1 -setcookie test -boot start_sasl -config sasl_log -s loginserver start