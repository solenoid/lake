# found relation ids over here https://www.openstreetmap.org/ looking for lake and bay water

curl -o lake-original.json http://polygons.openstreetmap.fr/get_geojson.py\?id\=63730\&params\=0
curl -o lake-bay-original.json http://polygons.openstreetmap.fr/get_geojson.py\?id\=3159581\&params\=0
npx geojson-merge lake-original.json lake-bay-original.json > lake-combined.json

# riffing from https://medium.com/@mbostock/command-line-cartography-part-3-1158e4c55a1e
# assuming a previous `npm install -g topojson` at this version
geo2topo -o lake-topo-original.json lake-combined.json
toposimplify -p 0.0000005 -o lake-topo-simplify.json lake-topo-original.json # -p 1 was the first guess
# topoquantize -o lake-topo-quantize.json 1e5 lake-topo-simplify.json
topo2geo lake-combined=lake.json < lake-topo-simplify.json
