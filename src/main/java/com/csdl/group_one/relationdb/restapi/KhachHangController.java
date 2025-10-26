package com.csdl.group_one.relationdb.restapi;

import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.dto.KhachHangDTO;
import com.csdl.group_one.relationdb.service.DanhMucDAO;
import com.csdl.group_one.relationdb.service.KhachHangService;
import com.csdl.group_one.utils.EJson;
import com.csdl.group_one.utils.ResponseBodyJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
public class KhachHangController {
    @Autowired
    KhachHangService khachHangService;

    @Autowired
    public ResponseBodyJson responseBodyJson;

    @ResponseBody
    @PostMapping("/do-khach-hang")
    public String doKhachHang(@RequestBody KhachHangDTO khachHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        int result = 0;
        String message = "";
        int idKhachHang = khachHangDTO.getIdKhachHang();
        if (idKhachHang > 0){
            result = khachHangService.updKhachHang(khachHangDTO);
            message = result > 0 ? "Cập nhật thành công!" : "Cập nhật thất bại!";
        }else {
            KhachHangDTO khachHang = khachHangService.findOneKhachHang(khachHangDTO.getSoDienThoai(), khachHangDTO.getCccd(), khachHangDTO.getNgaySinh());
            if (khachHang.getIdKhachHang() > 0){
                responseJson.put("errorCode", -1);
                responseJson.put("errorMessage", "Thông tin khách hàng này đã tồn tại với tên: " + khachHang.getHoTen());
                return responseJson.success();
            }
            result = khachHangService.addKhachHang(khachHangDTO);
            message = result > 0 ? "Thêm thành công!" : "Thêm thất bại!";
        }
        responseJson.put("errorCode", result);
        responseJson.put("errorMessage", message);
        return responseJson.success();
    }

    @ResponseBody
    @PostMapping("/find-info-khach-hang")
    public String findThongTinKhachHang(@RequestBody KhachHangDTO khachHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        int result = 0;
        String message = "";
        KhachHangDTO khachHang = khachHangService.findOneKhachHang(khachHangDTO.getSoDienThoai(), khachHangDTO.getCccd(), khachHangDTO.getNgaySinh());
        responseJson.put("khachHang", khachHang);
        responseJson.put("errorCode", khachHang.getIdKhachHang());
        return responseJson.success();
    }

    @ResponseBody
    @PostMapping("/do-don-hang")
    public String doKhachHang(@RequestBody DonHangDTO donHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        long result = 0;
        String message = "";
        String maDonHang = donHangDTO.getMaDonHang();
        if (!maDonHang.equals("")){
            result = khachHangService.updDonHang(donHangDTO);
            message = result > 0 ? "Cập nhật thành công!" : "Cập nhật thất bại!";
        }else {
            result = khachHangService.createDonHang(donHangDTO);
            message = result > 0 ? "Thêm thành công!" : "Thêm nhật thất bại!";
        }
        responseJson.put("maDonHang", result);
        responseJson.put("errorCode", result);
        responseJson.put("errorMessage", message);
        return responseJson.success();
    }
}
