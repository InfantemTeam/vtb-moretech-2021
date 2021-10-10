package com.example.test;

import static java.lang.Math.round;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.SeekBar;

import com.example.test.http_helper.HTTPSHelper;

public class FormActivity extends AppCompatActivity {

    private Button next;
    private int graduationCategory;
    private int wageCategory;
    private int ageCategory;

    @RequiresApi(api = Build.VERSION_CODES.Q)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_form);
        next = findViewById(R.id.next);
        SeekBar graduationBar = findViewById(R.id.graduationBar);
        int maxGC = graduationBar.getMaxWidth();
        SeekBar moneyBar = findViewById(R.id.moneyBar);
        int maxMB = moneyBar.getMaxWidth();
        SeekBar ageBar = findViewById(R.id.ageBar);
        int maxAB = ageBar.getMaxWidth();

        graduationBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (progress < round(maxGC/3)) { graduationCategory = 0; }
                else if ((round(maxGC/3) <= progress) && (progress < maxGC - round(maxGC/3))) {
                    graduationCategory = 1;
                } else { graduationCategory = 2;}
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        moneyBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (progress < round(maxMB/3)) { wageCategory = 0; }
                else if ((round(maxMB/3) <= progress) && (progress < maxMB - round(maxMB/3))) {
                    wageCategory = 1;
                } else { wageCategory = 2;}
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        ageBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (progress < round(maxAB/3)) { ageCategory = 0; }
                else if ((round(maxAB/3) <= progress) && (progress < maxAB - round(maxAB/3))) {
                    ageCategory = 1;
                } else { ageCategory = 2;}
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        next.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {

                HTTPSHelper helper = new HTTPSHelper();
                helper.pushSegmentationInfo(ageCategory,graduationCategory, wageCategory);

                Intent intent = new Intent(FormActivity.this, GamesActivity.class);
                startActivity(intent);
            }
        });
    }


}


