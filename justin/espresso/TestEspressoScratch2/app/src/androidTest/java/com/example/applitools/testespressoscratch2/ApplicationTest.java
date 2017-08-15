package com.example.applitools.testespressoscratch2;

import android.support.test.rule.ActivityTestRule;
import com.applitools.eyes.android.espresso.Eyes;

import android.support.test.espresso.ViewInteraction;
import android.support.test.rule.ActivityTestRule;
import static android.support.test.InstrumentationRegistry.getInstrumentation;
import static android.support.test.espresso.Espresso.onView;
import static android.support.test.espresso.Espresso.openActionBarOverflowOrOptionsMenu;
import static android.support.test.espresso.Espresso.pressBack;
import static android.support.test.espresso.action.ViewActions.click;
import static android.support.test.espresso.matcher.ViewMatchers.isDisplayed;
import static android.support.test.espresso.matcher.ViewMatchers.withId;
import static android.support.test.espresso.matcher.ViewMatchers.withParent;
import static android.support.test.espresso.matcher.ViewMatchers.withText;

import org.junit.Rule;
import org.junit.Test;

/**
 * <a href="http://d.android.com/tools/testing/testing_android.html">Testing Fundamentals</a>
 */
public class ApplicationTest  {

    @Rule
    public ActivityTestRule<SettingsActivity> mActivityRule = new ActivityTestRule(SettingsActivity.class);

    @Test
    public void test() {

        // Initialize the eyes SDK and set your private API key.
        Eyes eyes = new Eyes();
        eyes.setApiKey("your_applitools_key");
        eyes.setForceFullPageScreenshot(true);

        try {

            // Start the test.
            eyes.open("Another Espresso Test");

            //onView(withText("General")).perform(click());

            // Visual validation.
            eyes.checkWindow("Settings Activity");

            // End the test.
            eyes.close();
        } finally {

            // If the test was aborted before eyes.Close was called, ends the test as aborted.
            eyes.abortIfNotClosed();
        }
    }
}