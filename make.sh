rm -rf ebin/*.beam
erl -make
erlc -pa ebin -I include -o ebin +'{parse_transform, lager_transform}' +'{lager_truncation_size, 1024}' src/lager/*.erl