set output 'dailyrate.png'
set terminal png size 800,600
set xdata time
set timefmt "%Y%m%d"
set format x "%m%d\n%a"
set grid
set key below

samples(x) =  $0 > 6 ? 7 : ($0+1)
shift7(x) = (back7=back6, back6=back5,back5 = back4, back4 = back3, back3 = back2, back2 = back1, back1 = x)
init(x) = (back1 = back2 = back3 = back4 = back5 = back6 = back7 = 0)
avg7(x) = (shift7(x), (back1+back2+back3+back4+back5+back6+back7)/samples($0) )

plot '< mysql XXXX \
         | tail -n+2' \
         using 1:3 t 'hitrate' w linespoints, \
    '' using 1:4 t '1rate' w linespoints, \
    '' using 1:5 t '2rate' w linespoints, \
    '' using 1:6 t '3rate' w linespoints, \
    '' using 1:7 t '4rate' w linespoints, \
    '' using 1:8 t '5rate' w linespoints, \
    '' using 1:9 t '6rate' w linespoints, \
    '' using 1:10 t '7rate' w linespoints 

set output 'dailyrateWeeklySmooth.png'
set terminal png size 800,600
set xdata time
set timefmt "%Y%m%d"
set format x "%m%d\n%a"
set grid
set key below

plot sum=init(0),'< mysql XXXX\
         | tail -n+2' \
       using 1:(avg7($3)) t 'avghitrate' w linespoints,\
    sum=init(0),'' using 1:(avg7($4)) t 'avghitrate1' w linespoints, \
    sum=init(0),'' using 1:(avg7($5)) t 'avghitrate2' w linespoints, \
    sum=init(0),'' using 1:(avg7($6)) t 'avghitrate3' w linespoints, \
    sum=init(0),'' using 1:(avg7($7)) t 'avghitrate4' w linespoints, \
    sum=init(0),'' using 1:(avg7($8)) t 'avghitrate5' w linespoints, \
    sum=init(0),'' using 1:(avg7($9)) t 'avghitrate6' w linespoints, \
    sum=init(0),'' using 1:(avg7($10)) t 'avghitrate7' w linespoints

