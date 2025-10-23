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
    var KEY_CHU_HO = 2; /*chủ hộ*/
    var KEY_CHO_TAO_BIEN_DONG = 1; /*chờ tạo biến động*/
    var KEY_KHONG_TAO_BIEN_DONG = 2; /*không tạo biến động*/
    var KEY_DA_TAO_BIEN_DONG = 3; /*đã tạo biến động hộ Hoặc muốn tạo trực triếp*/
    var KEY_CHECK_HK15 = 1; /*check báo cáo hk15*/
    var KEY_EXIT_HK15 = 101; /*Bỏ check HK15*/
    var seachValue = {};
    var quickSearchId = '#form_quick_search';
    var advSearchId = '#adv-search-content';
    var formId = '#form_asHouseHold';
    var fromThongTinHoNhanKhau = '#from_thongTinHoNhanKhau';
    var formThongTinBienDong = '#form_thongTinBienDong';
    var formtraCuuHoCuTru = '#form_traCuuHoCuTru';
    var formtraCuuHoCuTruNangCao = '#adv-search-dialog';
    var formKetThucBienDong = '#form_ketThucBienDongHo';
    var formXoaBienDong = '#form_xoaBienDongHo';
    var url = '/biendongdancu/docHouseHold';
    var urlKetThucBienDong = "/biendongdancu/ketThucBienDong";
    var urlXoaBienDongHo = "/biendongdancu/xoaBienDongHo";
    var urlTraCuuHoCuTru = '/biendongdancu/dimLstHouseHold';
    var urlTraCuuHoBienDong = '/biendongdancu/searchHouseHold';
    var urlTiepNhanHangLoat = '/biendongdancu/receiveAllHouseHold';
    var isFormThongTinHoNhanKhau = true;
    var isFormThongTinNoiDen = true;
    var isFormTraCuuHoCuTru = true;
    var permanentCityId = "0";
    // var rowId = $('#rowId');
    var objRowSel = {};
    var listArrayRowSel = [];
    var ngayHienTai = "${ngayHienTai}";
    var userCityId = "${regPlaceCityId}";
    var userDistrictId = "${regPlaceDistrictId}";
    var userVillageId = "${regPlaceVillageId}";
    var sizeListBienDongHo = "${lstPojoAsDicHousHoldNotInGeographic_count}";
    var actions = '';
    var actionSearch = '';
    var actionDialog = '';
    var houseHoldResId = '';
    var finalHHRegBookProfNumber = '';
    var jsonFormId = '';

    function formDialogCrud(action, id, isConfirm, itemName, receiveStatus, HK15) {
        var jsonData = {};
        jsonData["id"] = id;
        jsonData["action"] = lib.getAction(action);
        jsonData["receiveStatus"] = receiveStatus;
        jsonData["RPT_HK15"] = HK15;
        $('#PageId').val(id);

        if (jsonData["action"] === 'ghi' || jsonData["action"] === 'ghivathem') {
            $(formId).resetValidation();
            //push from data to jsonData
            //var soHoSoHoKhau = $("#houseHoldResId").val();
            var formData = $(formId).getValue();
            jsonData = lib.mergeValue(formData, jsonData);
            jsonData.houseHoldFamiResIdResId = houseHoldResId;
            jsonData.finalHHRegBookProfNumber = finalHHRegBookProfNumber;
            jsonData.userCityId = userCityId;
            jsonData.userDistrictId = userDistrictId;
            jsonData.userVillageId = userVillageId;
            jsonData.sourceData = sourceData;
            jsonData.permanentCityId = $("#permanentCityId").val() == "" ? 0 : $("#permanentCityId").val();
            jsonData.permanentDistrictId = $("#permanentDistrictId").val() == "" ? 0 : $("#permanentDistrictId").val();
            jsonData.permanentVillageId = $("#permanentVillageId").val() == "" ? 0 : $("#permanentVillageId").val();
            jsonData.permanentAddress = $("#permanentAddress").val();
            //check vaidate
            var result = formValidation(formData);
            if (!result.isValid) {
                $(formId).bindError(result);
                // $(formId).preventDefault();
                return;
            }
        } else if (jsonData["action"] === 'xoa' && !isConfirm) {
            // show modal list
            if (listArrayRowSel.length == 0) {
                let rowDelete = $(document).find('td[ref="row-in-danhSachHoBienDong"]').find('input[householdId=' +id +']');
                let movingFromDate = rowDelete.attr("movingfromdate");
                let movingToDate = rowDelete.attr("movingtodate");
                xoaBienDongHo(action, id, itemName, movingFromDate, movingToDate, KEY_CHECK_HK15);
            } else {
                xoaBienDongHo(action, id, itemName, listArrayRowSel[0].movingFromDate, listArrayRowSel[0].movingToDate, KEY_CHECK_HK15);
            }
            return;
        }

        //call server with action (doc/ghi/xoa)
        if (jsonData["action"] != "xacNhan") {
            lib.post({
                url: $("#PageContext").val() + url,
                data: JSON.stringify(jsonData),
                beforePost: function () {
                    $(formId).uiLoading(true);
                    if (jsonData["action"] === 'doc') {
                        $("#tamvang").empty();
                        $("#tamtru").empty();
                        $("#thongTinNhanKhau").empty();
                        $('#thongTinNhanKhau-paging').empty();
                        openDialog();
                    }
                },
                complete: function (response) {
                    resultSucess(response);
                    $(formId).uiLoading(false);
                },
                error: function (ex) {
                    $(formId).bindError(ex);
                    $(formId).uiLoading(false);

                    if (ex.responseJSON.responseJson != undefined && parseInt(ex.responseJSON.HK15) > 0){
                        lib.confirm('' + ex.responseJSON.responseMessage + '',
                            function (rs) {
                                if (!rs) {
                                    return;
                                }
                                var id = $('#PageId').val();
                                var responseJson = ex.responseJSON.responseJson.json;
                                formDialogCrud(responseJson.action, responseJson.id,responseJson.action == 'xoa' ? true : false, '', responseJson.receiveStatus, KEY_EXIT_HK15);
                            });
                        return;
                    }
                }
            });
        }

        function formValidation(param) {
            var jsonRequired = {
                hhRegBookProfNumber: "Số hồ sơ cư trú không được để trống",
                hoTenChuHo: "Họ tên chủ hộ không được để trống",
                //soCMNDChuHo: "Số CMND/CCCD/ĐDCN chủ hộ không được để trống", #vì có trường hợp công dân không có CMND/CCCD/ĐDCN
                ngaySinhChuHo: "Ngày sinh chủ hộ không được để trống",
                diaChiThuongTru: "Địa chỉ thường trú không được để trống",
                movingFromDate: "Ngày đi không được trống",
                movingStatus: "Trạng thái biến động được để trống"
            };
            var jsonRequiredType = {};
            if (parseInt(param.destionalType) == 1) {//Trong nước
                jsonRequiredType = {
                    placeToMovingType: "Loại di chuyển không được để trống",
                    movingCityId: "Tỉnh/thành không được để trống"
                }
            } else if (parseInt(param.destionalType) == 2) {//nước ngoài
                jsonRequiredType = {
                    movingCountryId: "Quốc gia không được để trống"
                }
            } else { //không rõ nơi cư trú
                jsonRequiredType = {
                    // movingCountryId: "Quốc gia không được để trống",
                }
            }

            if (parseInt(param.movingStatus) == 1 && param.movingToDate.trim() === '') {
                jsonRequiredType.movingToDate = "Đến ngày không được trống";
            }

            if (receiveStatus == KEY_KHONG_TAO_BIEN_DONG){
                jsonRequiredType.resonNotCreateHouseHold = "Lý do không tạo biến động không được trống";
            }

            jsonRequired = lib.mergeValue(jsonRequired, jsonRequiredType);

            var result = $(formId).validation({
                required: jsonRequired,
                maxlength: {
                    houseHoldResId: {
                        value: 50,
                        message: 'Mã sổ hộ khẩu không được quá 50 ký tự'
                    }
                },
                checkFullDate: {
                    movingFromDate: 'Từ ngày không đúng định dạng',
                    movingToDate: 'Đến ngày không đúng định dạng'

                }

            });

            return result;
        }

        function openDialog() {
            $(formId).shownDialog(
                {
                    title: {
                        view: 'XEM BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ',
                        add: 'THÊM MỚI BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ',
                        edit: 'SỬA BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ',
                        capnhatngayve: 'CẬP NHẬT VỀ SỚM BIẾN ĐỘNG HỘ KHÔNG CƯ TRÚ TẠI NƠI ĐĂNG KÝ THƯỜNG TRÚ',

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

        function resultSucess(response) {
            var res = JSON.parse(response.responseText);
            var id = jsonData["id"] != null ? jsonData["id"] : "0";
            var actionActive = '';
            if (jsonData["action"] == "ghi" && id != "0" && receiveStatus != KEY_CHO_TAO_BIEN_DONG) {
                actionActive = 'sua';
            } else if ((jsonData["action"] == "ghi" || jsonData["action"] == "ghivathem") && id == "0" || jsonData["action"] == "ghi" && receiveStatus === KEY_CHO_TAO_BIEN_DONG) {
                actionActive = 'them';
            } else {
                actionActive = jsonData["action"];
            }
            switch (actionActive) {
                case 'doc':
                    viewData();
                    break;
                case 'them':
                    addData(jsonData["action"]);
                    break;
                case 'sua':
                    updateData();
                    break;
                case 'xoa':
                    deleteData();
                    break;
            }

            //open dialog add,view,edit
            function viewData() {
                // $(formId).resetValidation();
                //set value to form
                $("#thongTinNhanKhau").empty();
                var data = [];
                if (res.houseHoldResId != "") {//sửa|xem
                    actions = jsonData["action"];
                    finalHHRegBookProfNumber = res.hhRegBookProfNumber;
                    //set value form
                    houseHoldResId = res.houseHoldResId;
                    data = res.listCitizenInHouseHold;
                    //dataNextPage();
                    $(formId).pathValue({
                        hhRegBookProfNumber: res.hhRegBookProfNumber, /*thay bằng số hồ sơ hộ khẩu. Do chuyển combobox sang text input*/
                        soSoHoKhau: res.soSoHoKhau,
                        hoTenChuHo: res.hoTenChuHo,
                        soCMNDChuHo: res.soCMNDChuHo,
                        ngaySinhChuHo: res.ngaySinhChuHo,
                        diaChiThuongTru: res.diaChiThuongTru,
                        destionalType: res.destionalType,
                        placeToMovingType: res.placeToMovingType,
                        movingCountryId: res.movingCountryId,
                        movingAddress: res.specificalAddress, /*địa chỉ cụ thể nơi đến*/
                        reason: res.reason,
                        resonNotCreateHouseHold: res.resonNotCreateHouseHold,
                        movingFromDate: res.movingFromDate,
                        movingToDate: res.movingToDate,
                        movingStatus: res.movingStatus
                    });
                    $.each(data, function (i) {
                        $('<tr><td class="stt">' + data[i].rowNumber + '</td>' +
                            '<td class="fit col-ho-ten">' + data[i].fullName + '</td>' +
                            '<td class="fit text-center">' + data[i].houseHoldBirthday + '</td>' +
                            '<td class="fit">' + data[i].genderName + '</td>' +
                            '<td class="fit text-right">' + data[i].identifyNumber + '</td>' +
                            '<td class="fit">' + data[i].relationshipName + '</td>' +
                            '<td class="fit text-center">' + data[i].notfoundDate + '</td>' +
                            '</tr>').appendTo("#thongTinNhanKhau");
                    });

                    $("#permanentCityId").val(res.permanentCityId);
                    $("#permanentDistrictId").val(res.permanentDistrictId);
                    $("#permanentVillageId").val(res.permanentVillageId);
                    $("#permanentAddress").val(res.diaChiThuongTru);
                    //ẩn hiện các control
                    if (res.destionalType == 1) {
                        $("#divMovingCountryId").hide();
                        $("#divMovingType").show();
                        $("#divMovingInCountry").show();
                        $("#divMovingAddress").show();
                        setTimeout(function () {
                            processInfoMovingType(res.placeToMovingType, res.movingCityId, res.movingDistrictId, res.movingVillageId, action);
                        }, 350);
                    } else if (res.destionalType == 2) {
                        $(formId).pathValue({
                            movingCityId: null,
                            movingDistrictId: null,
                            movingVillageId: null
                        });
                        $(formId).disableControlValue({
                            movingCityId: false,
                            movingDistrictId: true,
                            movingVillageId: true
                        });
                        $("#divMovingCountryId").show();
                        $("#divMovingType").hide();
                        $("#divMovingInCountry").hide();
                        $("#divMovingAddress").show();
                    } else {
                        $(formId).pathValue({
                            movingCityId: null,
                            movingDistrictId: null,
                            movingVillageId: null
                        });
                        $(formId).disableControlValue({
                            movingCityId: false,
                            movingDistrictId: true,
                            movingVillageId: true
                        });
                        $("#divMovingCountryId").hide();
                        $("#divMovingType").hide();
                        $("#divMovingInCountry").hide();
                        $("#divMovingAddress").hide();
                    }
                } else {//thêm
                    $(formId).pathValue(res);
                    $(formId).uiLoading(false);
                }
            }

            function addData(action) {
                var responData = response.responseJSON;
                if (parseInt(responData.listCitizenNotInGeographicID.length) > 0) {
                    if (action === 'ghi') {
                        lib.showMessage('Tạo biến động hộ thành công. Biến động nhân khẩu của thành viên trong hộ đã được tạo tự động',
                            'success', function () {
                                $(formId).hideDialog();
                                traCuuDanhSachHoBienDong('traCuuBienDong');
                            });
                    } else {
                        lib.showMessage('Tạo biến động hộ thành công. Biến động nhân khẩu của thành viên trong hộ đã được tạo tự động',
                            'success', function () {
                                $("#hhRegBookProfNumber").focus();
                                $("#tamvang").empty();
                                $("#tamtru").empty();
                                $("#thongTinNhanKhau").empty();
                                $(formId).pathValue({
                                    // houseHoldResId: null,
                                    placeToMovingType: '',
                                    movingCountryId: null,
                                    movingCityId: null,
                                    movingDistrictId: null,
                                    movingVillageId: null,
                                    movingStatus: ''
                                });
                                $(formId).clearControlValue({
                                    hhRegBookProfNumber: '',
                                    hoTenChuHo: '',
                                    soCMNDChuHo: '',
                                    ngaySinhChuHo: '',
                                    diaChiThuongTru: '',
                                    movingAddress: '',
                                    reason: '',
                                    movingFromDate: '',
                                    movingToDate: ''
                                });
                                $(formId).disableControlValue({
                                    movingCityId: false,
                                    movingDistrictId: true,
                                    movingVillageId: true
                                });
                                $("#destionalType1").prop('checked', true);
                                $("#divMovingCountryId").hide();
                                $("#divMovingType").show();
                                $("#divMovingInCountry").show();
                                $("#divMovingAddress").show();
                                traCuuDanhSachHoBienDong('traCuuBienDong')
                            });
                    }
                } else if (parseInt(responData.houseHoldNotInGeographicID) > 0) {
                    if (action === 'ghi') {
                        lib.showMessage('Tạo biến động hộ thành công',
                            'success', function () {
                                $(formId).hideDialog();
                                traCuuDanhSachHoBienDong('traCuuBienDong');
                            });
                    } else {
                        lib.showMessage('Tạo biến động hộ thành công',
                            'success', function () {
                                $("#hhRegBookProfNumber").focus();
                                $("#tamvang").empty();
                                $("#tamtru").empty();
                                $("#thongTinNhanKhau").empty();
                                $(formId).pathValue({
                                    // houseHoldResId: null,
                                    placeToMovingType: '',
                                    movingCountryId: null,
                                    movingCityId: null,
                                    movingDistrictId: null,
                                    movingVillageId: null,
                                    movingStatus: ''
                                });
                                $(formId).clearControlValue({
                                    hhRegBookProfNumber: '',
                                    soSoHoKhau: '',
                                    hoTenChuHo: '',
                                    soCMNDChuHo: '',
                                    ngaySinhChuHo: '',
                                    diaChiThuongTru: '',
                                    movingAddress: '',
                                    reason: '',
                                    movingFromDate: '',
                                    movingToDate: ''
                                });
                                $(formId).disableControlValue({
                                    movingCityId: false,
                                    movingDistrictId: true,
                                    movingVillageId: true
                                });
                                $("#destionalType1").prop('checked', true);
                                $("#divMovingCountryId").hide();
                                $("#divMovingType").show();
                                $("#divMovingInCountry").show();
                                $("#divMovingAddress").show();
                                traCuuDanhSachHoBienDong('traCuuBienDong');
                            });
                    }
                }
            }

            //submit action,edit
            function updateData() {
                var message = '';
                if (jsonData["receiveStatus"] == KEY_DA_TAO_BIEN_DONG){
                    message = 'Đã cập nhật biến động hộ không cư trú tại nơi đăng ký thường trú thành công!'
                }else {
                    message = 'Đã cập nhật không tạo biến động thành công!'
                }
                lib.showMessage('' + message + '',
                    'success', function () {
                        $(formId).hideDialog();
                        lib.reload();
                    });
            }

            //submit action delete
            function deleteData() {
                lib.showMessage('Xóa biến động hộ thành công!',
                    'success', function () {
                        location.reload();
                    });
            }
        }
    }

    function capNhatVeSom(action, id, movingFromDate, movingToDateEnd, HK15) {
        var jsonData = {};
        jsonData["id"] = id;
        jsonData["action"] = lib.getAction(action);
        if (action === 'xacNhan') {
            var listCitizenNotInGeographic = [];
            listCitizenNotInGeographic = $(document).getSelectRowMore("row-in-nhanKhauTrongHoBienDong");
            listCitizenNotInGeographic = listCitizenNotInGeographic.join('```');
            var movingStatus = lib.parsetoDate(movingToDateEnd, "/") <= lib.parsetoDate(ngayHienTai, "/") ? 1 : 2;
            jsonData.RPT_HK15 = HK15;
            jsonData.movingFromDate = movingFromDate;
            jsonData.movingToDateEnd = movingToDateEnd;
            jsonData.movingStatus = movingStatus;
            jsonData.citizenNotInGeographic = listCitizenNotInGeographic;
        }else {
            openDialogEndDate();
        }
        lib.post({
            url: $("#PageContext").val() + urlKetThucBienDong,
            data: JSON.stringify(jsonData),
            beforePost: function () {
                $(formKetThucBienDong).uiLoading(true);
                if (action === 'doc') {
                    $('#nhanKhauTrongHoBienDong').empty();
                    $('<tr ng-show="isLoading" class="row-select">' +
                        '<td class="fit text-center" colspan="6">Đang tải dữ liệu...</td>' +
                        '</tr>').appendTo("#nhanKhauTrongHoBienDong");
                }
            },
            complete: function (response) {
                if (jsonData["action"] === 'doc'){
                    renderTableNhanKhauBienDong(response.responseJSON);
                    $(formKetThucBienDong).uiLoading(false);
                }else {
                    updDateEndHouseHold(response.responseJSON);
                    if (parseInt(movingStatus) == 1) {
                        $("#btn-ketThucBienDong").hide();
                    } else {
                        $("#btn-ketThucBienDong").show();
                    }
                    $(formKetThucBienDong).uiLoading(false);
                    traCuuDanhSachHoBienDong('loadDanhSach');
                }
            },
            error: function (ex) {
                $(formKetThucBienDong).bindError(ex);
                $(formKetThucBienDong).uiLoading(false);
                if (ex.responseJSON.responseJson != undefined && parseInt(ex.responseJSON.HK15) > 0){
                    lib.confirm('' + ex.responseJSON.responseMessage + '',
                        function (rs) {
                            if (!rs) {
                                return;
                            }
                            var responseJson = ex.responseJSON.responseJson.json;
                            capNhatVeSom(responseJson.action, responseJson.id, responseJson.movingFromDate, responseJson.movingToDateEnd, KEY_EXIT_HK15);
                        });
                    return;
                }
            }
        });

        function openDialogEndDate() {
            $(formKetThucBienDong).shownDialog({
                title: 'CẬP NHẬT VỀ SỚM BIẾN ĐỘNG CỦA HỘ',
                action: action,
                onShown: function () {
                    $(formKetThucBienDong).resetValidation();
                    $(formKetThucBienDong).disableAllControl(false);
                    $(formKetThucBienDong).pathValue({
                        movingToDateEnd: ngayHienTai
                    })
                }
            });
        }

        //Xác nhận kết thúc biến động
        function updDateEndHouseHold(responseJSON) {
            $(formId).pathValue({
                movingToDate: responseJSON.data[0],
                movingStatus: responseJSON.data[1]
            });
            lib.showMessage('Ngày về đã được cập nhật!',
                'success', function () {
                    $(formKetThucBienDong).hideDialog();
                    //lib.reload();
                });
        }
    }

    function xoaBienDongHo(action, id, itemName, movingFromDate, movingToDateEnd, HK15) {
        if(!Array.isArray(id)) {
            id = [id];
        }
        var jsonData = {};
        jsonData["id"] = id;
        jsonData["action"] = action !== 'xoa' ? lib.getAction(action) : 'doc';
        jsonData.RPT_HK15 = HK15;
        if (id.length > 1) { // xóa biến động nhiều hộ

            if (action === 'xoa') {
                lib.confirm('Xác nhận xóa biến động các hộ ' + itemName + '?', function (rs) {
                    if (!rs) {
                        return;
                    } else {
                        lib.post({
                            url: $("#PageContext").val() + urlXoaBienDongHo,
                            data: JSON.stringify(jsonData),
                            beforePost: function () {
                                $(formXoaBienDong).uiLoading(true);

                            },
                            complete: function (response) {
                                $(formXoaBienDong).uiLoading(false);
                                lib.showMessage('Bạn đã xóa biến động hộ thành công. Biến động nhân khẩu được chọn đã được tự động xóa cùng!',
                                    'success', function () {
                                        traCuuDanhSachHoBienDong('traCuuBienDong');
                                    });

                            },
                            error: function (ex) {
                                $(formXoaBienDong).bindError(ex);
                                $(formXoaBienDong).uiLoading(false);
                                if (ex.responseJSON.responseJson != undefined && parseInt(ex.responseJSON.HK15) > 0) {
                                    lib.confirm('' + ex.responseJSON.responseMessage + '',
                                        function (rs) {
                                            if (!rs) {
                                                return;
                                            }
                                            var responseJson = ex.responseJSON.responseJson.json;
                                            xoaBienDongHo(responseJson.action, responseJson.id, '', responseJson.movingFromDate, responseJson.movingToDateEnd, KEY_EXIT_HK15);
                                        });
                                    return;
                                }
                            }
                        });
                    }
                });
            }
            if (action === 'doc') {

                lib.post({
                    url: $("#PageContext").val() + urlXoaBienDongHo,
                    data: JSON.stringify(jsonData),
                    beforePost: function () {
                        $(formXoaBienDong).uiLoading(true);

                    },
                    complete: function (response) {
                        $(formXoaBienDong).uiLoading(false);
                        $(formXoaBienDong).hideDialog();
                        lib.showMessage('Bạn đã xóa biến động hộ thành công. Biến động nhân khẩu được chọn đã được tự động xóa cùng!',
                            'success', function () {
                                traCuuDanhSachHoBienDong('traCuuBienDong');
                            });

                    },
                    error: function (ex) {

                        $(formXoaBienDong).bindError(ex);
                        $(formXoaBienDong).uiLoading(false);
                        if (ex.responseJSON.responseJson != undefined && parseInt(ex.responseJSON.HK15) > 0) {
                            lib.confirm('' + ex.responseJSON.responseMessage + '',
                                function (rs) {
                                    if (!rs) {
                                        return;
                                    }
                                    var responseJson = ex.responseJSON.responseJson.json;
                                    xoaBienDongHo(responseJson.action, responseJson.id, '', responseJson.movingFromDate, responseJson.movingToDateEnd, KEY_EXIT_HK15);
                                });
                            return;
                        }
                    }
                });
            }
            return;
        } else { // xóa biến động một hộ
            var movingStatus = lib.parsetoDate(movingToDateEnd, "/") <= lib.parsetoDate(ngayHienTai, "/") ? 1 : 2;
            jsonData.movingFromDate = movingFromDate;
            jsonData.movingToDateEnd = movingToDateEnd;
            jsonData.movingStatus = movingStatus;

        }

        if (action === 'xacNhan') {
            var listCitizenNotInGeographic = [];
            listCitizenNotInGeographic = $(document).getSelectRowMore("row-in-nhanKhauTrongXoaHoBienDong");
            listCitizenNotInGeographic = listCitizenNotInGeographic.join('```');
            jsonData.citizenNotInGeographic = listCitizenNotInGeographic;
        } else {
            $(formXoaBienDong).shownDialog({
                title: 'CHỌN BIẾN ĐỘNG NHÂN KHẨU TRONG HỘ CẦN XÓA THEO',
                action: action,
                onShown: function () {
                    $(formXoaBienDong).resetValidation();
                    $(formXoaBienDong).disableAllControl(false);
                }
            });
        }

        lib.post({
            url: $("#PageContext").val() + urlXoaBienDongHo,
            data: JSON.stringify(jsonData),
            beforePost: function () {
                $(formXoaBienDong).uiLoading(true);
                if (action === 'doc') {
                    $('#nhanKhauTrongXoaHoBienDong').empty();
                    $('<tr ng-show="isLoading" class="row-select">' +
                        '<td class="fit text-center" colspan="6">Đang tải dữ liệu...</td>' +
                        '</tr>').appendTo("#nhanKhauTrongXoaHoBienDong");
                }
            },
            complete: function (response) {
                if (jsonData["action"] === 'doc'){
                    renderTableXoaNhanKhauBienDong(response.responseJSON);
                    $(formXoaBienDong).uiLoading(false);

                } else {
                    // traCuuDanhSachHoBienDong('loadDanhSach');
                    $(formXoaBienDong).uiLoading(false);
                    $(formXoaBienDong).hideDialog();
                    lib.showMessage('Bạn đã xóa biến động hộ thành công. Biến động nhân khẩu được chọn đã được tự động xóa cùng!',
                        'success', function () {
                            //setTimeout(location.reload(), 5000);
                            traCuuDanhSachHoBienDong('traCuuBienDong');
                        });

                }


            },
            error: function (ex) {

                $(formXoaBienDong).bindError(ex);
                $(formXoaBienDong).uiLoading(false);
                if (ex.responseJSON.responseJson != undefined && parseInt(ex.responseJSON.HK15) > 0){
                    lib.confirm('' + ex.responseJSON.responseMessage + '',
                        function (rs) {
                            if (!rs) {
                                return;
                            }
                            var responseJson = ex.responseJSON.responseJson.json;
                            xoaBienDongHo(responseJson.action, responseJson.id, responseJson.itemName, responseJson.movingFromDate, responseJson.movingToDateEnd, KEY_EXIT_HK15);
                        });
                    return;
                }
            }
        });
    }

    function traCuuDanhSachHoBienDong(action) {
        objRowSel = {};
        listArrayRowSel = [];
        $(quickSearchId).resetValidation();
        $(fromThongTinHoNhanKhau).resetValidation();
        $(formThongTinBienDong).resetValidation();
        actionSearch = action;
        nextPageDanhSachHoBienDong();
    }

    function nextPageDanhSachHoBienDong(page = 1, size = 10) {
        $('#lstPojoAsDicHousHoldNotInGeographic-paging').empty();
        var jsonParam = {};
        var count = 0;
        $(quickSearchId).formTextTrim();
        $(fromThongTinHoNhanKhau).formTextTrim();
        $(formThongTinBienDong).formTextTrimControl({
            trongNuocDiaChi: true,
            ngoaiNuocDiaChi: true
        });
        var paramQuickSearch = $(quickSearchId).getValue();
        var paramHoNhanKhau = $(fromThongTinHoNhanKhau).getValue();
        var paramBienDong = $(formThongTinBienDong).getValue();

        if (actionSearch === 'traCuuBienDong') {
            var result = $(quickSearchId).validation({
                maxlength: {
                    cmndChuHo: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN chủ hộ không được quá 12 ký tự'
                    }
                },
                number: {
                    cmndChuHo: 'Số CMND/CCCD/ĐDCN chủ hộ không đúng định dạng. Vui lòng nhập một số'
                }
            });
            if (!result.isValid){
                $(quickSearchId).bindError(result);
                return;
            }
            jsonParam = paramQuickSearch;
            var jsonName = {
                tenChuHoKhongDau: lib.changeAlias(paramQuickSearch.hoTenChuHo).replace(/\s+/g, ''),
                tenThanhVienKhongDau: null,
                movingType: 0,
                khongRoNoiCuTru: false,
                regPlaceCityId: null,
                regPlaceDistrictId: null,
                regPlaceVillageId: null,
                trongNuocDiaChi: null,
                regPlaceCountryId: 0,
                ngoaiNuocDiaChi: null,
                movingFromDate: null,
                movingToDate: null,
                ngaySinhChuHoTuNgay: null,
                ngaySinhChuHoDenNgay: null,
                hoTenThanhVien: null,
                timChinhXacTenThanhVien: false,
                cmndThanhVien: null,
                ngaySinhThanhVienTuNgay: null,
                ngaySinhThanhVienDenNgay: null,
                diaChiThuongTru: null,
                userCityId: userCityId,
                userDistrictId: userDistrictId,
                userVillageId: userVillageId

            };
            jsonParam = lib.mergeValue(jsonParam, jsonName);
        } else {
            /*validate form thông tin chủ hộ*/
            var result = $(fromThongTinHoNhanKhau).validation({
                maxlength: {
                    cmndChuHo: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN chủ hộ không được quá 12 ký tự'
                    },
                    cmndThanhVien: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN thành viên không được quá 12 ký tự'
                    }
                },
                number: {
                    cmndChuHo: 'Số CMND/CCCD/ĐDCN chủ hộ không đúng định dạng. Vui lòng nhập một số',
                    cmndThanhVien: 'Số CMND/CCCD/ĐDCN thành viên không đúng định dạng. Vui lòng nhập một số'
                },
                checkBirthdate: {
                    ngaySinhChuHoTuNgay: 'Ngày không đúng định dạng',
                    ngaySinhChuHoDenNgay: 'Ngày không đúng định dạng',
                    ngaySinhThanhVienTuNgay: 'Ngày không đúng định dạng',
                    ngaySinhThanhVienDenNgay: 'Ngày không đúng định dạng',
                }
            });
            if (!result.isValid){
                $(fromThongTinHoNhanKhau).bindError(result);
                return;
            }
            /*validate form thông tin biến động*/
            var result = $(formThongTinBienDong).validation({
                checkFullDate: {
                    movingFromDate: 'Từ ngày không đúng định dạng',
                    movingToDate: 'Đến ngày không đúng định dạng'

                }
            });
            if (!result.isValid){
                $(formThongTinBienDong).bindError(result);
                return;
            }
            jsonParam = lib.mergeValue(paramHoNhanKhau, paramBienDong);
            var jsonName = {
                tenChuHoKhongDau: lib.changeAlias(paramHoNhanKhau.hoTenChuHo).replace(/\s+/g, ''),
                tenThanhVienKhongDau: lib.changeAlias(paramHoNhanKhau.hoTenThanhVien).replace(/\s+/g, ''),
                userCityId: userCityId,
                userDistrictId: userDistrictId,
                userVillageId: userVillageId
            };
            jsonParam = lib.mergeValue(jsonParam, jsonName);
        }
        jsonParam.page = page;
        jsonParam.size = size;
        jsonParam.action = actionSearch;
        seachValue = jsonParam;
        lib.post({
            url: $("#PageContext").val() + urlTraCuuHoBienDong,
            data: JSON.stringify(jsonParam),
            beforePost: function () {
                $('#danhSachHoBienDong').empty();
                $('<tr ng-show="isLoading" class="row-select">' +
                    '<td class="fit text-center" colspan="14">Đang tải dữ liệu...</td>' +
                    '</tr>').appendTo("#danhSachHoBienDong");
            },
            complete: function (response) {
                if (actionSearch === 'traCuuBienDongNangCao') {
                    $(advSearchId).hideDialog();
                }
                var jsonData = response.responseJSON;
                count = jsonData.dataCountPaging;
                page = jsonData.page;
                renderDanhSachBienDongHo(jsonData, count);
                if (parseInt(count) > 0) {
                    $('#lstPojoAsDicHousHoldNotInGeographic-paging').paging({ page: page, size: size, count: count });
                } else {
                    $('#lstPojoAsDicHousHoldNotInGeographic-paging').empty();
                }

            },
            error: function (ex) {
                for (keyName in ex.responseJSON.errors) {
                    if ($(fromThongTinHoNhanKhau).find('input[name="' + keyName + '"]').length > 0) {
                        $(fromThongTinHoNhanKhau).bindError(ex);
                        $(fromThongTinHoNhanKhau).uiLoading(false);
                    } else {
                        $(formThongTinBienDong).bindError(ex);
                        $(formThongTinBienDong).uiLoading(false);
                    }
                }
                sizeListBienDongHo = 0;
                $('#danhSachHoBienDong').empty();
                $('<tr class="row-select">' +
                    '<td class="fit text-center" colspan="14">Thông tin tìm kiếm không đúng.</td>' +
                    '</tr>').appendTo("#danhSachHoBienDong");
            }
        });
    }

    function renderDanhSachBienDongHo(jsonData, countPaging) {
        var xem = "'xem'";
        var sua = "'sua'";
        var xoa = "'xoa'";
        var cnvs = "'capnhatngayve'";
        var tiepnhan = "'tiepnhan'";
        var note = '';
        sizeListBienDongHo = countPaging;
        if (jsonData.dataHouseHold.length > 0) {
            var data = [];
            data = jsonData.dataHouseHold;
            $('#danhSachHoBienDong').empty();
            $.each(data, function (i) {
                var status = '';
                var sourceDataName = '';
                var statusReceiveName = '';
                var quickAction = '';
                var name = "'" + data[i].houseHoldName + "'";
                if (data[i].receiveStatus == KEY_DA_TAO_BIEN_DONG){
                    if (data[i].movingStatus == 1) {
                        status = '<span class="text-success">Đã trở về</span>';
                    } else if (data[i].movingStatus == 2 && data[i].movingToDate.trim() != "" && lib.parsetoDate(data[i].movingToDate, "/") < lib.parsetoDate(ngayHienTai, "/")) {
                        status = '<span class="text-success">Đã trở về</span>';
                    } else {
                        status = '<span class="text-danger">Chưa trở về</span>';
                    }
                }else {
                    status = '<span class="text"></span>';
                }


                sourceDataName = renderSourceDataName(data[i].sourceData);
                statusReceiveName = renderReceiveStatusName(data[i].receiveStatus);

                if (data[i].receiveStatus == KEY_DA_TAO_BIEN_DONG){
                    quickAction = '<td class="colf-action">' +
                        '<a href="javascript:;" data-tooltip="true" title="Xem" class="not-click"' +
                        'onclick="quickActions(' + xem + ',\'' + data[i].houseHoldId + '\', \'' + data[i].hhRegBookProfNumber + '\', \'' + null + '\', \'' + data[i].receiveStatus + '\');">' +
                        '<span class="nc-icon-outline ui-1_eye-17 not-click"></span>' +
                        '</a>' +
                        '<a href="javascript:;" data-tooltip="true" title="Cập nhật về sớm" class="not-click"' +
                        'onclick="quickActions(' + cnvs + ',\'' + data[i].houseHoldId + '\', \'' + data[i].movingStatus + '\', \'' + data[i].movingToDate + '\',  \'' + data[i].receiveStatus + '\');">' +
                        '<span class="nc-icon-outline users-2_a-time not-click"></span>' +
                        '</a>' +
                        '<a href="javascript:;" data-tooltip="true" title="Sửa" class="not-click"' +
                        'onclick="quickActions(' + sua + ',\'' + data[i].houseHoldId + '\', \'' + data[i].hhRegBookProfNumber + '\',  \'' + null + '\', \'' + data[i].receiveStatus + '\');">' +
                        '<span class="nc-icon-outline ui-1_edit-76 not-click"></span>' +
                        '</a>' +
                        '<a  href="javascript:;" data-tooltip="true" title="Xóa" class="not-click"' +
                        'onclick="quickActions(' + xoa + ',\'' + data[i].houseHoldId + '\',' + name + ');">' +
                        '<span class="nc-icon-outline ui-1_trash-simple not-click"></span>' +
                        '</a></td>'
                }else if (data[i].receiveStatus == KEY_CHO_TAO_BIEN_DONG) {
                    quickAction = '<td class="colf-action">' +
                        '<a href="javascript:;" data-tooltip="true" title="Xem" class="not-click"' +
                        'onclick="quickActions(' + xem + ',\'' + data[i].houseHoldId + '\', \'' + data[i].hhRegBookProfNumber + '\',  \'' + null + '\', \'' + data[i].receiveStatus + '\');">' +
                        '<span class="nc-icon-outline ui-1_eye-17 not-click"></span>' +
                        '</a>' +
                        '<a href="javascript:;" data-tooltip="true" title="Tiếp nhận" class="not-click"' +
                        'onclick="quickActions(' + tiepnhan + ',\'' + data[i].houseHoldId + '\', \'' + data[i].hhRegBookProfNumber + '\', \'' + null + '\', \'' + data[i].receiveStatus + '\');">' +
                        '<span class="nc-icon-outline ui-1_circle-add not-click"></span>' +
                        '</a></td>'
                }else {
                    quickAction = '<td class="colf-action">' +
                        '<a href="javascript:;" data-tooltip="true" title="Xem" class="not-click"' +
                        'onclick="quickActions(' + xem + ',\'' + data[i].houseHoldId + '\', \'' + data[i].hhRegBookProfNumber + '\',  \'' + null + '\', \'' + data[i].receiveStatus + '\');">' +
                        '<span class="nc-icon-outline ui-1_eye-17 not-click"></span>' +
                        '</a></td>'
                }

                $('<tr class="tr-list"><td class="stt" ref="row-in-danhSachHoBienDong">' +
                    '<input type="checkbox" class="select-row checkAllMain" ref="row-in-danhSachHoBienDong"' +
                    'houseHoldResId = "'            + data[i].houseHoldResId            +
                    '"hhRegBookProfNumber="'        + data[i].hhRegBookProfNumber       +
                    '"compareToDate="'              + data[i].compareToDate             +
                    '"houseHoldId= "'               + data[i].houseHoldId               +
                    '"receiveStatus="'              + data[i].receiveStatus             +
                    '"sourceData="'                 + data[i].sourceData                +
                    '"movingStatus="'               + data[i].movingStatus              +
                    '"houseHoldName="'              + data[i].houseHoldName             +
                    '"movingFromDate="'             + data[i].movingFromDate            +
                    '"movingToDate="'               + data[i].movingToDate              + '"/></td>' +
                    '<td class="stt">'              + data[i].rowNumber                 + '</td>' +
                    '<td class="colf-ho-ten">'       + data[i].hhRegBookProfNumber       + '</td>' +
                    '<td class="colf-ho-ten">'       +
                    '<a class="link second" href="javascript:;" ' +
                    'onclick="formDialogCrud(' + xem + ',' + data[i].houseHoldId + ',' + false + ',' + null + ',' + data[i].receiveStatus + ');">' + data[i].houseHoldName + '</a></td>' +
                    '<td class="colf-date">'             + data[i].houseHoldBirthday     + '</td>' +
                    '<td class="colf-cmnd">'             + data[i].identifyNumber        + '</td>' +
                    '<td class="colf-dia-chi">'          + data[i].permanentAddress      + '</td>' +
                    '<td class="colf-dia-chi">'          + data[i].movingAddress         + '</td>' +
                    '<td class="colf-date">'             + data[i].movingFromDate        + '</td>' +
                    '<td class="colf-date">'             + data[i].movingToDate          + '</td>' +
                    '<td class="colf-source">'           + sourceDataName                + '</td>' +
                    '<td class="colf-source">'           + statusReceiveName             + '</td>' +
                    '<td class="colf-status">'           + status + '</td>' + quickAction + '</td></tr>').appendTo("#danhSachHoBienDong");
            });
            if ($('input:checkbox[ref="row-in-danhSachHoBienDong"]:checked').length === $('input:checkbox[ref="row-in-danhSachHoBienDong"]').length) {
                $('input:checkbox[childref="row-in-danhSachHoBienDong"]').prop('checked', true);
            } else {
                $('input:checkbox[childref="row-in-danhSachHoBienDong"]').prop('checked', false);
            }
        } else {
            $('#danhSachHoBienDong').empty();
            $('<tr citizenCode = "" class="row-select">' +
                '<td class="fit text-center" colspan="14"> Không tìm thấy dữ liệu phù hợp điều kiện tìm kiếm </td>' +
                '</tr>').appendTo("#danhSachHoBienDong");
        }
    }

    function renderSourceDataName(sourceVal) {
        sourceDataName = '';
        switch (sourceVal) {
            case 0:
                sourceDataName = "Trực tiếp";
                break;
            case 1:
                sourceDataName = "Tạm trú";
                break;
            case 2:
                sourceDataName = "Tạm vắng";
                break;
            case 3:
                sourceDataName = "Lưu trú";
                break;
            case 4:
                sourceDataName = "Khai báo thông tin về nơi ở hiện tại";
                break;
        }
        return sourceDataName;
    }

    function renderReceiveStatusName(status) {
        statusReceiveName = '';
        switch (status) {
            case 1:
                statusReceiveName = "Biến động chờ tạo";
                break;
            case 2:
                statusReceiveName = "Biến động không tạo";
                break;
            case 3:
                statusReceiveName = "Biến động đã tạo";
                break;
            default:
                statusReceiveName = "không rõ";
                break;
        }
        return statusReceiveName;
    }

    var tracuudiaban;
    function traCuuHoCuTruTaiDiaBan(action) {
        $(formtraCuuHoCuTru).resetValidation();
        $(formtraCuuHoCuTruNangCao).resetValidation();
        if (action === 'open') {
            $("#noteSeachHouseHold").empty();
            $("#thongTinHoKhau").empty();
            $('#thongTinHoKhau-paging').empty();
            $(formtraCuuHoCuTru).pathValue({
                sch_soHoSoCuTru: '',
                sch_hoTenChuHo: '',
                sch_chinhXacTenChuHo: false,
                sch_cmndChuHo: ''
            });
            $(formtraCuuHoCuTruNangCao).pathValue({
                sch_soHoSoCuTru: "",
                sch_hoTenChuHo: "",
                sch_chinhXacTenChuHo: false,
                sch_cmndChuHo: "",
                sch_ngaySinhChuHoTuNgay: "",
                sch_ngaySinhChuHoDenNgay: "",
                sch_hoTenThanhVien: "",
                sch_ChinhXacTenThanhVien: false,
                sch_cmndThanhVien: "",
                sch_ngaySinhThanhVienTuNgay: "",
                sch_ngaySinhThanhVienDenNgay: "",
                sch_diaChiThuongTru: "",
                page: "1"
            });
            openDialogTraCuu();
            return;
        }

        if (action === 'tracuu' || action === 'tracuunangcao') {
            tracuudiaban = action;
            nextPageTraCuuHoCuTru();

        } else if (action === 'chon') {
            if (rowId.val() != null && rowId.val() != "") {
                $(formtraCuuHoCuTru).hideDialog();
                actions = 'chon';
                finalHHRegBookProfNumber = rowId.val();
                dataNextPage();
                $(formId).resetValidation();
                $(formId).pathValue({
                    hhRegBookProfNumber: rowId.val()
                });
                rowId.val("");
            } else {
                lib.showMessage('Bạn chưa chọn hộ để thêm.',
                    'error', function () {
                        // lib.reload();
                    });

            }

        }

        function openDialogTraCuu() {
            $(formtraCuuHoCuTru).shownDialog({
                title: 'TRA CỨU HỘ THƯỜNG TRÚ TẠI ĐỊA BÀN',
                action: action,
                onShown: function () {
                    $(formtraCuuHoCuTru).find("#sch_soHoSoHoKhau").focus();
                }
            });
        }
    }

    function refeshTraCuuHoCuTruTaiDiaBan() {
        $(formtraCuuHoCuTru).pathValue({
            "sch_soHoSoCuTru": "",
            "sch_hoTenChuHo": "",
            "sch_chinhXacTenChuHo": false,
            "sch_cmndChuHo": "",
            "page": "1",
            "selectAll-thongTinHoKhau": false
        });

        $(formtraCuuHoCuTruNangCao).pathValue({
            "sch_ngaySinhChuHoTuNgay": "",
            "sch_ngaySinhChuHoDenNgay": "",
            "sch_hoTenThanhVien": "",
            "sch_ChinhXacTenThanhVien": false,
            "sch_cmndThanhVien": "",
            "sch_ngaySinhThanhVienTuNgay": "",
            "sch_ngaySinhThanhVienDenNgay": "",
            "sch_diaChiThuongTru": ""
        });
    }

    function refeshTraCuuHoCuTruTaiDiaBanNangCao() {
        $(formtraCuuHoCuTruNangCao).pathValue({
            "sch_soHoSoCuTru": "",
            "sch_hoTenChuHo": "",
            "sch_chinhXacTenChuHo": false,
            "sch_cmndChuHo": "",
            "sch_ngaySinhChuHoTuNgay": "",
            "sch_ngaySinhChuHoDenNgay": "",
            "sch_hoTenThanhVien": "",
            "sch_ChinhXacTenThanhVien": false,
            "sch_cmndThanhVien": "",
            "sch_ngaySinhThanhVienTuNgay": "",
            "sch_ngaySinhThanhVienDenNgay": "",
            "sch_diaChiThuongTru": "",
            "page": "1"
        });
    }

    function refeshMovingto() {
        $("#destionalType1").prop('checked', true);
        $("#divMovingCountryId").hide();
        $("#divMovingType").show();
        $("#divMovingInCountry").show();
        $("#divMovingAddress").show();
        $("#permanentCityId").val("");
        $("#permanentDistrictId").val("");
        $("#permanentVillageId").val("");
        $("#permanentAddress").val("");
        $(formId).pathValue({
            // houseHoldResId: null,
            placeToMovingType: '',
            movingCountryId: null,
            movingCityId: null,
            movingDistrictId: null,
            movingVillageId: null,
            movingAddress: '',
            reason: '',
            movingFromDate: '',
            movingToDate: '',
            movingStatus: ''
        });
        $(formId).disableControlValue({
            movingCityId: false,
            movingDistrictId: true,
            movingVillageId: true
        });
    }

    function nextPageTraCuuHoCuTru(page = 1, size = 10) {
        var count = 0;
        var jsonParams = {
            page: page,
            size: size
        };
        $(formtraCuuHoCuTru).formTextTrim();
        $(formtraCuuHoCuTruNangCao).formTextTrim();

        if (tracuudiaban === 'tracuu') {
            var formTraCuuData = $(formtraCuuHoCuTru).getValue();
            var result = $(formtraCuuHoCuTru).validation({
                maxlength: {
                    sch_cmndChuHo: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN chủ hộ không được quá 12 ký tự'
                    }
                },
                number: {
                    sch_cmndChuHo: 'Số CMND/CCCD/ĐDCN chủ hộ không đúng định dạng. Vui lòng nhập một số'
                }
            });
            if (!result.isValid){
                $(formtraCuuHoCuTru).bindError(result);
                return;
            }
            var jsonName = {
                tenHoKhongDau: lib.changeAlias(formTraCuuData.sch_hoTenChuHo)
            };
            jsonParams = lib.mergeValue(formTraCuuData, jsonParams);
            jsonParams = lib.mergeValue(jsonParams, jsonName);
        } else {
            // tra cuu nang cao
            var formTraCuuData = $(formtraCuuHoCuTruNangCao).getValue();
            var result = $(formtraCuuHoCuTruNangCao).validation({
                maxlength: {
                    sch_cmndChuHo: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN chủ hộ không được quá 12 ký tự'
                    },
                    sch_cmndThanhVien: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN thành viên không được quá 12 ký tự'
                    }
                },
                number: {
                    sch_cmndChuHo: 'Số CMND/CCCD/ĐDCN chủ hộ không đúng định dạng. Vui lòng nhập một số',
                    sch_cmndThanhVien: 'Số CMND/CCCD/ĐDCN thành viên không đúng định dạng. Vui lòng nhập một số'
                },
                checkBirthdate: {
                    sch_ngaySinhChuHoTuNgay: 'Ngày không đúng định dạng',
                    sch_ngaySinhChuHoDenNgay: 'Ngày không đúng định dạng',
                    sch_ngaySinhThanhVienTuNgay: 'Ngày không đúng định dạng',
                    sch_ngaySinhThanhVienDenNgay: 'Ngày không đúng định dạng'
                }
            });
            if (!result.isValid){
                $(formtraCuuHoCuTruNangCao).bindError(result);
                return;
            }
            var jsonName = {
                tenHoKhongDau: lib.changeAlias(formTraCuuData.sch_hoTenChuHo),
                tenThanhVienKhongDau: lib.changeAlias(formTraCuuData.sch_hoTenThanhVien)
            };
            jsonParams = lib.mergeValue(formTraCuuData, jsonParams);
            jsonParams = lib.mergeValue(jsonParams, jsonName);
        }

        jsonParams.page = page;
        jsonParams.size = size;
        lib.post({
            url: $("#PageContext").val() + urlTraCuuHoCuTru,
            data: JSON.stringify(jsonParams),
            beforePost:function(){
                $(formtraCuuHoCuTru).uiLoading(true);
                $(formtraCuuHoCuTruNangCao).uiLoading(true);
                $('#thongTinHoKhau').empty();
                $('<tr ng-show="isLoading" class="row-select">' +
                    '<td class="fit text-center" colspan="8">Đang tải dữ liệu...</td>' +
                    '</tr>').appendTo("#thongTinHoKhau");
            },
            complete: function (response) {
                $(formtraCuuHoCuTru).uiLoading(false);
                $(formtraCuuHoCuTruNangCao).uiLoading(false);
                var responseJson = response.responseJSON;
                count = responseJson.countPaging;
                var page = responseJson.page;
                //render paging
                renderdanhSachHoKhau(responseJson);
                $('#thongTinHoKhau-paging').paging({ page: page, size: size, count: count });
                if (tracuudiaban === 'tracuunangcao') {
                    $(formtraCuuHoCuTruNangCao).hideDialog();
                }
            },
            error: function (ex) {
                $(formtraCuuHoCuTruNangCao).bindError(ex);
                $(formtraCuuHoCuTruNangCao).uiLoading(false);
                $('#thongTinHoKhau').empty();
                $('<tr class="row-select">' +
                    '<td class="fit text-center" colspan="8">Thông tin tìm kiếm không đúng.</td>' +
                    '</tr>').appendTo("#thongTinHoKhau");
            }
        });
    }

    function renderdanhSachHoKhau(responJson) {
        // $("#thongTinHoKhau").empty();
        // $("#noteSeachHouseHold").empty();
        $("#noteSeachHouseHold").empty();
        var note = parseInt(responJson.countPaging) < 100 ? 'Có ' + parseInt(responJson.countPaging) + ' kết quả được tìm thấy.' : 'Có nhiều hơn 100 kết quả được tìm thấy.';
        $('<p>' + note + '</p>').appendTo("#noteSeachHouseHold");

        if (responJson.data.length > 0) {
            $('#thongTinHoKhau').empty();
            var data = [];
            data = responJson.data;
            $.each(data, function (i) {
                var genderName = data[i].genDer == 1 ? 'chưa có thông tin' : data[i].genDer == 2 ? 'Nam' : data[i].genDer == 3 ? 'Nữ' : 'khác';
                $('<tr class="tr-list"><td class="stt"><input type="checkbox" name="row-thongTinHoKhau" class="radio" ' +
                    'value = "'                 + data[i].hhRegBookProfNumber       +
                    '"hhRegBookProfNumber ="'   + data[i].hhRegBookProfNumber       +
                    '"houseHoldResId="'         + data[i].houseHoldResId            + '"/></td>' +
                    '<td class="stt">'          + data[i].rowNumber                 + '</td>' +
                    '<td class="colf-ho-ten">'  + data[i].hhRegBookProfNumber       + '</td>' +
                    '<td class="colf-ho-ten">'  + data[i].fullName                  + '</td>' +
                    '<td class="colf-date">'    + data[i].houseHoldBirthday         + '</td>' +
                    '<td class="colf-status">'  + genderName                        + '</td>' +
                    '<td class="colf-cmnd">'    + data[i].identifyNumber            + '</td>' +
                    '<td class="colf-dia-chi">' + data[i].permanentAddress          + '</td>' +
                    '</tr>').appendTo("#thongTinHoKhau");
            });
        } else {
            $('#thongTinHoKhau').empty();
            $('<tr citizenCode = "" class="row-select">' +
                '<td class="fit text-center" colspan="8"> Không tìm thấy dữ liệu phù hợp điều kiện tìm kiếm </td>' +
                '</tr>').appendTo("#thongTinHoKhau");
        }
    }

    function dataNextPage(page = 1, size = 10) {
        var count = 0;
        refeshMovingto();
        $(formId).uiLoading(true);
        lib.getApi({
            url: $("#PageContext").val() + '/biendongdancu/lstHouseHoldFindById',
            data: {
                hhRegBookProfNumber: finalHHRegBookProfNumber,
                houseHoldResId: houseHoldResId != '' ? houseHoldResId : null,
                page: page,
                size: size
            },
            complete: function (response) {
                debugger
                $(formId).uiLoading(false);
                if (parseInt(response.sizeListHouseHold) == 1) {
                    count = response.countPaging;
                    //render paging
                    renderTableNhanKhau(response);
                    $('#thongTinNhanKhau-paging').paging({ page: page, size: size, count: count });
                } else {
                    traCuuHoCuTruTaiDiaBan('open');
                }

            },
            error: function (ex) {
                $(formId).bindError(ex);
                $(formId).uiLoading(false);
            }
        });

    }

    function renderTableNhanKhau(responJson) {
        $("#thongTinNhanKhau").empty();
        $("#tamvang").empty();
        $("#tamtru").empty();
        debugger
        if (responJson.dataABS.length > 0 && actions == 'chon') {
            $("#tamvang").empty();
            var fullDestionaltionAddress = '';
            if (parseInt(responJson.dataABS[0].destionalType) == 1){
                fullDestionaltionAddress = responJson.dataABS[0].destionaltionAddress + ", " + responJson.dataABS[0].countryName;
            }else {
                fullDestionaltionAddress = responJson.dataABS[0].destionaltionAddress + ", " + responJson.dataABS[0].villageName + ", " + responJson.dataABS[0].districtName + ", " + responJson.dataABS[0].cityName;
            }
            var prototypeABS = 'Hộ đang trong thời gian tạm vắng từ: ' + responJson.dataABS[0].ABSFromDate + ' đến ' + responJson.dataABS[0].ABSToDate + '. Số hồ sơ tạm vắng: ' + responJson.dataABS[0].ABSProResId;
            var prototypeAddress = 'Nơi đến: ' + fullDestionaltionAddress;
            $('<span class="text-danger">' + prototypeABS + '</span><br>'
                + '<span class="text-danger">' + prototypeAddress + '</span>').appendTo("#tamvang");

            if (parseInt(responJson.dataABS[0].destionalType) == 1) { /*Nước ngoài*/
                $("#divMovingCountryId").show();
                $("#divMovingType").hide();
                $("#divMovingInCountry").hide();
                $("#divMovingAddress").show();
                $(formId).pathValue({
                    destionalType: 2,
                    movingCountryId: responJson.dataABS[0].movingCountryId,
                    movingAddress: responJson.dataABS[0].destionaltionAddress, /*địa chỉ cụ thể nơi đến*/
                    reason: responJson.dataABS[0].reason,
                    movingFromDate: responJson.dataABS[0].ABSFromDate,
                    movingToDate: responJson.dataABS[0].ABSToDate,
                    movingStatus: responJson.dataABS[0].movingStatus
                });
            } else { /*trong nước*/
                $("#divMovingCountryId").hide();
                $("#divMovingType").show();
                $("#divMovingInCountry").show();
                $("#divMovingAddress").show();
                $(formId).pathValue({
                    destionalType: 1,
                    placeToMovingType: responJson.dataABS[0].movingType,
                    movingAddress: responJson.dataABS[0].destionaltionAddress, /*địa chỉ cụ thể nơi đến*/
                    reason: responJson.dataABS[0].reason,
                    movingFromDate: responJson.dataABS[0].ABSFromDate,
                    movingToDate: responJson.dataABS[0].ABSToDate,
                    movingStatus: responJson.dataABS[0].movingStatus
                });
                processInfoMovingType(
                    responJson.dataABS[0].movingType,
                    responJson.dataABS[0].movingCityId,
                    responJson.dataABS[0].movingDistrictId,
                    responJson.dataABS[0].movingVillageId);
            }
        }
        if (parseInt(responJson.dataCiti.length) > 0 && actions == 'chon') {
            $("#tamtru").empty();
            var fullTempResAddress = '';
            if (parseInt(responJson.dataCiti[0].destionalType) == 2){
                fullTempResAddress = responJson.dataCiti[0].tempResAddress + ", " + responJson.dataCiti[0].countryName;
            }else {
                fullTempResAddress = responJson.dataCiti[0].tempResAddress + "" + responJson.dataCiti[0].movingAddress;
            }
            var prototypeDim = 'Hộ đang trong thời gian tạm trú từ: ' + responJson.dataCiti[0].regFromDate + ' đến ' + responJson.dataCiti[0].regToDate + '. Số hồ sơ tạm trú: ' + responJson.dataCiti[0].LSTProResId;
            var prototypeAddress = 'Địa chỉ tạm trú: ' + fullTempResAddress;
            $('<span class="text-danger">' + prototypeDim + '</span><br>'
                + '<span class="text-danger">' + prototypeAddress + '</span>').appendTo("#tamtru");

            if (parseInt(responJson.dataABS.length) < 1) {
                if (parseInt(responJson.dataCiti[0].destionalType) == 2) { /*Nước ngoài*/
                    $("#divMovingCountryId").show();
                    $("#divMovingType").hide();
                    $("#divMovingInCountry").hide();
                    $("#divMovingAddress").show();
                    $(formId).pathValue({
                        destionalType: 2,
                        movingCountryId: responJson.dataCiti[0].movingCountryId,
                        movingAddress: responJson.dataCiti[0].tempResAddress, /*địa chỉ cụ thể nơi đến*/
                        reason: '',
                        movingFromDate: dataCiti.dataCiti[0].regFromDate,
                        movingToDate: dataCiti.dataCiti[0].regToDate,
                        movingStatus: dataCiti.dataCiti[0].movingStatus
                    });
                } else { /*trong nước*/
                    $("#divMovingCountryId").hide();
                    $("#divMovingType").show();
                    $("#divMovingInCountry").show();
                    $("#divMovingAddress").show();
                    $(formId).pathValue({
                        destionalType: 1,
                        placeToMovingType: responJson.dataCiti[0].movingType,
                        movingAddress: responJson.dataCiti[0].tempResAddress, /*địa chỉ cụ thể nơi đến*/
                        reason: '',
                        movingFromDate: responJson.dataCiti[0].regFromDate,
                        movingToDate: responJson.dataCiti[0].regToDate,
                        movingStatus: responJson.dataCiti[0].movingStatus
                    });
                    processInfoMovingType(
                        responJson.dataCiti[0].movingType,
                        responJson.dataCiti[0].movingCityId,
                        responJson.dataCiti[0].movingDistrictId,
                        responJson.dataCiti[0].movingVillageId);
                }
            }
        }
        if (responJson.data) {
            var data = [];
            data = responJson.data;
            $('#thongTinNhanKhau').empty();
            $.each(data, function (i) {
                var genderName = data[i].genDer == 1 ? 'chưa có thông tin' : data[i].genDer == 2 ? 'Nam' : data[i].genDer == 3 ? 'Nữ' : 'khác';
                if (data[i].houseHoldRelationshipId == KEY_CHU_HO && actions === 'chon') { /*fill thông tin chủ hộ*/
                    permanentCityId = data[i].permanentCityId;
                    houseHoldResId = data[i].houseHoldResId;
                    finalHHRegBookProfNumber = data[i].hhRegBookProfNumber;
                    /*Địa chỉ thường trú trong hồ sơ BĐ*/
                    $("#permanentCityId").val(data[i].permanentCityId);
                    $("#permanentDistrictId").val(data[i].permanentDistrictId);
                    $("#permanentVillageId").val(data[i].permanentVillageId);
                    $("#permanentAddress").val(data[i].permanentAddress);
                    /*End địa chỉ thường trú trong hồ sơ BĐ*/
                    $(formId).pathValue({
                        hhRegBookProfNumber: data[i].hhRegBookProfNumber,
                        hoTenChuHo: data[i].fullName,
                        soCMNDChuHo: data[i].identifyNumber,
                        ngaySinhChuHo: data[i].houseHoldBirthday,
                        diaChiThuongTru: data[i].permanentAddress
                    });
                } else if (data[i].houseHoldRelationshipId == KEY_CHU_HO && actions === 'doc') { /*fill thông tin chủ hộ*/
                    houseHoldResId = data[i].houseHoldResId;
                    finalHHRegBookProfNumber = data[i].hhRegBookProfNumber;
                    /*Địa chỉ thường trú trong hồ sơ BĐ*/
                    $("#permanentCityId").val(data[i].permanentCityId);
                    $("#permanentDistrictId").val(data[i].permanentDistrictId);
                    $("#permanentVillageId").val(data[i].permanentVillageId);
                    $("#permanentAddress").val(data[i].permanentAddress);
                    /*End địa chỉ thường trú trong hồ sơ BĐ*/
                    $(formId).pathValue({
                        hhRegBookProfNumber: data[i].hhRegBookProfNumber,
                        hoTenChuHo: data[i].fullName,
                        soCMNDChuHo: data[i].identifyNumber,
                        ngaySinhChuHo: data[i].houseHoldBirthday,
                        diaChiThuongTru: data[i].permanentAddress
                    });
                }
                $('<tr><td class="stt">' + data[i].rowNumber + '</td>' +
                    '<td class="fit col-ho-ten">' + data[i].fullName + '</td>' +
                    '<td class="fit text-center">' + data[i].houseHoldBirthday + '</td>' +
                    '<td class="fit">' + genderName + '</td>' +
                    '<td class="fit text-right">' + data[i].identifyNumber + '</td>' +
                    '<td class="fit">' + data[i].relationshipName + '</td>' +
                    '<td class="fit text-center">' + data[i].notfoundDate + '</td>' +
                    '</tr>').appendTo("#thongTinNhanKhau");
                // $('#thongTinNhanKhau-paging').hide();
            });
        }
    }

    function renderTableNhanKhauBienDong(responJson, movingToDateEnd) {
        $("#nhanKhauTrongHoBienDong").empty();
        if (responJson.citizenNotInGeographic.length > 0){
            var data = [];
            data = responJson.citizenNotInGeographic;
            $.each(data, function (i) {
                var movingStatus = '';
                var disabled = '';
                var checked = '';
                if (parseInt(data[i].movingStatus) == 1){
                    movingStatus = '<span class="text-success">Đã trở về</span>';
                    disabled = 'disabled';
                    checked = '';
                } else {
                    movingStatus = '<span class="text-danger">Chưa trở về</span>';
                    if (parseInt(data[i].isMoving) == 2 || (movingToDateEnd != null && lib.parsetoDate(movingToDateEnd, "/") < lib.parsetoDate(data[i].movingFromDate, "/"))){
                        disabled = 'disabled';
                        checked = '';
                    }else {
                        disabled = '';
                        checked = 'checked';
                    }
                }
                $('<tr class="tr-list"><td class="fit text-center" ref="row-in-nhanKhauTrongHoBienDong">' +
                    '<input type="checkbox" ' + checked + ' ' + disabled + ' class="select-row checkAllMain" ref="row-in-nhanKhauTrongHoBienDong" value= "' + data[i].citizenGeographicId + '"></td>' +
                    '<td class="stt text-center">' + data[i].rowNumber + '</td>'+
                    '<td class="col-ho-ten">' + data[i].full_name + '</td>'+
                    '<td class="fit text-center">' + data[i].movingFromDate + '</td>'+
                    '<td class="fit text-center">' + data[i].movingToDate + '</td>'+
                    '<td class="col-status text-center">' + movingStatus + '</td>'+
                    '</tr>').appendTo("#nhanKhauTrongHoBienDong");
            });

            // if ($('input:checkbox[ref="row-in-nhanKhauTrongHoBienDong"]:checked').length === $('input:checkbox[ref="row-in-nhanKhauTrongHoBienDong"]').length) {
            //     $('input:checkbox[childref="row-in-nhanKhauTrongHoBienDong"]').prop('checked', true);
            // } else {
            //     $('input:checkbox[childref="row-in-nhanKhauTrongHoBienDong"]').prop('checked', false);
            // }
        }else {
            $('#nhanKhauTrongHoBienDong').empty();
            $('<tr citizenGeographicId = "" class="row-select">' +
                '<td class="fit text-center" colspan="6">Không có dữ liệu</td>' +
                '</tr>').appendTo("#nhanKhauTrongHoBienDong");
        }

    }

    function renderTableXoaNhanKhauBienDong(responJson, movingToDateEnd) {
        $("#nhanKhauTrongXoaHoBienDong").empty();
        if (responJson.citizenNotInGeographic.length > 0){
            var data = [];
            data = responJson.citizenNotInGeographic;
            $.each(data, function (i) {
                var movingStatus = '';
                if (parseInt(data[i].movingStatus) == 1){
                    movingStatus = '<span class="text-success">Đã trở về</span>';
                } else {
                    movingStatus = '<span class="text-danger">Chưa trở về</span>';
                }
                $('<tr class="tr-list"><td class="fit text-center" ref="row-in-nhanKhauTrongXoaHoBienDong">' +
                    '<input type="checkbox" checked class="select-row checkAllMain" ref="row-in-nhanKhauTrongXoaHoBienDong" value= "' + data[i].citizenGeographicId + '"></td>' +
                    '<td class="stt text-center">' + data[i].rowNumber + '</td>'+
                    '<td class="col-ho-ten">' + data[i].full_name + '</td>'+
                    '<td class="fit text-center">' + data[i].movingFromDate + '</td>'+
                    '<td class="fit text-center">' + data[i].movingToDate + '</td>'+
                    '<td class="col-status text-center">' + movingStatus + '</td>'+
                    '</tr>').appendTo("#nhanKhauTrongXoaHoBienDong");
            });

            if ($('input:checkbox[ref="row-in-nhanKhauTrongXoaHoBienDong"]:checked').length === $('input:checkbox[ref="row-in-nhanKhauTrongXoaHoBienDong"]').length) {
                $('input:checkbox[childref="row-in-nhanKhauTrongXoaHoBienDong"]').prop('checked', true);
            } else {
                $('input:checkbox[childref="row-in-nhanKhauTrongXoaHoBienDong"]').prop('checked', false);
            }
        }else {
            $('#nhanKhauTrongXoaHoBienDong').empty();
            $('<tr citizenGeographicId = "" class="row-select">' +
                '<td class="fit text-center" colspan="6">Không có dữ liệu</td>' +
                '</tr>').appendTo("#nhanKhauTrongXoaHoBienDong");
        }

    }

    function processInfoMovingType(movingType, movingCity, movingDistrict, movingVillage, action) {
        if (action === 'xem' || action === 'capnhatngayve') {
            $(formId).disableControlValue({
                movingCityId: true,
                movingDistrictId: true,
                movingVillageId: true
            });
            setTimeout(function () {
                $(formId).pathValue({
                    movingCityId: movingCity,
                    movingDistrictId: movingDistrict,
                    movingVillageId: movingVillage
                });
            }, 350);
        } else if (action === 'sua') {
            switch (parseInt(movingType)) {
                case 1:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            notCityId: userCityId,
                            showAll: true
                        }));

                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: movingCity,
                            showAll: true
                        }));

                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: movingDistrict,
                            showAll: true
                        }));
                    $(formId).disableControlValue({
                        movingCityId: false,
                        movingDistrictId: false,
                        movingVillageId: false
                    });

                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });

                    break;
                case 2:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            showAll: true
                        }));

                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: userCityId,
                            notDistrictId: userDistrictId,
                            showAll: true
                        }));

                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: movingDistrict,
                            showAll: true
                        }));

                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: true,
                            movingDistrictId: false,
                            movingVillageId: false
                        });
                    },300);

                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });

                    break;
                case 3:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            showAll: true
                        }));

                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: userCityId,
                            showAll: true
                        }));

                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: userDistrictId,
                            notVillageId: userVillageId,
                            showAll: true
                        }));

                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: true,
                            movingDistrictId: true,
                            movingVillageId: false
                        });
                    },300);

                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });
                    break;
                case 4:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            showAll: true
                        }));

                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: userCityId,
                            showAll: true
                        }));

                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: userDistrictId,
                            showAll: true
                        }));

                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: true,
                            movingDistrictId: true,
                            movingVillageId: true
                        });
                    },300);

                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });
                    break;
            }
        } else {
            switch (parseInt(movingType)) {
                case 1:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            notCityId: userCityId,
                            showAll: true
                        }));
                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: movingCity,
                            showAll: true
                        }));
                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: movingDistrict,
                            showAll: true
                        }));
                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });
                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: false,
                            movingDistrictId: false,
                            movingVillageId: false
                        });
                    }, 300);

                    break;
                case 2:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            showAll: true
                        }));
                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: userCityId,
                            notDistrictId: userDistrictId,
                            showAll: true
                        }));

                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: movingDistrict,
                            showAll: true
                        }));
                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });
                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: true,
                            movingDistrictId: false,
                            movingVillageId: false
                        });
                    },300);

                    break;
                case 3:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            showAll: true
                        }));
                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: userCityId,
                            showAll: true
                        }));
                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: userDistrictId,
                            notVillageId: userVillageId,
                            showAll: true
                        }));

                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });
                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: true,
                            movingDistrictId: true,
                            movingVillageId: false
                        });
                    },300);
                    break;
                case 4:
                    $('select[name=movingCityId]').attr("data-param",
                        JSON.stringify({
                            showAll: true
                        }));
                    $('select[name=movingDistrictId]').attr("data-param",
                        JSON.stringify({
                            cityId: userCityId,
                            showAll: true
                        }));
                    $('select[name=movingVillageId]').attr("data-param",
                        JSON.stringify({
                            districtId: userDistrictId,
                            showAll: true
                        }));

                    $(formId).pathValue({
                        movingCityId: movingCity,
                        movingDistrictId: movingDistrict,
                        movingVillageId: movingVillage
                    });
                    setTimeout(function () {
                        $(formId).disableControlValue({
                            movingCityId: true,
                            movingDistrictId: true,
                            movingVillageId: true
                        });
                    },300);
                    break;
            }
        }
    }

    function ketXuatBienDong(type) {
        if (parseInt(sizeListBienDongHo) > 0) {
            var fileName = '';
            var result = $(quickSearchId).validation({
                maxlength: {
                    cmndChuHo: {
                        value: 12,
                        message: 'Số CMND/CCCD/ĐDCN chủ hộ không được quá 12 ký tự'
                    }
                },
                number: {
                    cmndChuHo: 'Số CMND/CCCD/ĐDCN chủ hộ không đúng định dạng. Vui lòng nhập một số'
                }
            });
            if (!result.isValid){
                $(quickSearchId).bindError(result);
                return;
            }
            if (JSON.stringify(seachValue) === '{}') {
                seachValue = $(advSearchId).getValue();
                seachValue.userCityId = userCityId;
                seachValue.userDistrictId = userDistrictId;
                seachValue.userVillageId = userVillageId;
            }
            if (seachValue.statusReceive == KEY_DA_TAO_BIEN_DONG){
                fileName = 'Danh_Sach_Bien_Dong_Ho_Khong_Cu_Tru_Tai_Noi_Dang_Ky_Thuong_Tru';
            }else {
                fileName = 'Danh_Sach_Tiep_Nhan_Bien_Dong_Ho_Khong_Cu_Tru_Tai_Noi_Dang_Ky_Thuong_Tru';
            }
            var jsonParam = {
                ...seachValue,
                fileName: fileName,
                ngaySinhChuHoTuNgay: seachValue.ngaySinhChuHoTuNgay == null ? null : lib.parseBirthDate(seachValue.ngaySinhChuHoTuNgay, 'start'),
                ngaySinhChuHoDenNgay: seachValue.ngaySinhChuHoDenNgay == null ? null : lib.parseBirthDate(seachValue.ngaySinhChuHoDenNgay, 'end'),
                ngaySinhThanhVienTuNgay: seachValue.ngaySinhThanhVienTuNgay == null ? null : lib.parseBirthDate(seachValue.ngaySinhThanhVienTuNgay, 'start'),
                ngaySinhThanhVienDenNgay: seachValue.ngaySinhThanhVienDenNgay == null ? null : lib.parseBirthDate(seachValue.ngaySinhThanhVienDenNgay, 'end'),
                countPaging: sizeListBienDongHo

            };

            rp.dowloadFileParam(jsonParam, type);
        } else {
            lib.showMessage('Không có dữ liệu cần kết xuất',
                'error', function () {
                    // lib.reload();
                });
        }

    }

    function functionActions(action) {
        listArrayRowSel = getRowCheckSelect('row-in-danhSachHoBienDong');
        actionDialog = action;
        switch (action) {
            case 'tiepnhan':
                if (listArrayRowSel.length > 1) {
                    var arrhouseHoldName = [];
                    var arrReceiveId = [];
                    for (var item of listArrayRowSel){
                        if (item.receiveStatus != KEY_CHO_TAO_BIEN_DONG){
                            lib.showMessage('Bạn không thể chọn biến động đã tạo hoặc biến động không tạo để tiếp nhận', 'error', function () {});
                            return;
                        }
                        arrReceiveId.push(item.houseHoldId);
                        arrhouseHoldName.push(item.houseHoldName);
                    }
                    var strArrReceiveId = '[' + arrReceiveId.join(', ') + ']';
                    arrhouseHoldName = arrhouseHoldName.join(', ');
                    lib.confirm('Xác nhận tiếp nhận hàng loạt biến động hộ: ' + arrhouseHoldName + ' ?',
                        function (rs) {
                            if (!rs) {
                                return;
                            }
                            tiepNhanHangLoatBienDongHoNhap(strArrReceiveId, KEY_CHECK_HK15);
                        });
                    break;
                }else if (listArrayRowSel.length == 1 &&
                    listArrayRowSel[0].houseHoldId != null &&
                    listArrayRowSel[0].houseHoldId != "" &&
                    listArrayRowSel[0].receiveStatus == KEY_CHO_TAO_BIEN_DONG) {
                    formDialogCrud('tiepnhan', listArrayRowSel[0].houseHoldId, false, listArrayRowSel[0].hhRegBookProfNumber, listArrayRowSel[0].receiveStatus);
                    break;
                }

                if (listArrayRowSel.length == 1 && listArrayRowSel[0].receiveStatus != KEY_CHO_TAO_BIEN_DONG) {
                    var message = '';
                    if (listArrayRowSel[0].receiveStatus == KEY_DA_TAO_BIEN_DONG){
                        message = 'Bạn không thể chọn hộ đã tạo biến động để tiếp nhận';
                    }else if (listArrayRowSel[0].receiveStatus == KEY_KHONG_TAO_BIEN_DONG){
                        message = 'Bạn không thể chọn biến động không tạo để tiếp nhận';
                    }
                    lib.showMessage('' + message +'', 'error', function () {});
                    break;
                }

                if (listArrayRowSel.length == 0) {
                    lib.showMessage('Bạn chưa chọn hộ để tiếp nhận', 'error', function () {});
                    break;
                }
                break;
            case 'xem':
                if (listArrayRowSel.length > 1) {
                    lib.showMessage('Chỉ được phép chọn một hộ biến động để xem',
                        'error', function () {
                            // lib.reload();
                        });
                } else if (listArrayRowSel.length == 1 &&
                    listArrayRowSel[0].houseHoldId != null &&
                    listArrayRowSel[0].houseHoldId != "") {
                    formDialogCrud('xem', listArrayRowSel[0].houseHoldId, false, listArrayRowSel[0].hhRegBookProfNumber, listArrayRowSel[0].receiveStatus);
                } else {
                    lib.showMessage('Bạn chưa chọn hộ biến động để xem',
                        'error', function () {
                            // lib.reload();
                        });
                }
                break;
            case 'sua':
                if (listArrayRowSel.length > 1) {
                    lib.showMessage('Chỉ được phép chọn một hộ biến động để sửa',
                        'error', function () {
                            // lib.reload();
                        });
                } else if (listArrayRowSel.length == 1 &&
                    listArrayRowSel[0].houseHoldId != null &&
                    listArrayRowSel[0].houseHoldId != "" &&
                    listArrayRowSel[0].receiveStatus == KEY_DA_TAO_BIEN_DONG) {
                    $(formId).resetValidation();
                    formDialogCrud('sua', listArrayRowSel[0].houseHoldId, false, listArrayRowSel[0].hhRegBookProfNumber, listArrayRowSel[0].receiveStatus);
                }else if (listArrayRowSel.length == 1 && listArrayRowSel[0].receiveStatus != KEY_DA_TAO_BIEN_DONG) {
                    lib.showMessage('Bạn không thể sửa biến động hộ chờ tạo hoặc biến động không tạo',
                        'error', function () {
                            // lib.reload();
                        });
                }else {
                    lib.showMessage('Bạn chưa chọn hộ biến động để sửa',
                        'error', function () {
                            // lib.reload();
                        });
                }
                break;
            case 'xoa':
                var arrHouseHoldId = [];
                var arrReceiveHouseHoldId = [];
                var arrhouseHoldName = [];
                for (var i = 0; i < listArrayRowSel.length; i++) {
                    if (arrHouseHoldId.indexOf(listArrayRowSel[i].houseHoldId) < 0 && listArrayRowSel[i].receiveStatus == KEY_DA_TAO_BIEN_DONG) {
                        arrHouseHoldId.push(listArrayRowSel[i].houseHoldId);
                        arrhouseHoldName.push(listArrayRowSel[i].houseHoldName);
                    }else if (arrReceiveHouseHoldId.indexOf(listArrayRowSel[i].houseHoldId) < 0 && listArrayRowSel[i].receiveStatus != KEY_DA_TAO_BIEN_DONG) {
                        arrReceiveHouseHoldId.push(listArrayRowSel[i].houseHoldId);
                    }
                }
                // arrHouseHoldId = arrHouseHoldId.join('```');
                arrhouseHoldName = arrhouseHoldName.join(', ');
                if (listArrayRowSel.length > 0 && arrHouseHoldId.length > 0 && arrReceiveHouseHoldId.length == 0) {
                    formDialogCrud('xoa', arrHouseHoldId, false, arrhouseHoldName);
                } else if (arrHouseHoldId.length == 0 && arrReceiveHouseHoldId.length > 0) {
                    lib.showMessage('Bạn không thể xóa biến động hộ chờ tạo hoặc biến động không tạo',
                        'error', function () {
                        });
                }else {
                    lib.showMessage('Bạn chưa chọn biến động hộ để xóa',
                        'error', function () {
                        });
                }
                break;
            case 'capnhatngayve':
                if (listArrayRowSel.length > 1) {
                    lib.showMessage('Chỉ được phép chọn một hộ biến động để câp nhật về sớm.',
                        'error', function () {
                            // lib.reload();
                        });
                } else if (listArrayRowSel.length == 1 && listArrayRowSel[0].receiveStatus == KEY_DA_TAO_BIEN_DONG) {
                    var id = listArrayRowSel[0].houseHoldId;
                    var movingStatus = listArrayRowSel[0].movingStatus;
                    if (id != null && movingStatus == "2") { //chưa trở vê
                        formDialogCrud('capnhatngayve', id, false, {movingToDate: listArrayRowSel[0].movingToDate}, listArrayRowSel[0].receiveStatus);

                    } else if (id != null && movingStatus == "1") {//đã trở về
                        lib.showMessage('Hộ có biến động cư trú đã trở về nơi thường trú',
                            'error', function () {
                            });
                    }
                } else if (listArrayRowSel.length == 1 && listArrayRowSel[0].receiveStatus != KEY_DA_TAO_BIEN_DONG) {
                    lib.showMessage('Không thể cập nhật về sớm cho biến động hộ chờ tạo hoặc biến động không tạo',
                        'error', function () {
                        });
                }else {
                    lib.showMessage('Bạn chưa chọn hộ để cập nhật về sớm',
                        'error', function () {
                        });
                }
                break;
            case 'dong':
                $(formId).hideDialog();
                $(formId).resetValidation();
                break;
        }
    }

    /*
        * DUCNV bổ sung hàm thao tác nhanh trên table
        */
    function quickActions(action, id, data, movingToDate = null, receiveStatus) {
        actionDialog = action;
        switch (action) {
            case 'xem':
                formDialogCrud('xem', id, false, data, receiveStatus);
                break;
            case 'sua':
                $(formId).resetValidation();
                formDialogCrud('sua', id, false, data, receiveStatus);
                break;
            case 'xoa':
                formDialogCrud('xoa', id, false, data, receiveStatus, KEY_CHECK_HK15);
                break;
            case 'capnhatngayve':
                if (parseInt(data) == 2) { //chưa trở vê
                    formDialogCrud('capnhatngayve', id, false, {movingToDate: movingToDate}, receiveStatus);
                } else if (parseInt(data) == 1) {//đã trở về
                    lib.showMessage('Hộ có biến động cư trú đã trở về nơi thường trú',
                        'error', null);
                }
                break;
            case 'tiepnhan':
                $(formId).resetValidation();
                if (receiveStatus == KEY_CHO_TAO_BIEN_DONG){
                    formDialogCrud('tiepnhan', id, false, data, receiveStatus);
                }else {
                    lib.showMessage('Bạn không thể chọn biến động không tạo để tiếp nhận',
                        'error', function () {
                            // lib.reload();
                        });
                }

                break;
        }
    }

    function getRowCheckSelect(ref) {
        var listIdHouseHold = [];
        var selected = $(document).find('input:checkbox[ref="' + ref + '"]:checked');
        if (selected.length > 1) {
            for (var i = 0; i < selected.length; i++) {
                var element = selected.eq(i);
                var objRow = {};
                if (element.is(":checked")) {
                    objRow.houseHoldId = element.attr('houseHoldId');
                    objRow.receiveStatus = element.attr('receiveStatus');
                    objRow.houseHoldName = element.attr('houseHoldName');
                }
                listIdHouseHold.push(objRow);
            }
        } else if (selected.length == 1) {
            var element = selected.eq(0);
            if (element.is(":checked")) {
                var objRow = {};
                objRow.houseHoldId = element.attr('houseHoldId');
                objRow.receiveStatus = element.attr('receiveStatus');
                objRow.sourceData = element.attr('sourceData');
                objRow.houseHoldResId = element.attr('houseHoldResId');
                objRow.hhRegBookProfNumber = element.attr('hhRegBookProfNumber');
                objRow.houseHoldName = element.attr('houseHoldName');
                objRow.movingFromDate = element.attr('movingFromDate');
                objRow.movingToDate = element.attr('movingToDate');
                objRow.compareToDate = element.attr('compareToDate');
                objRow.movingStatus = element.attr('movingStatus');
            }
            listIdHouseHold.push(objRow);
        }
        return listIdHouseHold;
    }

    // ducnv bo sung ui/ux
    function refeshQuickSearch() {
        $(quickSearchId).pathValue({
            soHoSoCuTru: '',
            hoTenChuHo: '',
            timChinhXacTenChuHo: false,
            cmndChuHo: '',
            movingStatus: 0,
            sourceData: "-1",
            statusReceive: 3
        });

        $(advSearchId).pathValue({
            cmndThanhVien: "",
            diaChiThuongTru: "",
            hoTenThanhVien: "",
            khongRoNoiCuTru: false,
            movingFromDate: "",
            movingToDate: "",
            movingType: "0",
            ngaySinhChuHoDenNgay: "",
            ngaySinhChuHoTuNgay: "",
            ngaySinhThanhVienDenNgay: "",
            ngaySinhThanhVienTuNgay: "",
            ngoaiNuocDiaChi: "",
            regPlaceCityId: null,
            regPlaceCountryId: "0",
            regPlaceDistrictId: null,
            regPlaceVillageId: null,
            timChinhXacTenThanhVien: false,
            trongNuocDiaChi: "",
            movingStatus: 0,
            sourceData: "-1",
            statusReceive: 3
        });

        $(quickSearchId).disableControlValue({
            movingStatus: false,
            //statusReceive: true
        });

        $(advSearchId).disableControlValue({
            //movingStatus: false,
        });
    }

    function refeshAddvanceSearch() {
        $(advSearchId).pathValue({
            cmndChuHo: "",
            cmndThanhVien: "",
            diaChiThuongTru: "",
            hoTenChuHo: "",
            hoTenThanhVien: "",
            khongRoNoiCuTru: false,
            movingFromDate: "",
            movingStatus: "0",
            movingToDate: "",
            movingType: "0",
            ngaySinhChuHoDenNgay: "",
            ngaySinhChuHoTuNgay: "",
            ngaySinhThanhVienDenNgay: "",
            ngaySinhThanhVienTuNgay: "",
            ngoaiNuocDiaChi: "",
            regPlaceCityId: null,
            regPlaceCountryId: "0",
            regPlaceDistrictId: null,
            regPlaceVillageId: null,
            soHoSoCuTru: "",
            timChinhXacTenChuHo: false,
            timChinhXacTenThanhVien: false,
            trongNuocDiaChi: "",
            sourceData: "-1",
            statusReceive: 3
        });

        $(quickSearchId).disableControlValue({
            movingStatus: false,
            //statusReceive: true
        });

        $(advSearchId).disableControlValue({
            movingStatus: false,
            //statusReceive: true
        });
    }

    function tiepNhanHangLoatBienDongHoNhap(arrCHGHouseHoldId, HK15){
        var jsonData = {
            arrCHGHouseHoldId: arrCHGHouseHoldId,
            RPT_HK15: HK15,
            receiveStatus: KEY_CHO_TAO_BIEN_DONG,
        };

        lib.post({
            url: $("#PageContext").val() + urlTiepNhanHangLoat,
            data: JSON.stringify(jsonData),
            beforePost: function () {
                $(document).uiLoading(true);
            },
            complete: function (response) {
                $(formId).uiLoading(false);
                if (parseInt(response.responseJSON.lstBienDongDaTao.length) > 0 && parseInt(response.responseJSON.lstBienDongKhongTao.length) == 0){
                    lib.showMessage('Tiếp nhận biến động chờ tạo thành công', 'success',
                        function () {
                            traCuuDanhSachHoBienDong('traCuuBienDong');
                        });
                }else if (parseInt(response.responseJSON.lstBienDongDaTao.length) > 0 && parseInt(response.responseJSON.lstBienDongKhongTao.length) > 0){
                    lib.showMessage('' + response.responseJSON.responseMessage + '', 'error',
                        function () {
                            traCuuDanhSachHoBienDong('traCuuBienDong');
                        });
                }
            },
            error: function (ex) {
                $(formId).bindError(ex);
                $(formId).uiLoading(false);
                if (parseInt(ex.responseJSON.lstBienDongKhongTao.length) > 0){
                    lib.showMessage('' + ex.responseJSON.responseMessage + '',
                        'error', function () {
                        });
                }
            }
        });
    }

    $(function () {
        console.log('include file success!');
    })
</script>