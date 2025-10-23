package com.csdl.group_one.danhmuc;

import com.csdl.group_one.model.SanPhamDTO;

public interface DanhMucDAO {
    public int addSanPham(SanPhamDTO sanPhamDTO);

    public int updSanPham(SanPhamDTO sanPhamDTO);

}
