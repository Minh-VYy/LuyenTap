package com.example.taologinmau;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import androidx.appcompat.app.AppCompatActivity;
import com.google.android.material.button.MaterialButton;

public class OnboardingActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_onboarding);

        MaterialButton btnStart = findViewById(R.id.btnStart);
        View tvLoginNow = findViewById(R.id.tvLoginNow);
        View tvSkip = findViewById(R.id.tvSkip);

        View.OnClickListener goLogin = v ->
                startActivity(new Intent(OnboardingActivity.this, LoginActivity.class));

        btnStart.setOnClickListener(goLogin);
        tvLoginNow.setOnClickListener(goLogin);
        tvSkip.setOnClickListener(goLogin);
    }
}
