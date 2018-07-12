package com.example.applitools.testespressoscratch2;

import android.support.test.rule.ActivityTestRule;

import com.applitools.eyes.android.common.logger.StdoutLogHandler;
import com.applitools.eyes.android.espresso.Eyes;

import org.junit.Rule;
import org.junit.Test;

import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.matcher.ViewMatchers.withText;
import static com.applitools.eyes.android.common.MatchLevel.STRICT;

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
        eyes.setMatchLevel(STRICT);
        eyes.addProperty("environment", "qa");
        //eyes.setBaselineName("test");
        //eyes.setBranchName("qa");
        //eyes.setParentBranchName("dev");
        //eyes.setBatch();
        eyes.setLogHandler(new StdoutLogHandler());

        try {

            // Start the test.
            eyes.open("Application Test", "Another Espresso Test");

            eyes.checkWindow("Home View");

            onView(withText("General")).perform(click());
            eyes.checkWindow("General View");

            onView(withText("Add friends to messages")).perform(click());
            eyes.checkWindow("withOut dialog");
            //use this to capture dialog
            eyes.checkWindowAllLayers("with dialog");
            //eyes.checkRegion(withId(16909249));
            //pressBack();

            eyes.close();
        } finally {

            // If the test was aborted before eyes.Close was called, ends the test as aborted.
            eyes.abortIfNotClosed();
        }
    }
}