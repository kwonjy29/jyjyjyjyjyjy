package mvc.clover;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("euc-kr");
		resp.setCharacterEncoding("euc-kr");
		
		String cmd = req.getParameter("command");
		String nextPage=null;
		System.out.println(cmd);
		
		if(cmd.equals("LOGIN")){
			nextPage = "";
		}
		else if(cmd.equals("MEM")){
			nextPage = "/main/regMember.jsp";			
		}
		else if(cmd.equals("MEMCONFIRM")){
			
			MemberDao dao = new MemberDao();
			dao.MemberInsert(setMember(req));
			
			nextPage = "";
		}
		
		RequestDispatcher view = req.getRequestDispatcher(nextPage);
		view.forward(req, resp);
	
	}
	
	public MemberDto setMember(HttpServletRequest req){
		MemberDto dto = new MemberDto();
		dto.setMem_birth(req.getParameter("year") + "_" + req.getParameter("month") + "_" + req.getParameter("day"));
		dto.setMem_email(req.getParameter("email"));
		dto.setMem_gender(req.getParameter("gender"));
		dto.setMem_id(req.getParameter("id"));
		dto.setMem_name(req.getParameter("name"));
		dto.setMem_pw(req.getParameter("pw"));

		return dto;
	}

}
