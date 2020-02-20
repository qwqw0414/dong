<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<h1>내가바로 동네왕</h1>
<div id="kingOfDongnae">

</div>


<script>
$(()=>{

    listLoad(5,2020,1);

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
            },
            error:(a,b,c)=>{
                console.log(a,b,c);
            }
        });
    }
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>