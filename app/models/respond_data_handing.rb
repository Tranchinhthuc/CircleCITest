class RespondDataHanding
  def inspect_data respond_data
    array_data = respond_data.split("|")
    result = {
      error_code: array_data[0],
      merchant_id: array_data[1],
      merchant_account: array_data[2],
      pin_card: array_data[3],
      card_serial: array_data[4],
      type_card: array_data[5],
      ref_code: array_data[6],
      client_fullname: array_data[7],
      client_email: array_data[8],
      client_mobile: array_data[9],
      card_amount: array_data[10],
      transaction_amount: array_data[11],
      transaction_id: array_data[12]
    }
  end

  def error_raising error_code
    case error_code
    when "00"
      "Giao dịch thành công"
    when "99"
      "Lỗi, tuy nhiên lỗi chưa được định nghĩa hoặc chưa xác định được nguyên nhân"
    when "01"
      "Lỗi, địa chỉ IP truy cập API của NgânLượng.vn bị từ chối"
    when "02"
      "Lỗi, tham số gửi từ merchant tới NgânLượng.vn chưa chính xác (thường sai tên tham số hoặc thiếu tham số)"
    when "03"
      "Lỗi, Mã merchant không tồn tại hoặc merchant đang bị khóa kết nối tới NgânLượng.vn"
    when "04"
      "Lỗi, Mã checksum không chính xác (lỗi này thường xảy ra khi mật khẩu giao tiếp giữa merchant và NgânLượng.vn không chính xác, hoặc cách sắp xếp các tham số trong biến params không đúng)"
    when "05"
      "Tài khoản nhận tiền nạp của merchant không tồn tại"
    when "06"
      "Tài khoản nhận tiền nạp của merchant đang bị khóa hoặc bị phong tỏa, không thể thực giao dịch nạp tiền"
    when "07"
      "Thẻ đã được sử dụng"
    when "08"
      "Thẻ bị khóa"
    when "09"
      "Thẻ hết hạn sử dụng"
    when "10"
      "Thẻ chưa được kích hoạt hoặc không tồn tại"
    when "11"
      "Mã thẻ sai định dạng"
    when "12"
      "Sai số serial của thẻ"
    when "13"
      "Thẻ chưa được kích hoạt hoặc không tồn tại"
    when "14"
      "Thẻ không tồn tại"
    when "15"
      "Thẻ không sử dụng được"
    when "16"
      "Số lần thử (nhập sai liên tiếp) của thẻ vượt quá giới hạn cho phép"
    when "17"
      "Hệ thống Telco bị lỗi hoặc quá tải, thẻ chưa bị trừ"
    when "18"
      "Hệ thống Telco bị lỗi hoặc quá tải, thẻ có thể bị trừ, cần phối hợp với NgânLượng.vn để tra soát"
    when "19"
      "Kết nối từ NgânLượng.vn tới hệ thống Telco bị lỗi, thẻ chưa bị trừ (thường do lỗi kết nối giữa NgânLượng.vn với Telco, ví dụ sai tham số kết nối, mà không liên quan đến merchant)"
    when "20"
      "Kết nối tới telco thành công, thẻ bị trừ nhưng chưa cộng tiền trên NgânLượng.vn"
    else
      "Undifined"
    end
  end
end
