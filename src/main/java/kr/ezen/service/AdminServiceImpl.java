package kr.ezen.service;

import kr.ezen.bbs.domain.*;
import kr.ezen.bbs.mapper.AdminMapper;
import kr.ezen.bbs.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;
//dao 역할과 비슷하게 serviceImpl에서 프로그램 연결 역할

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminMapper mapper;

	@Autowired
	JavaMailSender mailSender;


	/*dto를 service로 넘김*/
	@Override
	public boolean adminLogin(AdminDTO dto, HttpServletRequest req) {
		//비번이 일치하는 경우 세션에 담음
		HttpSession session = req.getSession();
		//아이디와 일치하는 회원정보를 DTO에 담아서 가져옴
		AdminDTO adminLoginDTO = mapper.adminLogin(dto);

		if (adminLoginDTO != null) { //일치하는 아이디가 있는 경우
			//사용자가 입력한 비번과 db 비번이 일치하는지
			String inputPw = dto.getPassword();//사용자가 입력한 비번
			String dbPw = adminLoginDTO.getPassword(); //db에서 불러온 비번

			if (inputPw.equals(dbPw)) { //비번일치
				session.setAttribute("adminLoginDTO", adminLoginDTO);   //비번 일치시 세션에 저장
				return true;
			} else {  //비번 불일치
				return false;
			}
		}
		//로그인이 되면 세션 정보에 저장해야함
		//세션을 만드려면(HttpServlet 매개변수로 지정)
		return false;
	}

	@Override
	public int insertCategory(CategoryDTO cDto) {
		return mapper.insertCategory(cDto);
	}

	@Override
	public List<CategoryDTO> listCategory() {
		return mapper.listCategory();
	}

	@Override
	public int categoryRemove(int catNum) {
		return mapper.categoryDelete(catNum);
	}





	//dto는 자바객체를 담는 바구니
	//사진은 dto에 넣을수 없다.
	//MultipartHttpServletRequest 사진을 넣을수 있는 바구니
	//prodInput : view에서 사진을 서버(제공자)한테 업로드 요청
	//controller 가 이 요청을 받음(MultipartHttpServletRequest 사진을 넣음) -->service로 보냄
	//service는 받아온 데이터들을 DB에 넣어야 한다.
	//넣을때는 사진을 직접 넣을순 없다. 그래서 사진 파일은 server의 물리적 경로에 저장하고 DB에는 사진의 이름을 넣는다.
	//서비스에서는 사진의 이름을 MultipartHttpServletRequest에서 빼와서 map에 넣고 그 map을 DB에 전달한다.
	@Override
	public void prodInput(MultipartHttpServletRequest mhr) {
		// 파일 업로드 경로 설정
		String savePath = "resources/uploadedFile";
		String realPath = mhr.getServletContext().getRealPath(savePath); //getServletContext(서버의 물리적주소)
		//savepath에 설정해둔 위치를 넣으면 realpath가 자동으로 그 위치를 잡음
		System.out.println("~~~~~~~~~~~realPath = " + realPath);
		int maxSize = 1024 * 1024 * 10; // 1kb * 1kb = 1MB*10 = 10MB

		// 폼에서 전달된 데이터(사용자가 입력한 값)를 Map에 저장 :미리 객체 생성 아래,정보를 MAP에 저장!
		Map map = new HashMap();


		//업로드된 파일 처리
		//mhr 에서 getParameterNames(KEY)을 꺼내옴

		Enumeration<String> enu = mhr.getParameterNames();  //Enumeration :for문과 같은 역할
		while (enu.hasMoreElements()) {   //hasMoreElements :i++ 남은게 없을때까지 반복
			String paramName = enu.nextElement(); //getParameterNames의 key 값을 paramName으로 받겟다
			String paramValue = mhr.getParameter(paramName);  //paramName의 value 값을 받겟다.

			System.out.println(paramName + ":" + paramValue);
			map.put(paramName, paramValue);

		} //while

		// 파일
		Iterator<String> iter = mhr.getFileNames();  //iter :for문과 같은 역할
		//List<String> fileList = new ArrayList<String>();

		while (iter.hasNext()) {
			String fileParamName = iter.next();
			System.out.println("fileParamName : " + fileParamName);

			// MultipartFile 객체는 업로드된 파일의 정보를 가지고 있다
			MultipartFile mFile = mhr.getFile(fileParamName);
			//fileParamName :저장한 사진을 DB에 올리려면 pimg 라는 칼럼(mysql)에 넣기 때문에
			//pimg가 key가 됨
			// 원본 파일명
			String originName = mFile.getOriginalFilename();
			System.out.println("originName : " + originName);

			// 서버에 파일 생성 :realPath 이 경로에 fileParamName을 만들겟다.
			File file = new File(realPath + "\\" + fileParamName);

			// 파일이 업로드된 경우
			if (mFile.getSize() != 0) { // 업로드된 경우
				if (!file.exists()) { // 파일이 존재하지 않으면 최초로 한번만 실행
					if (file.getParentFile().mkdir()) { // savePath에 지정된 폴더(fileRepo) 생성//mkdir() 메소드를 사용하여 새 디렉토리를 생성
						try {
							// 디렉토리가 생성되면 새로운 임시 파일 생성
							file.createNewFile();
						} catch (IOException e) {
							// 이 메소드가 실패하면 IOException 예외가 발생합니다.
							e.printStackTrace();
						} // 임시파일 생성
					}//if
				}//if
				// 중복 파일명 처리
				File uploadFile = new File(realPath + "\\" + originName);

				// 중복시 파일명 대체
				if (uploadFile.exists()) {
					// 파일명에 현재 시간 추가
					originName = System.currentTimeMillis() + "_" + originName;
					uploadFile = new File(realPath + "\\" + originName);
				}   // if
				// 실제 파일 업로드하기
				try {   //사진이 없을경우 예외처리
					mFile.transferTo(uploadFile);
				} catch (IllegalStateException e) {

					e.printStackTrace();
				} catch (IOException e) {

					e.printStackTrace();
				}
				//fileList.add(originName);
			} //if
			// Map에 파일명 저장
			map.put("pimage", originName); //BD에 올릴때는 pimg라는 칼럼에 넣겟다.// fileParamName(key)
			//사진(pimg)이 key, 사진의 이름value :키값에 해당하는 value를 가져오는 방식
			// DB에 데이터 입력
			mapper.productInsert(map);
		}
	}

	@Override
	public List<ProductDTO> productList() {
		return mapper.productList();
	}

	@Override
	public int productModify(MultipartHttpServletRequest mhr) {
		System.out.println("상품수정 =====================");
		String savePath = "/resources/uploadedFile";

		String realPath = mhr.getServletContext().getRealPath(savePath);
		System.out.println("realPath = " + realPath);

		int maxsize = 1024*1024*10;

		Map map= new HashMap();

		Enumeration<String> enu = mhr.getParameterNames();

		while(enu.hasMoreElements()) {
			String paramName = enu.nextElement(); // 업로드 되는 파일의 이름
			String paramValue = mhr.getParameter(paramName); // 파일의 실제 이름

			// 이미지 수정시 처리 조건
			if(paramName.equals("pimageOld")) {
				paramName = "pimage";
			}

			System.out.println("~~~~~~~~~~~~~~ parameter output ~~~~~~~~~~");
			System.out.println(paramName + ":" + paramValue);

			// System.out.println(paramName + ":" + paramValue);
			map.put(paramName, paramValue); // 데이터를 map에 저장
		}

		Iterator<String> iter = mhr.getFileNames();
		while(iter.hasNext()) {
			String fileParamName = iter.next(); // 업로드된 파일의 이름
			System.out.println("fileParamName : " + fileParamName);


			MultipartFile mFile = mhr.getFile(fileParamName);
			String originName = mFile.getOriginalFilename();
			System.out.println("~~ originName : " + originName);


			File file = new File(realPath +"\\"+ fileParamName);

			if(mFile.getSize() !=0) {
				if (!file.exists()) { // 파일 존재여부 확인
					if (file.getParentFile().mkdir()) { // 파일의 디렉토리 생성
						try {
							file.createNewFile(); // 임시 파일 생성
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}

				File updateFile = new File(realPath + "\\" + originName);

				if (updateFile.exists()) {
					originName = System.currentTimeMillis()+"_"+originName;
					updateFile = new File(realPath+"\\"+originName);
				}

				try {
					mFile.transferTo(updateFile);
				}catch (IOException e) {
					e.printStackTrace();
				}

				map.put(fileParamName, originName);


			} // if

		} // while

		System.out.println("map : " + map);



		return mapper.productUpdate(map);
	}

	@Override
	public ProductDTO prodInfo(int pnum) {
		return mapper.prodInfo(pnum);
	}

	@Override
	public int prodRemove(int pnum) {
		return mapper.prodDelete(pnum);
	}


}


