package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.WindowManager;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;


public class MainActivity extends AppCompatActivity {

    private static int SPLASH_SCREEN = 4000;
    //Variables
    Animation logo1_anim, logo2_anim;
    ImageView image1,image2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_main);
        //Animation
        logo1_anim = AnimationUtils.loadAnimation(this,R.anim.logo1_animation);
        logo2_anim = AnimationUtils.loadAnimation(this,R.anim.logo2_animation);
        //Hooks
        image1=findViewById(R.id.LOGO1);
        image2=findViewById(R.id.LOGO2);

        image1.setAnimation(logo2_anim);
        image2.setAnimation(logo1_anim);

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent intent=new Intent(MainActivity.this, LoginActivity.class);
                startActivity(intent);
                finish();
            }
        },SPLASH_SCREEN);
    }
}