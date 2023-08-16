mkdir -p artefacts
archive=artefacts/old/`date +"%s"`
mkdir -p $archive
mv artefacts/*.uf2 $archive

rm -rf build

west build --pristine -s zmk/app -b "nice_nano_v2" -- -DZMK_CONFIG="config" -DSHIELD="corne_left nice_view_adapter nice_view"
mv build/zephyr/zmk.uf2 artefacts/corne_left.uf2

rm -rf build
west build --pristine -s zmk/app -b "nice_nano_v2" -- -DZMK_CONFIG="config" -DSHIELD="corne_right nice_view_adapter nice_view"
mv build/zephyr/zmk.uf2 artefacts/corne_right.uf2

# Uncomment this to make the reset firmware when the halves don't want to pair
# west build --pristine -s zmk/app -b "nice_nano_v2" -- -DZMK_CONFIG="config" -DSHIELD="settings_reset"
# mv build/zephyr/zmk.uf2 artefacts/settings_reset.uf2

md5sum artefacts/*.uf2
md5sum $archive/*.uf2
