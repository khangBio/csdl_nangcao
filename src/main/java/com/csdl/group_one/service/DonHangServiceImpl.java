package com.csdl.group_one.service;

import com.csdl.group_one.model.*;
import com.csdl.group_one.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DonHangServiceImpl implements DonHangService {

    private final DonHangRepository donHangRepository;
    private final ChiTietDonHangRepository chiTietRepository;
    private final DonHangMongoRepository donHangMongoRepository;

    @Override
    public DonHang taoDonHang(DonHang donHang) {
        // Lưu SQL
        DonHang saved = donHangRepository.save(donHang);

        // Chuyển sang Mongo
        DonHangMongo mongo = new DonHangMongo();
        mongo.setMaDonHang(saved.getMaDonHang());
        mongo.setNgayDat(saved.getNgayDat());
        mongo.setTongTien(saved.getTongTien());
        mongo.setTrangThai(saved.getTrangThai());
        mongo.setKhachHang(saved.getKhachHang().getHoTen());

        mongo.setChiTietDonHang(
                chiTietRepository.findAll().stream()
                        .filter(ct -> ct.getDonHang().getIdDonHang().equals(saved.getIdDonHang()))
                        .map(ct -> {
                            DonHangMongo.ChiTiet item = new DonHangMongo.ChiTiet();
                            item.setTenSanPham(ct.getSanPham().getTenSanPham());
                            item.setSoLuong(ct.getSoLuong());
                            item.setDonGia(ct.getDonGia());
                            return item;
                        }).collect(Collectors.toList())
        );

        donHangMongoRepository.save(mongo);
        return saved;
    }
}
