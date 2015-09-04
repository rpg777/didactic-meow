#Exporting STADIC utilities

####Rob Guglielmetti - September 4, 2015

This HOWTO illustrates the steps for using [Jason DeGraw](https://github.com/jasondegraw)'s [export script](https://github.com/Architectural-Lighting-Simulation/STADIC/blob/export-script/export.py) to take a [STADIC](https://github.com/Architectural-Lighting-Simulation/STADIC) utility and export it for inclusion in Radiance source, as well as building and testing. The DXGridmaker utility is used as an example here, **and is what the export script exports at the present time (September, 4 2015)**.

##Export

**Got STADIC?**
```
$ mkdir stadic
$ cd stadic
$ git clone https://github.com/Architectural-Lighting-Simulation/STADIC.git .
```

**Run the export script**
```
$ python ./export.py --boost-prefix src/stadic/
```

The script will export the DXGridmaker code and a minimal export of the required Boost libraries to a top-level dir called "stadic-export". This directory and its contents are ready to be folded in with the ```src``` directory of the Radiance repo. ASSuming your **Radiance** and **STADIC** repos are at the same level, then **from the ```stadic``` directory** (where you just ran the export script from), issue:
```
$ cp -R ../stadic-export/ ../radiance/src/stadic
```

**Go to your Radiance build directory, configure CMake, and build Radiance**
```
$ cd ../radiance/src/
$ cd [your_build_dir]
$ ccmake .
$ make
```

##Test
Let's use a simple input file called ```simple_floor.rad``` for testing:
```
$ [path_to]/dxgridmaker -f simple_floor.rad [options] > test.pts
```

DXgridmaker includes diagnostic plotting options (see ```-v*``` options).

The following Rscript snippet will make a simple 2D spatial plot of the x,y output:
```
> points <- read.csv(file = "./test.pts", sep = " ", header = FALSE )
> points <- points[c(1,2)]
> plot(points, xlim = c(0,50), ylim = c(-10,40))
```


**A simple input file called simple_floor.rad:**

```
# simple_floor.rad
material polygon simple
0
0 
12
0 0 0
20 0 0
20 20 0
0 20 0

material polygon degenerate
0
0
39
20 0 0
20 -10 0
35 5 0
45 5 0
45 20 0
28 20 0
28 30 0
45 30 0
45 40 0
10 40 0
10 30 0
20 30 0
20 0 0
```



