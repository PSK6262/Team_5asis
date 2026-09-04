package com.app.service.user.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.app.common.CommonCode;
import com.app.dao.user.UserDAO;
import com.app.dto.user.UserInfo;
import com.app.service.user.UserService;
import com.app.util.SHA256Encryptor;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Override
	public String findNickNameByUid(Long uid) {
		String nickname = userDAO.findNickNameByUid(uid);
		return nickname;
	}
	
	@Override
	public UserInfo getMyPageInfo(Long userId) {
		UserInfo user =  userDAO.findMyPageByUserId(userId);
		
		if (user == null) {
            throw new IllegalArgumentException("존재하지 않는 회원 번호입니다: " + userId);
        }
		
		return user;
	}
	
	
	@Override
	public void signup(UserInfo userInfo) {
		// 컨트롤러에서 넘어온 데이터 확인용 로그
		System.out.println("====== UserService 단 도착 ======");
		System.out.println("가입 이메일: " + userInfo.getEmail());
		
		
		//비밀번호를 암호화해서 세팅
		try {
			String encPw = SHA256Encryptor.encrypt(userInfo.getPassword());
			userInfo.setPassword(encPw);	//64자리 암호문으로 대체
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		userDAO.insertUser(userInfo);
	}

	@Override
	public int updatePassword(UserInfo userInfo) {
		int result = userDAO.updatePassword(userInfo);
		if(result < 1) System.out.println("update 안됨");
		return result;
	}

	@Override
	public int checkEmailDuplicate(String email) {
		return userDAO.checkEmailDuplicate(email);
	}
	
	
	@Override
	public void updateNickname(UserInfo userInfo) {
	    // 팀원이 컨트롤러에서 호출해서 임시로 껍데기만 만들어둠
	    // 나중에 DAO 쿼리 연결 예정
	}

	//로그인 검증 처리
	@Override
	public UserInfo login(UserInfo userInfo) {
		//1) 클라이언트가 입력한 이메일로 DB에서 회원정보 조회
		UserInfo dbUser = userDAO.findUserByEmail(userInfo.getEmail());
		
		//2) 조회된 회원정보가 존재하고, 비밀번호가 일치하는지 검증
		if (dbUser != null && dbUser.getStatus() != CommonCode.USER_STATUS_DEACTIVATED) {
			try {
				//로그인할 때 입력한 비번을 똑같이 암호화
				String inputEncPw = SHA256Encryptor.encrypt(userInfo.getPassword());
				
				//DB의 암호문과 입력한 암호문 비교
				if (dbUser.getPassword().equals(inputEncPw)) {
					return dbUser;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//3) 아이디가 없거나 비밀번호가 틀린 경우
		return null;
	}

	//이메일로 비밀번호 찾기
	@Override
	public String findPwByEmail(String email) {
		UserInfo user = userDAO.findUserByEmail(email);
		if (user != null) {
			return user.getPassword();
		}
		return null;
	}
	
	@Override
    public Map<String, Object> getUserProfile(Long userId) {
        return userDAO.getUserProfile(userId);
    }
	
	@Transactional
	@Override
    public void updateProfileImage(Long userId, MultipartFile uploadFile, HttpServletRequest request) {
        if (uploadFile == null || uploadFile.isEmpty()) {
            return;
        }

        try {
            // 1. 서버 폴더 경로 설정
            String uploadPath = request.getSession().getServletContext().getRealPath("/resources/img/");
            File folder = new File(uploadPath);
            if (!folder.exists()) folder.mkdirs();

            // 2. 고유 파일명 생성
            String originalFileName = uploadFile.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            if(extension.equalsIgnoreCase(".jfif")) {
                extension = ".jpg";
            }
            String savedFileName = userId + "_" + System.currentTimeMillis() + "_" + originalFileName;

            // 3. 파일 저장
            File target = new File(uploadPath, savedFileName);
            uploadFile.transferTo(target);

            // 4. 파일 정보 파라미터 맵핑
            Map<String, Object> fileParam = new HashMap<>();
            fileParam.put("fileName", savedFileName);
            fileParam.put("originalFileName", originalFileName);
            fileParam.put("filePath", uploadPath);
            fileParam.put("urlFilePath", request.getContextPath() + "/resources/img/" + savedFileName);

            // 5. 파일 상세 정보 INSERT (useGeneratedKeys로 ID를 받아옴)
            userDAO.insertProfileInfo(fileParam);
         // 💡 타입 안전하게 ID 추출하기 (BigDecimal, Long 등 모두 대응)
            Object rawImageId = fileParam.get("profileImageId");
            Long generatedImageId = null;
            
            if (rawImageId instanceof BigDecimal) {
                generatedImageId = ((BigDecimal) rawImageId).longValue();
            } else if (rawImageId instanceof Long) {
                generatedImageId = (Long) rawImageId;
            } else if (rawImageId instanceof Integer) {
                generatedImageId = ((Integer) rawImageId).longValue();
            } else if (rawImageId != null) {
                generatedImageId = Long.valueOf(rawImageId.toString());
            }
            
            if (generatedImageId == null) {
                throw new RuntimeException("프로필 이미지 파일 INSERT 후 시퀀스 ID를 받아오지 못했습니다. (fileParam 확인 필요)");
            }
            
            
            
            // 6. user_info 테이블의 profile_image_id 업데이트
            Map<String, Object> userParam = new HashMap<>();
            userParam.put("userId", userId);
            userParam.put("profileImageId", generatedImageId);
            

            userDAO.updateUserProfileImageId(userParam);
            
            UserInfo updatedUser = userDAO.findMyPageByUserId(userId); // 또는 회원 정보를 가져오는 조회 메서드
            if (request != null && request.getSession() != null) {
                // 프로젝트에서 로그인한 사용자를 저장할 때 쓰는 세션 키 이름("loginUser" 등)에 맞춰주세요!
                request.getSession().setAttribute("user", updatedUser);
                System.out.println("🔄 세션 정보가 최신 프로필 정보로 갱신되었습니다.");
            }
            
           

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("프로필 사진 변경 실패");
        }
    }

	
	
	
	@Override
	public UserInfo findUserByEmail(String email) {
		UserInfo user = userDAO.findUserByEmail(email);
		return user;
	}

	@Override
	public int deleteUsedTokenByTokenID(String token) {
		int result = userDAO.deleteUsedTokenByTokenID(token);
		if(result < 1) System.out.println("토큰 삭제이상");
		return result;
	}
}
