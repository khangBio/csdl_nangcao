package com.csdl.group_one.danhmuc;

import com.csdl.group_one.model.SanPhamDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.stereotype.Service;

@Service
public class SanPhamDAOImpl implements DanhMucDAO{
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public int addSanPham(SanPhamDTO sanPhamDTO) {
        String sql = " INSERT INTO dbo.DanhMucSanPham(maSanPham, tenSanPham, maLoaiSanPham, tenLoaiSanPham, donGia, xuatXu, ngaySanXuat, hinhAnhSanPham)\n" +
                "  VALUES(:maSanPham, :tenSanPham, :maLoaiSanPham, :tenLoaiSanPham, :donGia, :xuatXu, :ngaySanXuat, :hinhAnhSanPham)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("maSanPham", sanPhamDTO.getMaSanPham());
        parameterSource.addValue("tenSanPham", sanPhamDTO.getTenSanPham());
        parameterSource.addValue("maLoaiSanPham", sanPhamDTO.getMaLoaiSanPham());
        parameterSource.addValue("tenLoaiSanPham", sanPhamDTO.getTenLoaiSanPham());
        parameterSource.addValue("donGia", sanPhamDTO.getDonGia());
        parameterSource.addValue("xuatXu", sanPhamDTO.getXuatXu());
        parameterSource.addValue("ngaySanXuat", sanPhamDTO.getNgaySanXuat());
        parameterSource.addValue("hinhAnhSanPham", sanPhamDTO.getHinhAnhSanPham());
        try {
            return jdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }

    }

    @Override
    public int updSanPham(SanPhamDTO sanPhamDTO) {
        String sql = " UPDATE dbo.DanhMucSanPham        \n" +
                "       SET tenSanPham = :tenSanPham,   \n" +
                "           donGia = :donGia, \n" +
                "           xuatXu = :xuatXu, \n" +
                "           ngaySanXuat = :ngaySanXuat, \n" +
                "           hinhAnhSanPham  = :hinhAnhSanPham\n" +
                "     WHERE idSanPham = :idSanPham";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("tenSanPham", sanPhamDTO.getTenSanPham());
        parameterSource.addValue("donGia", sanPhamDTO.getDonGia());
        parameterSource.addValue("xuatXu", sanPhamDTO.getXuatXu());
        parameterSource.addValue("ngaySanXuat", sanPhamDTO.getNgaySanXuat());
        parameterSource.addValue("hinhAnhSanPham", sanPhamDTO.getHinhAnhSanPham());
        try {
            return jdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }

    }
}

