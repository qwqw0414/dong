package com.pro.dong.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.dong.board.model.vo.Attachment;
import com.pro.dong.member.model.vo.Member;
import com.pro.dong.product.model.vo.Category;
import com.pro.dong.product.model.vo.Like;
import com.pro.dong.product.model.vo.OrderList;
import com.pro.dong.product.model.vo.Product;
import com.pro.dong.product.model.vo.ProductAttachment;
import com.pro.dong.product.model.vo.ProductComment;
import com.pro.dong.shop.model.vo.Shop;

@Repository
public class ProductDAOImpl implements ProductDAO{

	@Autowired
	SqlSessionTemplate sst;
	
	//민호 시작 ==========================
	@Override
	public int submitPurchase(OrderList orderList) {
		return sst.insert("product.insertOrderList", orderList);
	}
	@Override
	public int updateMemberPoint(OrderList orderList) {
		return sst.insert("product.updateMemberPoint", orderList);
	}
	//==========================민호 끝
		
	//하진 시작 ==========================
	@Override
	public List<Map<String, String>> productStatus(Map<String, String> param) {
		return sst.selectList("product.productStatus",param);
	}
	@Override
	public int deleteProduct(int productNo) {
		return sst.delete("product.deleteProduct",productNo);
	}
	//========================== 하진 끝
		
	//근호 시작 ==========================

	//========================== 근호 끝
		
	//지은 시작 ==========================
	@Override
	public String selectShopMember(int productNo) {
		return sst.selectOne("product.selectShopMember", productNo);
	}

	//========================== 지은 끝
		
	//예찬 시작 ==========================
	@Override
	public List<Category> selectCategory(Category category) {
		return sst.selectList("product.selectCategory1", category);
	}
	@Override
	public Shop selectOneShop(String memberId) {
		return sst.selectOne("product.selectOneShop", memberId);
	}
	@Override
	public int insertProduct(Product product) {
		return sst.insert("product.insertProduct", product);
	}
	@Override
	public int insertAttachment(ProductAttachment pa) {
		return sst.insert("product.insertAttachment", pa);
	}
	@Override
	public List<Map<String, String>> selectProductListTop10(String categoryId) {

		RowBounds rowBounds = new RowBounds(0,10);
		return sst.selectList("product.selectProductListTop10", categoryId, rowBounds);
	}
	@Override
	public List<Map<String, String>> selectProduct(int cPage, int numPerPage, Map<String, String> param) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sst.selectList("product.selectProduct", param, rowBounds);
	}
	@Override
	public int countProduct(Map<String, String> param) {
		return sst.selectOne("product.countProduct", param);
	}
	@Override
	public Product selectOneProduct(int productNo) {
		return sst.selectOne("product.selectOneProduct", productNo);
	}
	@Override
	public List<ProductAttachment> selectAttachment(int productNo) {
		return sst.selectList("product.selectAttachment", productNo);
	}
	@Override
	public int countLike(Like like) {
		return sst.selectOne("product.countLike", like);
	}
	@Override
	public int insertLike(Like like) {
		return sst.insert("product.insertLike", like);
	}
	@Override
	public int deleteLike(Like like) {
		return sst.delete("product.deleteLike", like);
	}
	@Override
	public int insertStatus(Product product) {
		return sst.insert("product.insertStatus", product);
	}
	@Override
	public List<Map<String, String>> selectAd(Member member) {
		RowBounds rowBounds = new RowBounds(0, 5);
		return sst.selectList("product.selectAd", member,rowBounds);
	}
	//========================== 예찬 끝

	//주영 시작 ==========================
	@Override
	public List<Map<String, String>> loadProductReportCategory() {
		return sst.selectList("product.loadProductReportCategory");
	}	
	@Override
	public int insertProductReport(Map<String, String> param) {
		return sst.insert("product.insertProductReport", param);
	}
	@Override
	public List<Map<String, String>> selectProductByProductNo(int productNo) {
		return sst.selectList("product.selectProductByProductNo", productNo);
	}
	@Override
	public int delImg(String delImgName) {
		return sst.delete("product.delImg", delImgName);
	}
	@Override
	public int deleteOldImgName(Map<String, String> param) {
		return sst.delete("product.deleteOldImgName", param);
	}
	@Override
	public int insertNewImg(Map<String, String> param) {
		return sst.insert("product.insertNewImg", param);
	}
	@Override
	public int productUpdateEnd(Map<String, String> param) {
		return sst.update("product.productUpdateEnd", param);
	}
	//========================== 주영 끝
		
	//현규 시작 ==========================
	@Override
	public int insertProductComment(ProductComment pc) {
		return sst.insert("product.insertProductComment",pc);
	}
	@Override
	public List<Map<String, String>> selectProductCommentList(int productNo, int cPage, int numPerPage) {
		RowBounds rowBounds = new RowBounds((cPage-1)*numPerPage,numPerPage);
		return sst.selectList("product.selectProductCommentList", productNo, rowBounds);
	}
	@Override
	public int deleteLevel1(int commentNo) {
		return sst.delete("product.deleteLevel1",commentNo);
	}
	@Override
	public int countComment(int boardNo) {
		return sst.selectOne("product.countComment",boardNo);
	}
	@Override
	public int deleteLevel2(int commentNo) {
		return sst.delete("product.deleteLevel2",commentNo);
	}
	//========================== 현규 끝
}
