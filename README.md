# kvxrandr

`kvxrandr`是一款允许用户添加所需要的分辨率的屏幕管理器。目前`kvxrandr`只支持外接一块屏幕或一个投影仪。

如果您在使用`lxrandr`的时候，即使是调整到最好的投影效果，也会出现类似的画面截断情况，或者画面过小的情况。大多数情况是因为由于硬件或驱动的原因，`xrandr` 不能检测出您的显示器所有的有效分辨率^[https://wiki.archlinux.org/title/Xrandr_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)]。这种情况下您可以选择使用`kvxrandr`。
（图片不是很清晰:sweat:）

- `lxrandr`显示
<table><tr>
<td><img src="Figures/lxrandr_0.jpg" border=0></td>
<td><img src="Figures/lxrandr_1.jpg" border=0></td>
</tr></table>

- `kvxrandr`显示
<table> <center>
<img src="Figures/kvxrandr.jpg" border=1, width=60%, height=60%>
</center> </table>

如果您不喜欢GUI操作，可以参考ArchWiki中的[Xrandr 添加未检测到的分辨率](https://wiki.archlinux.org/title/Xrandr_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E6%B7%BB%E5%8A%A0%E6%9C%AA%E6%A3%80%E6%B5%8B%E5%88%B0%E7%9A%84%E5%88%86%E8%BE%A8%E7%8E%87)。

# 安装
```bash
git clone https://github.com/demonlord1997/kvxrandr
sudo make install
```
`kvxrandr`将会安装在`/usr/local/bin`目录下。

# 卸载
```bash
sudo make uninstall
```

# TODO
- [ ] 添加窗口缩放功能
- [ ] 支持多块外接屏幕
