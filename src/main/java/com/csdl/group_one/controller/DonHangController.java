package com.csdl.group_one.controller;

import com.csdl.group_one.model.DonHang;
import com.csdl.group_one.service.DonHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/donhang")
@RequiredArgsConstructor
public class DonHangController {

    private final DonHangService donHangService;

    @PostMapping("/them-don-hang")
    public String taoDonHang(@RequestBody DonHang donHang) {
        donHangService.taoDonHang(donHang);
        return "Đơn hàng đã được lưu vào SQL Server và MongoDB!";
    }
}
