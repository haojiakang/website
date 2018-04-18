<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta charset="utf-8"/>
    <link href="css/toastr.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/templatemo-style.css" rel="stylesheet">
    <link href="css/alertify.css" rel="stylesheet">
    <link href="css/themes/bootstrap.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,400italic,700' rel='stylesheet' type='text/css'>

    <script type="text/javascript" src="<%=basePath%>js/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery-migrate-1.2.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-filestyle.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/toastr.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/alertify.js"></script>
</head>
<body>
<div>
    <!-- Left column -->
    <div class="templatemo-flex-row">
        <!--menu-->
        <jsp:include page="header.jsp"/>
        <!-- Main content -->
        <div class="templatemo-content col-1 light-gray-bg">
            <div class="templatemo-content-container">
                <div class="templatemo-content-widget no-padding">
                    <div class="panel panel-default table-responsive">
                        <table class="table table-striped table-bordered templatemo-user-table">
                            <thead>
                            <tr>
                                <td>物料</td>
                                <td>大类</td>
                                <td>子类</td>
                                <td>走VIP白名单</td>
                                <td>名单详情</td>
                                <td>最小尾号</td>
                                <td>最大尾号</td>
                                <td>是否丢弃</td>
                            </tr>
                            </thead>
                            <tbody id="tableBody"></tbody>
                        </table>
                    </div>
                </div>
                <div class="templatemo-flex-row flex-content-row">
                    <div class="col-1">
                        <div class="row form-group">
                            <div class="col-lg-6 col-md-6 form-group">
                                <div class="pagination-wrap-left">
                                    <ul class="pagination">
                                        <%--<button type="button" class="templatemo-blue-button" onclick='syncConfig()'>同步</button>--%>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 form-group">
                                <div class="pagination-wrap">
                                    <ul class="pagination" id="ulPage"></ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="templatemo-flex-row flex-content-row">
                    <div class="col-1">
                        <div class="panel panel-default margin-10">
                            <div class="panel-heading"><h2 class="text-uppercase">详情</h2></div>
                            <div class="panel-body">
                                <form method="post" class="templatemo-login-form" enctype="multipart/form-data" id="configForm">
                                    <div class="row form-group">
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label" for="inputName">物料名称(name)*</label>
                                            <input type="text" class="form-control" name="name" id="inputName" placeholder="物料名称">
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label for="inputmessageType">大类(messageType)*</label>
                                            <input type="text" class="form-control" name="messageType" placeholder="10" id="inputMessageType">
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label for="inputMessageSubType">子类(messageSubType)*</label>
                                            <input type="text" class="form-control" name="messageSubType" placeholder="10" id="inputMessageSubType">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label" for="inputTailNumMin">最小尾号(tailNumMin)*</label>
                                            <input type="text" class="form-control" name="tailNumMin" id="inputTailNumMin" placeholder="0">
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label for="inputTailNumMax">灰度最大尾号(tailNumMax)*</label>
                                            <input type="text" class="form-control" name="tailNumMax" id="inputTailNumMax" placeholder="100">
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">同级别排序权重(weightSort)</label>
                                            <select class="form-control" name="weightSort" id="selectWeightSort">
                                                <option value="6">评论(6)</option>
                                                <option value="5">提及(5)</option>
                                                <option value="4">转发(4)</option>
                                                <option value="3">赞(3)</option>
                                                <option value="2">被观看次数(2)</option>
                                                <option value="1" selected>间接物料(1)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">负反馈类型(blockType)</label>
                                            <select class="form-control" name="blockType" id="selectBlockType">
                                                <option value="mid">统一负反馈(mid)</option>
                                                <option value="oid">对象负反馈(oid)</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">屏蔽方式(blockStrategy)</label>
                                            <select class="form-control" name="blockStrategy" id="selectBlockStrategy">
                                                <option value="Unified" selected>统一负反馈(Unified)</option>
                                                <option value="Object">对象负反馈(Object)</option>
                                                <option value="Follow">关注人动态(Follow)</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">消息内容类型(messageContentType)</label>
                                            <select class="form-control" name="messageContentType" id="selectMessageContentType">
                                                <option value="" selected>间接物料(空串)</option>
                                                <option value="STATUS">微博(STATUS)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-lg-12 col-md-12 form-group">
                                            <label class="control-label" for="inputWildDataUrl">显示内容请求URL(wildDataUrl)*</label>
                                            <input type="text" class="form-control" name="wildDataUrl" id="inputWildDataUrl" placeholder="http://i.api.weibo.com/xxx">
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否丢弃物料(discard)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="discard" checked
                                                       id="radioDiscardYes" value="1">
                                                <label for="radioDiscardYes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="discard"
                                                       id="radioDiscardNo" value="0">
                                                <label for="radioDiscardNo"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否走VIP白名单(useVipWhiteList)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="useVipWhiteList" checked
                                                       id="radioUseVipWhiteListYes" value="1">
                                                <label for="radioUseVipWhiteListYes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="useVipWhiteList"
                                                       id="radioUseVipWhiteListNo" value="0">
                                                <label for="radioUseVipWhiteListNo"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否判断7天小于3条(filterDays7Count3)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="filterDays7Count3"
                                                       id="radioFilterDays7Count3Yes" value="1" checked>
                                                <label for="radioFilterDays7Count3Yes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="filterDays7Count3"
                                                       id="radioFilterDays7Count3No" value="0">
                                                <label for="radioFilterDays7Count3No"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row form-group">
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否过关注关系(filterFollowRelation)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="filterFollowRelation"
                                                       id="radioFilterFollowRelationYes" value="1">
                                                <label for="radioFilterFollowRelationYes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="filterFollowRelation"
                                                       id="radioFilterFollowRelationNo" value="0" checked>
                                                <label for="radioFilterFollowRelationNo"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否按关注人加未读(followUnread)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="followUnread" id="radioFollowUnreadYes"
                                                       value="1" checked>
                                                <label for="radioFollowUnreadYes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="followUnread" id="radioFollowUnreadNo"
                                                       value="0">
                                                <label for="radioFollowUnreadNo"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否保存筛选项(saveFilterCard)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="saveFilterCard"
                                                       id="radioSaveFilterCardYes" value="1">
                                                <label for="radioSaveFilterCardYes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="saveFilterCard" checked
                                                       id="radioSaveFilterCardNo" value="0">
                                                <label for="radioSaveFilterCardNo"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="row form-group">
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否需要PUSH(push)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="push" id="radioPushYes"
                                                       value="1" checked>
                                                <label for="radioPushYes" class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="push" id="radioPushNo"
                                                       value="0">
                                                <label for="radioPushNo" class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否走通用Card(wildType)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="wildType" id="radioWildTypeYes" value="1"
                                                       checked>
                                                <label for="radioWildTypeYes"
                                                       class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="wildType" id="radioWildTypeNo" value="0">
                                                <label for="radioWildTypeNo"
                                                       class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-4 form-group">
                                            <label class="control-label templatemo-block">是否需要合流组装内容(buildWildData)</label>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="buildWildData" id="radioBuildWildDataYes"
                                                       value="1">
                                                <label for="radioBuildWildDataYes" class="font-weight-400"><span></span>是</label>
                                            </div>
                                            <div class="margin-right-15 templatemo-inline-block">
                                                <input type="radio" name="buildWildData" id="radioBuildWildDataNo"
                                                       value="0" checked>
                                                <label for="radioBuildWildDataNo" class="font-weight-400"><span></span>否</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row form-group">
                                        <div class="col-lg-3 col-md-3 form-group" id = "DivBlackList">
                                            <label class="control-label templatemo-block">黑名单(一行一个uid)</label>
                                            <input type="file" name="blackFile" id="blackList" class="filestyle"
                                                   data-buttonName="btn-primary" data-buttonBefore="true"
                                                   data-icon="false">
                                        </div>
                                        <div class="col-lg-3 col-md-3 form-group" id = "DivVipWhiteList">
                                            <label class="control-label templatemo-block">VIP白名单(一行一个uid)</label>
                                            <input type="file" name="vipWhiteFile" id="vipWhiteList" class="filestyle"
                                                   data-buttonName="btn-primary" data-buttonBefore="true"
                                                   data-icon="false">
                                        </div>
                                        <div class="col-lg-3 col-md-3 form-group">
                                            <label class="control-label" for="inputCreateTime">创建时间(createTime)</label>
                                            <input type="hidden" class="form-control" name="createTime" id="inputCreateTime">
                                            <input type="text" class="form-control" id="inputCreateTimeShow" readonly>
                                        </div>
                                        <div class="col-lg-3 col-md-3 form-group">
                                            <label for="inputUpdateTime">修改时间(updateTime)</label>
                                            <input type="hidden" class="form-control" name="updateTime" id="inputUpdateTime">
                                            <input type="text" class="form-control" id="inputUpdateTimeShow" readonly>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-lg-12 form-group">
                                            <label class="control-label" for="inputContent">备注(content)</label>
                                            <textarea class="form-control" name="content" id="inputContent" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-lg-12 form-group">
                                            <label class="control-label" for="inputExtension">扩展字段(extension)</label>
                                            <textarea class="form-control" name="extension" id="inputExtension" rows="3"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group text-right">
                                        <input type="hidden" id="opType" value="add"/>
                                        <button type="button" class="templatemo-white-button" id="buttonClear">重置</button>
                                        <button type="button" class="templatemo-blue-button" id="buttonSubmit">保存</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=basePath%>js/material-config.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        initConfigContent();
    });
</script>
</body>
</html>
