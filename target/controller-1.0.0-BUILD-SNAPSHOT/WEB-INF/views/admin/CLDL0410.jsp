<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/goodsEnroll.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
 <script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
 <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	.form_section_content{
	padding: 20px 35px;
	margin-bottom: 20px;
	}
	.text_form{
	text-align: right; 
	width: 50%;
    float: right;"
	}
	
</style>
</head>
<body>
	<ul>
        <li id="1">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>2222-2222-2222</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">010-5555-5555</span>
                        <span class="telText">010-5555-5555</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        <li id="2">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>3332-2222-2222</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">010-5555-5555</span>
                        <span class="telText">010-5555-5555</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        <li id="3">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>3332-2444-2222</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">010-5555-5555</span>
                        <span class="telText">010-5555-5555</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        <li id="4">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>6666-2433-2222</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">입력해주세요</span>
                        <span class="telText">입력해주세요</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        <li id="5">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>7777-2433-2222</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">입력해주세요</span>
                        <span class="telText">입력해주세요</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        <li id="6">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>1111-5555-6666</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">6666-6666-6666</span>
                        <span class="telText">6666-6666-6666</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        <li id="7">
            <div class="item">
                <div class="phon">
                    <button id="inv_no" class="btn phonNum">
                        <em>송장번호</em>
                        <span>8888-8888-9999</span>
                    </button>
                    <button id="tel_num" class="btn phonNum">
                        <em>전화번호</em>
                        <span class="telText1">6666-6666-6666</span>
                        <span class="telText">6666-6666-6666</span>
                    </button>
                    <button class="btn del2">삭제</button>
                </div>
            </div>
        </li>
        
        
        
        
    </ul>    
</body>
<script type="text/javascript">

$(".telText").each(function() {debugger;
var rows = $(".telText:contains('" + $(this).text() + "')");
if (rows.length > 1) {
	var addTel = rows.eq(0).attr("rowspan", rows.length);

	var hide =  rows.not(":eq(0)").parent().parent().parent().hide();
	var length = hide.length;
	const json =JSON.stringify("외"+length+"건");
	rows.eq(0).text(json);

// 	new Set(rows.eq(0).text()); 	

};

});

// $(".telText").each(function() {debugger;
// var rows = $(".telText:contains('" + $(this).text() + "')");
// if (rows.length > 1) {
// 	var addTel = rows.eq(0).attr("rowspan", rows.length);

// 	var hide =  rows.not(":eq(0)").parent().parent().parent().hide();
// 	var length = hide.length;
// 	console.log("length"+ length)
// 	console.log("rows.eq(0)  "+ rows.eq(0).text());
// 	const json =JSON.stringify("외"+length+"건");
// 	const sss = rows.eq(0).text(rows.eq(0).text() + json);
// 	const set = new Set();
// 	set.add(json);


// };
// });
</script>
</html>