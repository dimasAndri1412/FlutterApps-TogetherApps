
import 'dart:convert';
import 'dart:typed_data';

class UserList {
 final int userId;
 final String username;
 final String fullname;
 final String role;
 final String grup;
 final String email;
 final String phoneNumber;
 final String avatarUrl;
  UserList(this.userId, this.username, this.fullname, this.role, this.grup,
      this.email, this.phoneNumber, this.avatarUrl);
}