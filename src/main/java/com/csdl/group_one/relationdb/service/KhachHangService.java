package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.dto.KhachHangDTO;

public interface KhachHangService {
    public int addKhachHang(KhachHangDTO khachHangDTO);

    public int updKhachHang(KhachHangDTO khachHangDTO);

    public KhachHangDTO findOneKhachHang(String soDienThoai, String cccd, String ngaySinh);

    public long createDonHang(DonHangDTO donHangDTO);

    public int updDonHang(DonHangDTO donHangDTO);
}
