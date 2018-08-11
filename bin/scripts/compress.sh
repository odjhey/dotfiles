
mkdir r

# convert -strip -interlace Plane -gaussian-blur 0.05 -quality 15% scr.png scr2.jpg
for file in `ls -p | grep -v / | grep -v .sh`
  do convert -strip -interlace Plane -gaussian-blur 0.05 -quality 15% $file r/conv_$file
done

