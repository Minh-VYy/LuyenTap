package com.example.kiemtragk;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class RegisterActivity extends AppCompatActivity {

    EditText inputTen, inputMatkhau, inputXacnhanmatkhau, inputEmail;
    Button btnDangnhap;
    TextView loginLink;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_register);

        // 2. Ánh xạ View từ layout bằng ID
        inputTen = findViewById(R.id.inputTen);
        inputMatkhau = findViewById(R.id.inputMatkhau);
        inputXacnhanmatkhau = findViewById(R.id.inputXacnhanmatkhau);
        inputEmail = findViewById(R.id.inputEmail);
        btnDangnhap = findViewById(R.id.btnDangnhap);
        loginLink = findViewById(R.id.loginLink);

        btnDangnhap.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String ten = inputTen.getText().toString().trim();
                String email = inputEmail.getText().toString().trim();
                String matkhau = inputMatkhau.getText().toString().trim();
                String xacnhanMatkhau = inputXacnhanmatkhau.getText().toString().trim();

                if (ten.isEmpty() || email.isEmpty() || matkhau.isEmpty() || xacnhanMatkhau.isEmpty()) {
                    Toast.makeText(RegisterActivity.this, "Vui lòng nhập đầy đủ thông tin", Toast.LENGTH_SHORT).show();
                    return;
                }

                if (matkhau.equals(xacnhanMatkhau)) {
                    Toast.makeText(RegisterActivity.this, "Đăng kí thành công", Toast.LENGTH_SHORT).show();

                    Intent intent = new Intent(RegisterActivity.this, LoginActivity.class);
                    startActivity(intent);
                    finish();
                } else {
                    Toast.makeText(RegisterActivity.this, "Mật khẩu không khớp", Toast.LENGTH_SHORT).show();
                }
            }
        });

        loginLink.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(RegisterActivity.this, LoginActivity.class);
                startActivity(intent);
            }
        });

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }
}