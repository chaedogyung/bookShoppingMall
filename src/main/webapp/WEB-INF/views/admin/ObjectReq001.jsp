<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<input type="hidden" id="hidInterlockId" />
<input type="hidden" id="hidInterlockHtml" />
<div class="mt-2 content-auto" id="divObjectReqList3">
<div class="mt-2 content-auto">
	<table class="table-type-view">
		<colgroup>
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:10%;">			
		</colgroup>
		<thead id="divObjectReqList2">
			<tr>
				<th class="center">Project 명</th>
				<th class="center">Project 코드</th>
				<th class="center">계</th>
			</tr>
		</thead>
		
		<tbody>

		</tbody>
	</table>
</div>
<div id="btnAreaB" class="btn-area mb-1" style="display: flex; flex: 1 1 0px; justify-content: flex-end;">
	<button id="btnAdd" class="btn btn-sm btn-outline-light"  type="button" onclick="addObjectReqDetail()">
		<span>추가</span>
	</button>
	<button id="btnApprovalDeleteRow" type="button" class="btn btn-sm btn-outline-light " onclick="delRow(this)">
		<span>선택항목삭제</span>
	</button>
</div>
<div class="mt-2 content-auto">
	<table class="table-type-view" >
	<colgroup>
			<col style="width:5%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:10%;">
			<col style="width:10%;">			
	</colgroup>
	<thead id="divObjectReqList">
		<tr>
			<th class="center">
				<div class="list-checkbox" class="list-checkbox">
					<div class="custom-checkbox">
					<input type="checkbox" id="allCheck" onclick="checkboxAll()"/>
					</div>
				</div>
			</th>
			<th class="center">품명</th>
			<th class="center">단가</th>
			<th class="center">수량</th>
			<th class="center">금액</th>
			<th class="center">비고</th>
		</tr>
	</thead>
	<tbody id="c_hda_business_card_req_d">

	</tbody>
	<tbody>
	<tr>
		<th class="center" colspan=4>계</th>
		<td class="center"><input type="text" class="form-control" id="bf_sum" name="bf_sum" style="text-align:right"  readonly></td>
		<th class="center"></th>
	</tr>
	<tr>
		<th class="center" colspan=4>할인</th>
		<td class="center">
		<div id="divReqCnt" class="input-group-date date" style="cursor: pointer; text-align:right">
			<input class="form-control numeric" type="text" name="sale" id="sale" required="" style="text-align:right;" onkeyup="ShowPrice()"/>
			<div class="input-group-addon" style="padding:2px 5px;">
				<span>원</span>
			</div>
		</div>
		</td>
		<th class="center"></th>
	</tr>
	<tr>
		<th class="center" colspan=4>합계</th>
		<td class="center"><input type="text" class="form-control" id="af_sum" style="text-align:right" readonly></td>
		<th class="center"></th>
	</tr>	
	</tbody>
	</table>
</div>
</div>
※ 물품 신청시 유의사항<br>
1. 구매 물품 중 본사 일괄구매 및 지급 제외 대상은 예고없이 삭제 또는 수량조절 될 수 있음<br>
2. 담당자에게 사전 승인되지 않은 선구매 물품은 결재대상에서 제외될 수 있음<br>
3. 대상물품 견적서는 반드시 첨부 해야하며, 미첨부시 의견란에 간단한 사유작성 할 것<br>
4. 여러 품목 입력 시 표상단 추가버튼 클릭<br>
5. 품목별 금액은 단가 및 수량 입력시 자동계산<br>
6. 위임전결 규정에 따른 결재선 지정 / 전자서명 미등록시 반송될 수 있음<br>

- 담당자 : 인사총무팀 윤송이 매니저 TEL 6640 / E-mail sonata@hda.co.kr
<script type="text/javascript">
var dataList = new Array();
$(function() {
	initAction();
	initControl();

});

function initControl() {
  		$('#txtDocSubject').val('물품신청서(일반)');
 		if ('${interlock_id}' != '' && '${interlock_id}' != '0') {
            $('#hidInterlockId').val('${interlock_id}');
		selectObjectReqList();
		selectObjectReqInfo();
    }
}

function initAction() {
	if ('${interlock_id}' == '' || '${interlock_id}' == '0') {
		$('#btnAdd').click();
		
	}
	var html2 = '<tr>' +
					'<td class="center"><input id="projtect_nm" type="text" class="form-control" style="text-align:left" /></td>' +
					'<td class="center"><input id="projtect_code" type="text" class="form-control" style="text-align:left" /></td>' +
					'<td class="center">' +
						'<div id="divAf_sum1" class="input-group-date date" style="cursor: pointer; text-align:right">'+
							 '<input class="form-control" type="text" name="af_sum1" id="af_sum1" required="" style="text-align:right;" value="0" readonly/>'+
							 '<div class="input-group-addon" style="padding:2px 5px;">'+ 
							 	'<span>원</span>'+
							 '</div>'+ 
						'</div>'+
					'</td>' +
				'</tr>';		
	$('#divObjectReqList2').next().append(html2);
	$('.numeric').inputmask('numeric', {
		allowMinus: false
	});
}

function selectObjectReqList() {
	var param = {};
	param.req_seq = $('#hidInterlockId').val();
	
	$.simpleAjax({
        url: "/Customizing/Hda/Approval/selectObjectReqList", 
        data: param,
        async: false, 
        error: function (err) {
        	console.log(err);
        	swal(err);
        },
        success: function (res) {
   	    
        	selectObjectReqListBind(res);
        }
	});
	
} 

function selectObjectReqListBind(data) {
	$.each(data.lmDetail, function(j, k) {
		addObjectReqDetail();
	});
	$('#divObjectReqList').next().find('tr').each(function(i, t) {
		$.each(data.lmDetail, function(j, k) {
			if (i == j) {
				$(t).find('#goods_nm').val(k.goods_nm);
				$(t).find('#price').val(k.price);
				$(t).find('#req_cnt').val(k.req_cnt);
				$(t).find('#amount').val(k.amount);
				$(t).find('#remark').val(k.remark);
			}
		})
	})
}


function selectObjectReqInfo() {
	var param = {};
	param.req_seq = $('#hidInterlockId').val();
	
	$.simpleAjax({
        url: "/Customizing/Hda/Approval/selectObjectReqInfo", 
        data: param,
        async: false, 
        error: function (err) {
        	console.log(err);
        	swal(err);
        },
        success: function (res) {
    		$('#projtect_code').val(res.projtect_code);
    		$('#projtect_nm').val(res.projtect_nm);
    		$('#bf_sum').val(res.bf_sum);
    		$('#sale').val(res.sale);
    		$('#af_sum1').val(res.af_sum);
    		$('#af_sum').val(res.af_sum);
        }
	});
	
} 

var count=0;

function addObjectReqDetail() {
	   count=count+1;
	var html = '<tr onkeyup="amount(this)">' +
					'<td class="center"><input id="object_chk" type="checkbox" name="object_chk"></td>' +
					'<td class="center"><input id="goods_nm" type="text" name="goods_nm" class="form-control" style="text-align:left" /></td>' +
// 					'<td class="center"><input id="price" type="text" name="price" value="0" class="form-control numeric" style="text-align:right"/></td>' +
					'<td class="center">' +
						'<div id="divPrice" class="input-group-date date" style="cursor: pointer; text-align:right">'+
						 '<input class="form-control numeric" type="text" name="price" id="price" required="" style="text-align:right;" value="0"/>'+
						 '<div class="input-group-addon" style="padding:2px 5px;">'+ 
						 	'<span>원</span>'+
						 '</div>'+ 
						'</div>'+
					'</td>' +
					
// 					'<td class="center"><input id="req_cnt" type="text" name="req_cnt" value="0" class="form-control numeric" style="text-align:right" /></td>' +
					'<td class="center">' +
						'<div id="divReqCnt" class="input-group-date date" style="cursor: pointer; text-align:right">'+
						 '<input class="form-control numeric" type="text" name="req_cnt" id="req_cnt" required="" style="text-align:right;" value="0"/>'+
						 '<div class="input-group-addon" style="padding:2px 5px;">'+ 
						 	'<span>개</span>'+
						 '</div>'+ 
						'</div>'+
					'</td>' +
					
// 					'<td class="center"><input id="amount" type="text" name="amount'+count+'" value="0" class="form-control" readonly style="text-align:right"/></td>' +
					'<td class="center">' +
						'<div id="divAmount" class="input-group-date date" style="cursor: pointer; text-align:right">'+
						 '<input class="form-control" type="text" name="amount" id="amount" required="" value="0" style="text-align:right; readonly"/>'+
						 '<div class="input-group-addon" style="padding:2px 5px;">'+ 
						 	'<span>원</span>'+
						 '</div>'+ 
						'</div>'+
					'</td>' +
					'<td class="center"><input id="remark" type="text" name="remark" class="form-control" style="text-align:left"/></td>' +
				'</tr>';	

	$('#divObjectReqList').next().append(html);
	$('.numeric').inputmask('numeric', {
		allowMinus: false
	});
};		


function saveInterlockApp() {

	var is_return = false;
	if ($('#goods_nm').val() == null || $('#goods_nm').val() == '') {
		swal('품명을 입력하여 주십시오');
		return false;
	}
	
	if ($('#price').val() == null || $('#price').val() == '') {
		swal('단가를 입력하여 주십시오');
		return false;
	}

	if ($('#req_cnt').val() == null || $('#req_cnt').val() == '') {
		swal('수량를 입력하여 주십시오');
		return false;
	}
	
	if ($('#amount').val() == null || $('#amount').val() == '') {
		swal('금액을 입력하여 주십시오');
		return false;
	}
	
	if ($('#projtect_nm').val() == null || $('#projtect_nm').val() == '') {
		swal('프로젝트 이름을 입력하여 주십시오');
		return false;
	}
	
	if ($('#projtect_code').val() == null || $('#projtect_code').val() == '') {
		swal('프로젝트 코드를 입력하여 주십시오');
		return false;
	}	
	
	if ($('#af_sum').val() == null || $('#af_sum').val() == '') {
		swal('금액을 입력하여 주십시오');
		return false;
	}		
	
	if ($('#sale').val() == null || $('#sale').val() == '') {
		swal('할인금액을 입력하여 주십시오');
		return false;
	}	
	
	
	var param = {};
	param.emp_id = '${loginEmpID}';
	
	param.goods_nm = $('#goods_nm').val();
	param.price = $('#price').val();
	param.req_cnt = $('#req_cnt').val();
	param.amount = $('#amount').val();
	param.remark = $('#remark').val();
	param.projtect_nm = $('#projtect_nm').val();
	param.projtect_code = $('#projtect_code').val();
	param.sale = $('#sale').val();
	param.af_sum = $('#af_sum').val();
	param.bf_sum = $('#bf_sum').val();
	
	$('#divObjectReqList').next().find('tr').each(function(i, t) {

		var data = {};
		var reqDseq = 0;
		reqDseq = parseInt(i) + 1;
		data.req_d_seq = reqDseq;
	
		data.goods_nm = $(t).find('#goods_nm').val();
		data.price = $(t).find('#price').val();
		data.amount = $(t).find('#amount').val();
		data.sale = $(t).find('#sale').val();
		data.req_cnt = $(t).find('#req_cnt').val();
		data.remark = $(t).find('#remark').val();
		data.projtect_nm = $('#projtect_nm').val();
		data.projtect_code = $('#projtect_code').val();
		data.af_sum = $('#af_sum').val();
		data.bf_sum = $('#bf_sum').val();
		dataList.push(data);
	});	
	param.detailArray = JSON.stringify(dataList);
	
	param.interlock_id = $('#hidInterlockId').val();

	$.simpleAjax({
         url: "/Customizing/Hda/Approval/saveObjectReq", 
         data: param,
         async: false, 
         error: function (res) {
         	console.log(res);
         	swal("error : " + res.responseText);
         },
         success: function (res) {
        	 if (!res.issucess) {
                is_return = false;
            } else {
            	is_return = true;
                $('#hidInterlockId').val(res.return_id);
                $('#hidInterlockHtml').val(res.return_html);
            }
         }
	}); 
	
	return is_return;
}

function checkboxAll() {
   if($('#allCheck').is(':checked')){ 
	   $('input[name=object_chk]').prop("checked",true);
       
   }else{ 
	   $('input[name=object_chk]').prop("checked",false); 
   } 
};

function delRow(){debugger;
	var table = document.getElementById("c_hda_business_card_req_d");
	var rowCnt = table.rows.length;
	for(var i = 0; i < rowCnt; i++){
		var row = table.rows[i];
		var chkBox = row.cells[0].childNodes[0];
		if(chkBox != null && chkBox.checked == true){
			table.deleteRow(i);
			rowCnt--;
			i--;
		}
	
	}
	doSum();
	ShowPrice();
}

function amount(obj){
	var tr = $(obj)
	tr.find('#amount').val(Number(tr.find('#price').val()) * Number(tr.find('#req_cnt').val()));
	doSum(this);
	ShowPrice();
};

function doSum(){
    let sum = 0;
    $('input[name*="amount"]').each(function(){
    sum += parseInt($(this).val());
 	});
    
    $("input[name=bf_sum]").val(sum);
    $("#af_sum").val(sum);
    $("#af_sum1").val(sum);
}

function ShowPrice(){
	var originPrice = $("#bf_sum").val();
	var salePrice = $("#sale").val();
	var savePrice = originPrice - salePrice;
	
	$("#af_sum1").val(savePrice);
	$("#af_sum").val(savePrice);
} 
</script>