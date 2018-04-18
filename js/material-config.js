var host = window.location.host;
var server = "http://" + host + "/materialconfig/";
var queryPageUrl = server + "queryPage.json";
var addUrl = server + "add.json";
var updateUrl = server + "update.json";
var publishUrl = server + "publish.json";

alertify.defaults.transition = "slide";
alertify.defaults.theme.ok = "btn btn-primary";
alertify.defaults.theme.cancel = "btn btn-danger";
alertify.defaults.theme.input = "form-control";

function initConfigContent() {
    if ($.browser.mozilla) {
        $(window).bind('resize', function (e) {
            if (window.RT) clearTimeout(window.RT);
            window.RT = setTimeout(function () {
                this.location.reload(false);
                /* false to get page from cache */
            }, 200);
        });
    }

    var imageUrl = $('img.content-bg-img').attr('src');
    $('.templatemo-content-img-bg').css('background-image', 'url(' + imageUrl + ')');
    $('img.content-bg-img').hide();

    queryData(1);
    bindEvent();
}

Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S": this.getMilliseconds()
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

/**
 * 绑定事件
 */
function bindEvent() {
    bindButtoClick();
}

function validate() {
    if ($("#inputName").val() == "") return false;
    if ($("#inputMessageType").val() == "") return false;
    if ($("#inputMessageSubType").val() == "") return false;
    if ($("#inputTailNumMin").val() == "") return false;
    if ($("#inputTailNumMax").val() == "") return false;
    return true;
}

/**
 * 按钮单击事件
 */
function bindButtoClick() {
    /**
     * 提交按钮
     */
    $("#buttonSubmit").click(function () {
        if (!validate()) {
            toastr.error("填写不完整!");
            return;
        }
        alertify.confirm("确认要保存吗?", function (e) {
            if (e) {
                if ($("#inputCreateTimeShow").val() == "") $("#inputCreateTime").val("0");
                if ($("#inputUpdateTimeShow").val("")) $("#inputUpdateTime").val("0");

                var url = ($("#opType").val() == "add" ? addUrl : updateUrl);
                var data = new FormData(document.getElementById("configForm"));
                $.ajax({
                    type: "post",
                    url: url,
                    data: data,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (resp) {
                        if (resp.success == true) {
                            //重新查询
                            queryData(1);
                            toastr.success("操作成功!");
                        } else {
                            toastr.error("url:" + url + " error:" + resp.error);
                        }
                    },
                    error: function (XMLHttpRequest) {
                        toastr.error("url:" + url + " error:" + XMLHttpRequest.readyState);
                    }
                });
            }
        }).setHeader("确认");
        return false;
    });

    /**
     * 重置按钮
     */
    $("#buttonClear").click(function () {
        resetValue();
    });
}

/**
 * 查询数据
 */
function queryData(page) {
    $.ajax({
        type: "get",
        async: false,
        url: queryPageUrl + "?page=" + page,
        success: function (resp) {
            if (resp.success == true) {
                $("#tableBody").html("");
                $.each(resp.data, function (i, v) {
                    var id = v.messageType + "_" + v.messageSubType;
                    var row = "<tr id=row_" + id + ">"
                    row += "<input type='hidden' id='name' value='" + v.name + "'>"
                    row += "<input type='hidden' id='messageType' value='" + v.messageType + "'>"
                    row += "<input type='hidden' id='messageSubType' value='" + v.messageSubType + "'>"
                    row += "<input type='hidden' id='followUnread' value='" + v.followUnread + "'>"
                    row += "<input type='hidden' id='wildType' value='" + v.wildType + "'>"
                    row += "<input type='hidden' id='buildWildData' value='" + v.buildWildData + "'>"
                    row += "<input type='hidden' id='filterDays7Count3' value='" + v.filterDays7Count3 + "'>"
                    row += "<input type='hidden' id='filterFollowRelation' value='" + v.filterFollowRelation + "'>"
                    row += "<input type='hidden' id='push' value='" + v.push + "'>"
                    row += "<input type='hidden' id='discard' value='" + v.discard + "'>"
                    row += "<input type='hidden' id='useVipWhiteList' value='" + v.useVipWhiteList + "'>"
                    row += "<input type='hidden' id='weightSort' value='" + v.weightSort + "'>"
                    row += "<input type='hidden' id='blockType' value='" + v.blockType + "'>"
                    row += "<input type='hidden' id='messageContentType' value='" + v.messageContentType + "'>"
                    row += "<input type='hidden' id='tailNumMin' value='" + v.tailNumMin + "'>"
                    row += "<input type='hidden' id='tailNumMax' value='" + v.tailNumMax + "'>"
                    row += "<input type='hidden' id='blockStrategy' value='" + v.blockStrategy + "'>"
                    row += "<input type='hidden' id='wildDataUrl' value='" + v.wildDataUrl + "'>"
                    row += "<input type='hidden' id='saveFilterCard' value='" + v.saveFilterCard + "'>"
                    row += "<input type='hidden' id='createTime' value='" + v.createTime + "'>"
                    row += "<input type='hidden' id='updateTime' value='" + v.updateTime + "'>"
                    row += "<input type='hidden' id='content' value='" + v.content + "'>"
                    row += "<input type='hidden' id='extension' value='" + v.extension + "'>"
                    row += "<td><a href='javascript:void(0);' onclick='showData(\"" + id + "\")'>" + v.name + "</a></td>"
                    row += "<td>" + v.messageType + "</td>"
                    row += "<td>" + v.messageSubType + "</td>"
                    var useVipWhiteList = v.useVipWhiteList ? "是" : "否"
                    row += "<td>" + useVipWhiteList + "</td>"
                    row += "<td><a href='/materialconfig/queryMaterialList.json?messageType=" + v.messageType + "&messageSubType=" + v.messageSubType + "' target='_blank'>查看</a></td>"
                    row += "<td>" + v.tailNumMin + "</td>"
                    row += "<td>" + v.tailNumMax + "</td>"
                    var discard = v.discard ? "是" : "否"
                    row += "<td>" + discard + "</td>"
                    row += "</tr>"

                    $("#tableBody").append(row);
                });

                $("#ulPage").html("");
                var pages = parseInt(resp.total_pages);
                for (var i = 0; i < pages; i++) {
                    var index = i + 1;
                    var li;
                    if (index == resp.current_page) {
                        li = "<li class='active'> <a href='#'>" + index + "<span class='sr-only'>(current)</span></a></li>"
                    } else {
                        li = "<li> <a href='javascript:void(0);' onclick='queryData(\"" + index + "\")'>" + index + "</a></li>"
                    }
                    $("#ulPage").append(li);
                }

                resetValue();
            } else {
                toastr.error(resp.error);
            }
        },
        error: function (XMLHttpRequest) {
            toastr.error("url:" + queryUrl + " error:" + XMLHttpRequest.readyState);
        }
    });
}

function syncConfig() {
    alertify.confirm("确认要同步吗？出问题后果很严重哟!", function (e) {
        if (e) {
            $.ajax({
                type: "get",
                async: false,
                url: publishUrl,
                success: function (resp) {
                    if (resp.success == true) {
                        toastr.success("操作成功!");
                    } else {
                        toastr.error(resp.error);
                    }
                },
                error: function (XMLHttpRequest) {
                    toastr.error("url:" + queryUrl + " error:" + XMLHttpRequest.readyState);
                }});
        }
    }).setHeader("确认");
    return false;
}

/**
 * 显示数据
 * @param id
 */
function showData(id) {
    setReadOnly(1);
    var row = $("#tableBody").find("tr[id='row_" + id + "']");

    $("#inputName").val($(row).find("input[id='name']").val());
    $("#inputMessageType").val($(row).find("input[id='messageType']").val());
    $("#inputMessageSubType").val($(row).find("input[id='messageSubType']").val());
    $("#inputTailNumMin").val($(row).find("input[id='tailNumMin']").val());
    $("#inputTailNumMax").val($(row).find("input[id='tailNumMax']").val());

    $("#selectWeightSort").find("option[value='" + $(row).find("input[id='weightSort']").val() + "']").attr("selected", true);
    $("#selectBlockType").find("option[value='" + $(row).find("input[id='blockType']").val() + "']").attr("selected", true);
    $("#selectBlockStrategy").find("option[value='" + $(row).find("input[id='blockStrategy']").val() + "']").attr("selected", true);
    $("#selectMessageContentType").find("option[value='" + $(row).find("input[id='messageContentType']").val() + "']").attr("selected", true);

    $("#inputWildDataUrl").val($(row).find("input[id='wildDataUrl']").val());

    $(row).find("input[id='followUnread']").val() == "true" ? $("#radioFollowUnreadYes").attr("checked", true) : $("#radioFollowUnreadNo").attr("checked", true);
    $(row).find("input[id='wildType']").val() == "true" ? $("#radioWildTypeYes").attr("checked", true) : $("#radioWildTypeNo").attr("checked", true);
    $(row).find("input[id='buildWildData']").val() == "true" ? $("#radioBuildWildDataYes").attr("checked", true) : $("#radioBuildWildDataNo").attr("checked", true);

    $(row).find("input[id='filterDays7Count3']").val() == "true" ? $("#radioFilterDays7Count3Yes").attr("checked", true) : $("#radioFilterDays7Count3No").attr("checked", true);
    $(row).find("input[id='filterFollowRelation']").val() == "true" ? $("#radioFilterFollowRelationYes").attr("checked", true) : $("#radioFilterFollowRelationNo").attr("checked", true);
    $(row).find("input[id='push']").val() == "true" ? $("#radioPushYes").attr("checked", true) : $("#radioPushNo").attr("checked", true);

    $(row).find("input[id='discard']").val() == "true" ? $("#radioDiscardYes").attr("checked", true) : $("#radioDiscardNo").attr("checked", true);
    $(row).find("input[id='saveFilterCard']").val() == "true" ? $("#radioSaveFilterCardYes").attr("checked", true) : $("#radioSaveFilterCardNo").attr("checked", true);
    $(row).find("input[id='useVipWhiteList']").val() == "true" ? $("#radioUseVipWhiteListYes").attr("checked", true) : $("#radioUseVipWhiteListNo").attr("checked", true);

    $("#inputContent").val($(row).find("input[id='content']").val());
    $("#inputExtension").val($(row).find("input[id='extension']").val());

    var createTime = new Date(parseInt($(row).find("input[id='createTime']").val())).Format("yyyy-MM-dd hh:mm:ss");
    $("#inputCreateTimeShow").val(createTime);
    $("#inputCreateTime").val($(row).find("input[id='createTime']").val());
    var updateTime = new Date(parseInt($(row).find("input[id='updateTime']").val())).Format("yyyy-MM-dd hh:mm:ss");
    $("#inputUpdateTimeShow").val(updateTime);
    $("#inputUpdateTime").val($(row).find("input[id='updateTime']").val());

    $("#vipWhiteList").parent().find("input[type='text']").val("");
    var whiteFile = document.getElementById('vipWhiteList');
    // obj.outerHTML = obj.outerHTML;
    whiteFile.value = '';
    $("#blackList").parent().find("input[type='text']").val("");
    var blackFile = document.getElementById('blackList');
    // obj.outerHTML = obj.outerHTML;
    blackFile.value = '';
}

function setReadOnly(flag) {
    if (flag == 1) {
        $("#opType").val("update");
        $("#inputMessageType").attr("readonly", "readonly");
        $("#inputMessageSubType").attr("readonly", "readonly");
    } else {
        $("#opType").val("add");
        $("#inputMessageType").removeAttr("readonly");
        $("#inputMessageSubType").removeAttr("readonly");
    }
}

function resetValue() {
    setReadOnly(0);

    $("#inputName").val("");
    $("#inputMessageType").val("");
    $("#inputMessageSubType").val("");
    $("#inputTailNumMin").val("");
    $("#inputTailNumMax").val("");

    $("#selectWeightSort").find("option[value='1']").attr("selected", true);
    $("#selectBlockType").find("option[value='mid']").attr("selected", true);
    $("#selectBlockStrategy").find("option[value='Unified']").attr("selected", true);
    $("#selectMessageContentType").find("option[value='CONFIG']").attr("selected", true);

    $("#inputWildDataUrl").val("");

    $("#radioFollowUnreadYes").attr("checked", true);
    $("#radioWildTypeYes").attr("checked", true);
    $("#radioBuildWildDataYes").attr("checked", false);

    $("#radioFilterDays7Count3Yes").attr("checked", true);
    $("#radioFilterFollowRelationNo").attr("checked", true);
    $("#radioPushYes").attr("checked", true);

    $("#radioDiscardNo").attr("checked", false);
    $("#radioUseVipWhiteListYes").attr("checked", true);

    $("#vipWhiteList").parent().find("input[type='text']").val("");
    var whiteFile = document.getElementById('vipWhiteList');
    // obj.outerHTML = obj.outerHTML;
    whiteFile.value = '';
    $("#blackList").parent().find("input[type='text']").val("");
    var blackFile = document.getElementById('blackList');
    // obj.outerHTML = obj.outerHTML;
    blackFile.value = '';

    $("#inputContent").val("");
    $("#inputExtension").val("");

    $("#inputCreateTimeShow").val("");
    $("#inputCreateTime").val("");
    $("#inputUpdateTimeShow").val("");
    $("#inputUpdateTime").val("");
}
