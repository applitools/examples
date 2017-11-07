package com.example.applitools.testespressoscratch2;

import android.support.test.rule.ActivityTestRule;

import com.applitools.eyes.android.espresso.Eyes;

import org.junit.Rule;
import org.junit.Test;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.matcher.ViewMatchers.withText;

/**
 * <a href="http://d.android.com/tools/testing/testing_android.html">Testing Fundamentals</a>
 */
public class ApplicationTest  {

    @Rule
    public ActivityTestRule<SettingsActivity> mActivityRule = new ActivityTestRule(SettingsActivity.class);

    @Test
    public void test() {

        //com.applitools.eyes.images.Eyes eyes = new com.applitools.eyes.images.Eyes();

        // Initialize the eyes SDK and set your private API key.
        Eyes eyes = new Eyes();
        eyes.setApiKey("9RkMajXrzS1Zu110oTWQps102CHiPRPmeyND99E9iL0G7yAc110");
        eyes.setForceFullPageScreenshot(true);
        //eyes.setMatchLevel(LAYOUT2);
        eyes.setBranchName("qa");
        //eyes.setParentBranchName("dev");
        //eyes.setBatch();
        eyes.addProperty("environment", "qa");
        eyes.setBaselineName("test");


        try {

            // Start the test.
            eyes.open("Another Espresso Test");
            //eyes.open("Espresso", "Espresso Test");
            //eyes.getForceFullPageScreenshot();

            onView(withText("General")).perform(click());

            onView(withText("Add friends to messages")).perform(click());

            //pressBack();

            String fileName = "github-homepage.png";


            // Visual validation.
            eyes.checkWindow("Settings Activity");
            eyes.checkWindowAllLayers("with dialog");
            //eyes.checkRegion(withId(16909249));
            //eyes.checkRegion(withChild());
            //eyes.checkRegion(withClassName(Matchers.equalTo(android.widget.ListView)));
            //eyes.checkRegion(withClassName(Matchers.equalTo(ListView.class.getName())));

            //Spoon screenshot
            //SDK 23

            // End the test.
            eyes.close();
        } finally {

            // If the test was aborted before eyes.Close was called, ends the test as aborted.
            eyes.abortIfNotClosed();
        }
    }
}