# CalcToolbox

A small cross platform software for engineer calculation.


## Screenshot

![](demo.gif)  


Linux screenshot

![](screenshot-linux.png)  

## feature

- Multiple CRC calculations, with predefined patterns
  - CRC4
  - CRC5
  - CRC6
  - CRC7
  - CRC8
  - CRC16
  - CRC32
- Multiple base conversion
- Multiple types of numbers to byte buffer conversion
- Big Float calculation
- Big Integer calculation
- Constants display
- more

## Some 3rd modules

- CRC algorithm from  
  https://www.iteye.com/blog/kiolp-2262455

- Base convert function from  
  https://blog.csdn.net/tianqin20140902/article/details/44151717

- Big Float and Big Integer (DFFLib) from  
  http://www.delphiforfun.org.ws034.alentus.com/Programs/Library/bigfloat.htm


## Build

### windows

- Install Lazarus 2.0+ and FPC 3.0.4+
- Run Lazarus IDE, then open project **CalcToolBox.lpr**
- Build the project.

### Linux

- Install Lazarus 2.0+ and FPC 3.0.4+
- Run Lazarus IDE, then open project **CalcToolBox.lpr**
- open **project option** fro **project** menu
- Select **Linux** under *Target OS* in **Config and Target** option
- Select **LCLWidgetType** in **Additions and Overrides**
- Build

### Reduce file size

Default build file size is very large, to reduce file size, please open project option dialog, in **Debugging** tab, remove **Generate info for the debugger** and **Display line numbers in run-time error backtraces** option, then rebuild.



![](powered_by.png)
