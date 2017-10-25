del ebin/*.beam
erl -make
cd src/lager
##for %%i in (*.erl) do erlc -pa ../../ebin -I ../../include +'{parse_transform, lager_transform}' +'{lager_truncation_size, 1024}' %%i
@pause