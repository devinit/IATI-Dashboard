echo "Removing 'out' directory and creating a new one"
rm -rf out
mkdir out

echo "Fetching data"
./fetch_data.sh &> fetch_data.log || exit 1

echo "Running make_csv.py"
python make_csv.py || exit 1

echo "Make a backup of the old web directory and make new content live"
# uses "switch value of two variables via a temp variable algorithm"
rsync -a --delete web web.bk
mv web web.1
mv out web
rm -rf web.1
