package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.SanPhamDTO;

public interface DanhMucDAO {
    public int addSanPham(SanPhamDTO sanPhamDTO);

    public int updSanPham(SanPhamDTO sanPhamDTO);

}
