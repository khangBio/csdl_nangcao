<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/jquery/jquery.2.1.1.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/select2/4.07/select2.min.js"></script>
<!-- script type="text/javascript" src="style-dancu/vendor/select2/4.07/ScriptTest.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/style-dancu/js/custom.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/jquery/moment.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/footable-bootstrap/js/footable.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap-datepicker/js/bootstrap-datepicker.min.js"
        charset="utf-8"></script>
<script
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/bootstrap-datepicker/locales/bootstrap-datepicker.vi.min.js"
        charset="utf-8"></script>

<script
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/js/jquery.dataTables.min.js"></script>
<script
        src="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/js/dataTables.bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/style-dancu/vendor/datatable/js/datatables-init-vi.js"
        charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/module/jquery-qrcode/jquery.qrcode.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/module/select2/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/module/jquery-confirm/js/jquery-confirm.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/style-dancu/vendor/toastr/toastr.min.js"></script>
<script
        src="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script
        src="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/js/bootstrap-datepicker.vi.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/module/bootstrap-datepicker/js/jquery.mask.min.js"></script>
<!-- <script src="${pageContext.request.contextPath}/resources/module/swig/swig.js"></script> -->
<script src="${pageContext.request.contextPath}/resources/lib/lib.js?v=1"></script>
<script src="${pageContext.request.contextPath}/resources/custom-uiux/custom.js?v=1.1"></script>
<script src="${pageContext.request.contextPath}/resources/style-dancu/vendor/highchart/highcharts.js"></script>
<%--<script src="/notification/resources/notify.js?v=2"></script>--%>
<script type="text/javascript">
    var formThongTinKhachHang = $("#formThongTinKhachHang");
    $(function () {
        $("#btn-tao-hoa-don").hide();
        $("#formThongTinKhachHang").disableControlValue({
            soHoaDonKhachHang: true,
        });
        $("#ngayHoaDon").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngayHoaDon: e.format(0, "dd/mm/yyyy")
                });
            }
        );
        $("#btnNgayHoaDon").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngayHoaDon: e.format(0, "dd/mm/yyyy")
                });
            }
        );
        $("#srchToBirthday").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngaySinhKhachHang: e.format(0, "dd/mm/yyyy")
                });
            }
        );

        $("#ngaySinhKhachHang").datepicker({autoclose: true, todayHighlight: true}).on('changeDate', function (e) {
                $(document).pathValue({
                    ngaySinhKhachHang: e.format(0, "dd/mm/yyyy")
                });
            }
        );

        $("#sdtKhachHang").keydown(function (e) {
            if (e.keyCode == 13){
                $("#formThongTinKhachHang").resetValidation();
                var checkValid = $("#formThongTinKhachHang").validation({
                    required: {
                        sdtKhachHang: "Số điện thoại khách hàng không được trống!",
                    }
                });
                if (!checkValid.isValid) {
                    $("#formThongTinKhachHang").bindError(checkValid);
                    return;
                }else {
                    findOneKhachHang();
                    return;
                }
            }
        })
    });

    function themMoiKhachHang(action){
        $("#formThongTinKhachHang").resetValidation();
        var checkValid = $("#formThongTinKhachHang").validation({
            required: {
                hoTenKhachHang: "Họ tên khách hàng không được trống!",
                sdtKhachHang: "Số điện thoại khách hàng không được trống!",
                cccdKhachHang: "Định danh khách hàng không được trống!",
                ngaySinhKhachHang: "Ngày sinh khách hàng không được trống!"
            }
        });
        if (!checkValid.isValid) {
            $("#formThongTinKhachHang").bindError(checkValid);
            return;
        }
        $("#formThongTinKhachHang").formTextTrim();
        var jsonData = $("#formThongTinKhachHang").getValue();
        lib.post({
            url: $("#PageContext").val() + "/do-khach-hang",
            data: JSON.stringify({
                idKhachHang: $("#idKhachHang").val() ? $("#idKhachHang").val() : 0,
                maKhachHang: '',
                hoTen: jsonData.hoTenKhachHang,
                cccd: jsonData.cccdKhachHang,
                ngaySinh: jsonData.ngaySinhKhachHang,
                email: jsonData.emailKhachHang,
                soDienThoai: jsonData.sdtKhachHang,
                diaChi: jsonData.diaChiKhachHang
            }),
            beforePost:function(){
                $("#formThongTinKhachHang").uiLoading(true);
            },
            complete: function (response) {
                $("#formThongTinKhachHang").uiLoading(false);
                var res = response.responseJSON;
                if (res.errorCode < 0){
                    lib.showMessage('' + res.errorMessage, 'error', function () {
                            //
                        });
                }else {
                    lib.showMessage('' + res.errorMessage, 'success', function () {
                        $("#idKhachHang").val(res.errorCode);
                        $("#btn-tao-hoa-don").show();
                    });
                }
            },
            error: function (ex) {
                $("#formThongTinKhachHang").uiLoading(false);
            }
        });
    }

    function findOneKhachHang(){
        $("#formThongTinKhachHang").formTextTrim();
        var jsonData = $("#formThongTinKhachHang").getValue();
        lib.post({
            url: $("#PageContext").val() + "/find-info-khach-hang",
            data: JSON.stringify({
                idKhachHang: 0,
                hoTen: jsonData.hoTenKhachHang,
                cccd: jsonData.cccdKhachHang,
                ngaySinh: jsonData.ngaySinhKhachHang,
                soDienThoai: jsonData.sdtKhachHang,
            }),
            beforePost:function(){
                $("#formThongTinKhachHang").uiLoading(true);
            },
            complete: function (response) {
                $("#formThongTinKhachHang").uiLoading(false);
                var item = response.responseJSON.khachHang;
                let errorCode = response.responseJSON.errorCode
                if (errorCode > 0){
                    $("#idKhachHang").val(item.idKhachHang);
                    $("#formThongTinKhachHang").pathValue({
                        hoTenKhachHang: item.hoTen,
                        sdtKhachHang: item.soDienThoai,
                        cccdKhachHang: item.cccd,
                        ngaySinhKhachHang: item.ngaySinh,
                        emailKhachHang: item.email,
                        diaChiKhachHang: item.diaChi,
                    });
                    $("#btn-tao-hoa-don").show();
                }else {
                    lib.showMessage('Không tìm thấy thông tin khách hàng!',
                        'error', function () {
                            $("#idKhachHang").val(0);
                            $("#btn-tao-hoa-don").hide();
                        });
                }
            },
            error: function (ex) {
                $("#formThongTinKhachHang").uiLoading(false);
            }
        });
    }

    function themMoiDonHang(action){
        $("#formThongTinKhachHang").resetValidation();
        var checkValid = $("#formThongTinKhachHang").validation({
            required: {
                ngayHoaDon: "Ngày hóa đơn không được trống!",
                hoTenKhachHang: "Họ tên khách hàng không được trống!",
                sdtKhachHang: "Số điện thoại khách hàng không được trống!",
                cccdKhachHang: "Định danh khách hàng không được trống!",
                ngaySinhKhachHang: "Ngày sinh khách hàng không được trống!"
            }
        });
        if (!checkValid.isValid) {
            $("#formThongTinKhachHang").bindError(checkValid);
            return;
        }
        let idKhachHang = $("#idKhachHang").val() ? $("#idKhachHang").val() : 0;
        if (idKhachHang <= 0){
            lib.showMessage('Thông tin khách hàng chưa được ghi!', 'error', function () {});
            return;
        }
        $("#formThongTinKhachHang").formTextTrim();
        var jsonData = $("#formThongTinKhachHang").getValue();
        lib.post({
            url: $("#PageContext").val() + "/do-don-hang",
            data: JSON.stringify({
                idKhachHang: idKhachHang,
                maDonHang: $("#soHoaDonKhachHang").val() ? $("#soHoaDonKhachHang").val() : "",
                ngayHoaDon: jsonData.ngayHoaDon,
                hoTen: jsonData.hoTenKhachHang,
                cccd: jsonData.cccdKhachHang,
                ngaySinh: jsonData.ngaySinhKhachHang,
                email: jsonData.emailKhachHang,
                soDienThoai: jsonData.sdtKhachHang,
                diaChi: jsonData.diaChiKhachHang
            }),
            beforePost:function(){
                $("#formThongTinKhachHang").uiLoading(true);
            },
            complete: function (response) {
                $("#formThongTinKhachHang").uiLoading(false);
                var res = response.responseJSON;
                if (res.errorCode < 0){
                    lib.showMessage('' + res.errorMessage, 'error', function () {
                        //
                    });
                }else {
                    lib.showMessage('' + res.errorMessage, 'success', function () {
                        $("#soHoaDonKhachHang").val(res.maDonHang);
                    });
                }
            },
            error: function (ex) {
                $("#formThongTinKhachHang").uiLoading(false);
            }
        });
    }

    function openDialogKhachHang(){
        $("#form-add-thongtin-khachhang").shownDialog(
            {
                title: {
                    add: 'THÊM MỚI THÔNG TIN KHÁCH HÀNG',
                    edit: 'SỬA BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ',
                },
                action: action,
                onShown: function () {
                    $(formId).removeClass('mode-view');
                    $(formId).resetValidation();
                    jsonFormId = JSON.stringify($(formId).getValue());
                    if (action === 'xem') {
                        // $(formId).uiLoading();
                        actionDialog = action;
                        $("button[name='dialogSeachHouseHold']").prop("disabled", true);
                        $("button[name='btn-ghivathem']").hide();
                        $('button[name="btn-ghi"]').hide();
                        $("#btn-ketThucBienDong").hide();
                        $("#dongCapNhatVeSom").show();
                        $("#btn-khongtaobiendong").hide();
                        $("#btn-taobiendong").hide();
                        if (receiveStatus == KEY_DA_TAO_BIEN_DONG){
                            $("#reasonNotCreate").hide();
                        }else {
                            $("#reasonNotCreate").show();
                        }
                        $(formId).addClass('mode-view');
                        $('button[name="btn-close"]').show();
                        $(formId).disableAllControl(true);
                    } else if (action === 'capnhatngayve') {
                        if (lib.parsetoDate(itemName.movingToDate, "/") >= lib.parsetoDate(ngayHienTai, "/") || itemName.movingToDate.trim() == "") {
                            $("#btn-ketThucBienDong").show();
                        } else {
                            $("#btn-ketThucBienDong").hide();
                        }
                        $("button[name='dialogSeachHouseHold']").prop("disabled", true);
                        $("button[name='btn-ghivathem']").hide();
                        $('button[name="btn-ghi"]').hide();
                        $('button[name="btn-close"]').show();
                        $("#btn-khongtaobiendong").hide();
                        $("#btn-taobiendong").hide();
                        $(formId).addClass('mode-view');
                        $("#dongCapNhatVeSom").show();
                        $(formId).disableAllControl(true);
                    } else if (action === 'sua') {
                        $("#btn-ketThucBienDong").hide();
                        $("button[name='btn-ghivathem']").hide();
                        $("#dongCapNhatVeSom").hide();
                        $("button[name='btn-ghi']").show();
                        $('button[name="btn-close"]').show();
                        $("#btn-khongtaobiendong").hide();
                        $("#btn-taobiendong").hide();
                        $("#reasonNotCreate").hide();
                        $("button[name='dialogSeachHouseHold']").prop("disabled", true);
                        $(formId).disableAllControl(false);
                        $(formId).disableControlValue({
                            hhRegBookProfNumber: true,
                            dialogSeachHouseHold: true,
                            soSoHoKhau: true,
                            soHoSoCuTru: true,
                            hoTenChuHo: true,
                            soCMNDChuHo: true,
                            ngaySinhChuHo: true,
                            diaChiThuongTru: true
                        });
                    }else if (action === 'tiepnhan'){
                        $("#btn-ketThucBienDong").hide();
                        $("button[name='btn-ghivathem']").hide();
                        $("#dongCapNhatVeSom").hide();
                        $("button[name='btn-ghi']").hide();
                        $('button[name="btn-close"]').show();
                        $("#btn-khongtaobiendong").show();
                        $("#btn-taobiendong").show();
                        $("#reasonNotCreate").show();
                        $("button[name='dialogSeachHouseHold']").prop("disabled", true);
                        $(formId).disableAllControl(false);
                        $(formId).disableControlValue({
                            hhRegBookProfNumber: true,
                            dialogSeachHouseHold: true,
                            soSoHoKhau: true,
                            soHoSoCuTru: true,
                            hoTenChuHo: true,
                            soCMNDChuHo: true,
                            ngaySinhChuHo: true,
                            diaChiThuongTru: true
                        });
                    }else {//thêm
                        $("button[name='dialogSeachHouseHold']").prop("disabled", false);
                        $("#hhRegBookProfNumber").focus();
                        $("#btn-ketThucBienDong").hide();
                        $("button[name='btn-ghivathem']").show();
                        $("button[name='btn-ghi']").show();
                        $('button[name="btn-close"]').show();
                        $("#dongCapNhatVeSom").hide();
                        $("#btn-khongtaobiendong").hide();
                        $("#btn-taobiendong").hide();
                        $("#reasonNotCreate").hide();
                        $(formId).disableAllControl(true);
                        $(formId).disableAllControl(false);
                        $(formId).disableControlValue({
                            soSoHoKhau: true,
                            soHoSoCuTru: true,
                            hoTenChuHo: true,
                            soCMNDChuHo: true,
                            ngaySinhChuHo: true,
                            diaChiThuongTru: true,
                            movingDistrictId: true,
                            movingVillageId: true
                        });
                        $("#divMovingCountryId").hide();
                        $("#divMovingType").show();
                        $("#divMovingInCountry").show();
                        $("#divMovingAddress").show();
                    }
                }
            });
    }

    function huyThongTin(){
        $("#formThongTinKhachHang").pathValue({
                maDonHang: "",
                ngayHoaDon: "",
                hoTen: "",
                cccd: "",
                ngaySinh: "",
                email: "",
                soDienThoai: "",
                diaChi: ""
            }
        )
        $("#idKhachHang").val(0);
        $("#btn-tao-hoa-don").hide();
    }
</script>