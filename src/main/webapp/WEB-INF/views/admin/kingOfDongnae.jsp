<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
</style>

<div id="kingOfDongnae">

    <h1><span id="isMonth"></span>월 동네왕</h1>
    <div id="rank">
        <ol>
    
        </ol>
    </div>

</div>


<script>
$(()=>{

    listLoad(3,2020,1);

    function listLoad(rank,year,month){

        $.ajax({
            url:"${pageContext.request.contextPath}/research/selectTop",
            data:{
                rank:rank,
                year:year,
                month:month
            },
            dataType:"json",
            success:data=>{

                console.log(data);

                let html = '';
                data.addr.forEach(list => {
                    html += '<li>';
                    html += list.SIDO +' '+ list.SIGUNGU +' '+ list.DONG;
                    html += ' ('+list.CNT+'/'+list.ALL_CNT+' '+list.AVG+'%)'
                    html += '</li>'
                });

                $("#kingOfDongnae #rank ol").html(html);
                $("#kingOfDongnae #isMonth").text(month);
            },
            error:(a,b,c)=>{
                console.log(a,b,c);
            }
        });
    }
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>