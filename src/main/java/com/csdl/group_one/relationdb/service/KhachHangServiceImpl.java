package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.dto.KhachHangDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class KhachHangServiceImpl implements KhachHangService{
    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Override
    public int addKhachHang(KhachHangDTO khachHangDTO){
        String sql = " INSERT INTO dbo.KhachHang(maKhachHang, hoTen, cccd, ngaySinh, email, soDienThoai, diaChi, hinhAnhKhachHang)\n" +
                "VALUES(:maKhachHang, :hoTen, :cccd, :ngaySinh, :email, :soDienThoai, :diaChi, :hinhAnhKhachHang)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("maKhachHang", khachHangDTO.getSoDienThoai());
        parameterSource.addValue("hoTen", khachHangDTO.getHoTen());
        parameterSource.addValue("cccd", khachHangDTO.getCccd());
        parameterSource.addValue("ngaySinh", khachHangDTO.getNgaySinh());
        parameterSource.addValue("email", khachHangDTO.getEmail());
        parameterSource.addValue("soDienThoai", khachHangDTO.getSoDienThoai());
        parameterSource.addValue("diaChi", khachHangDTO.getDiaChi());
        parameterSource.addValue("hinhAnhKhachHang", khachHangDTO.getHinhAnhKhachHang());
        try {
            int result = namedParameterJdbcTemplate.update(sql, parameterSource);
            if (result > 0){
               KhachHangDTO khachHang = findOneKhachHang(khachHangDTO.getSoDienThoai(), khachHangDTO.getCccd(), "");
               return khachHang.getIdKhachHang();
            }
            return -1;
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public int updKhachHang(KhachHangDTO khachHangDTO){
        String sql = " UPDATE dbo.KhachHang                 \n" +
                "         SET hoTen = :hoTen,               \n" +
                "             cccd = :cccd,                 \n" +
                "             ngaySinh = :ngaySinh,         \n" +
                "             email = :email,               \n" +
                "             soDienThoai = :soDienThoai,   \n" +
                "             diaChi = :diaChi              \n" +
                "       WHERE idKhachHang = :idKhachHang";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("hoTen", khachHangDTO.getHoTen());
        parameterSource.addValue("cccd", khachHangDTO.getCccd());
        parameterSource.addValue("ngaySinh", khachHangDTO.getNgaySinh());
        parameterSource.addValue("email", khachHangDTO.getEmail());
        parameterSource.addValue("soDienThoai", khachHangDTO.getSoDienThoai());
        parameterSource.addValue("diaChi", khachHangDTO.getDiaChi());
        parameterSource.addValue("idKhachHang", khachHangDTO.getIdKhachHang());
        try {
            return namedParameterJdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public KhachHangDTO findOneKhachHang(String soDienThoai, String cccd, String ngaySinh) {
        KhachHangDTO khachHangDTO = new KhachHangDTO();
        String sql = " SELECT TOP(1) idKhachHang        \n" +
                "      ,maKhachHang                     \n" +
                "      ,hoTen                           \n" +
                "      ,cccd                            \n" +
                "      ,ngaySinh                        \n" +
                "      ,email                           \n" +
                "      ,soDienThoai                     \n" +
                "      ,diaChi                          \n" +
                "      ,hinhAnhKhachHang                \n" +
                "  FROM dbo.KhachHang                   \n" +
                "  where 1 = 1                          \n";
        String sqlWhere = "";
        if (!soDienThoai.equals("")){
            sqlWhere = sqlWhere + " and soDienThoai = :soDienThoai";
        }
        if (!cccd.equals("")){
            sqlWhere = sqlWhere + " and cccd = :cccd";
        }

        if (!ngaySinh.equals("")){
            sqlWhere = sqlWhere + " and ngaySinh = :ngaySinh";
        }
        sql = sql + sqlWhere;
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("cccd", cccd);
        parameterSource.addValue("ngaySinh", ngaySinh);
        parameterSource.addValue("soDienThoai", soDienThoai);
        try {
            Map mapResult =  namedParameterJdbcTemplate.queryForMap(sql, parameterSource);
            if (!mapResult.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                khachHangDTO = mapper.readValue(mapper.writeValueAsString(mapResult), KhachHangDTO.class);
            }
            return khachHangDTO;
        }catch (Exception e){
            return khachHangDTO;
        }
    }

    @Override
    public long createDonHang(DonHangDTO donHangDTO) {
        Long maDonHang = System.currentTimeMillis();
        String sql = "INSERT INTO dbo.DonHang(maDonHang, ngayHoaDon, tongTien, trangThai, idKhachHang)\n" +
                "VALUES (:maDonHang, :ngayHoaDon, :tongTien, :trangThai, :idKhachHang)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("maDonHang", maDonHang.longValue());
        parameterSource.addValue("ngayHoaDon", donHangDTO.getNgayHoaDon());
        parameterSource.addValue("tongTien", donHangDTO.getTongTien());
        parameterSource.addValue("trangThai", donHangDTO.getTrangThai());
        parameterSource.addValue("idKhachHang", donHangDTO.getIdKhachHang());
        try {
            int result = namedParameterJdbcTemplate.update(sql, parameterSource);
            return result > 0 ? maDonHang.longValue() : -1;
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public int updDonHang(DonHangDTO donHangDTO) {
        String sql = "UPDATE dbo.DonHang                \n" +
                "        SET ngayHoaDon = :ngayHoaDon,  \n" +
                "            tongTien = :tongTien,      \n" +
                "            trangThai = :trangThai     \n" +
                "      WHERE maDonHang = :maDonHang";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("ngayHoaDon", donHangDTO.getNgayHoaDon());
        parameterSource.addValue("tongTien", donHangDTO.getTongTien());
        parameterSource.addValue("trangThai", donHangDTO.getTrangThai());
        parameterSource.addValue("maDonHang", donHangDTO.getMaDonHang());
        try {
            return namedParameterJdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }
    }
}
