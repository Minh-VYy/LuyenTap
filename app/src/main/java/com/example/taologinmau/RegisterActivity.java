package com.example.taologinmau;

import android.os.Bundle;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.material.button.MaterialButton;
import com.google.android.material.textfield.TextInputEditText;

public class RegisterActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        TextInputEditText edtFullName = findViewById(R.id.edtFullName);
        TextInputEditText edtRegEmail = findViewById(R.id.edtRegEmail);
        TextInputEditText edtRegPassword = findViewById(R.id.edtRegPassword);
        TextInputEditText edtConfirmPassword = findViewById(R.id.edtConfirmPassword);
        MaterialButton btnRegister = findViewById(R.id.btnRegister);
        TextView tvGoLogin = findViewById(R.id.tvGoLogin);

        btnRegister.setOnClickListener(v -> {
            // TODO: validate + gọi API tạo tài khoản
        });

        tvGoLogin.setOnClickListener(v -> finish());
    }
}
