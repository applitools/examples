package test;

import java.rmi.UnexpectedException;

import org.openqa.selenium.WebDriver;

import com.applitools.eyes.BatchInfo;
import com.applitools.eyes.selenium.Eyes;
import com.applitools.eyes.RectangleSize;
import com.applitools.eyes.selenium.StitchMode;
import com.applitools.eyes.TestResults;

public class CompareScreens {
	
	// Private Fields
	private Eyes eyes;
	
	private BatchInfo baselinesBatch;
	private BatchInfo comparisonsBatch;
	
	private String appName;
	private String testName;
	private RectangleSize viewportSize;
	
	private boolean isBaselineSet = false;
	
	private int numberOfMisMatches = 0;
	private int numberOfMatches = 0;

	// Getters
	public int getNumberOfMisMatches() {
		return numberOfMisMatches;
	}

	public int getNumberOfMatches() {
		return numberOfMatches;
	}
	
	public Eyes getEyes()
	{
		return this.eyes;
	}

	// Constructors
	public CompareScreens(String apiKey, String baselinesBatchName, String comparisonsBatchName, String appName, String testName,
			RectangleSize viewportSize) {

		eyes = new Eyes();

		eyes.setForceFullPageScreenshot(true);
		eyes.setStitchMode(StitchMode.CSS);
		eyes.setApiKey(apiKey);

		this.baselinesBatch = new BatchInfo(baselinesBatchName);
		this.comparisonsBatch = new BatchInfo(comparisonsBatchName);

		int baselinesBatchID = (int) (Integer.MAX_VALUE * Math.random());
		int comparisonsBatchID = (int) (Integer.MAX_VALUE * Math.random());

		this.baselinesBatch.setId(Integer.toString(baselinesBatchID));
		this.comparisonsBatch.setId(Integer.toString(comparisonsBatchID));

		this.appName = appName;
		this.testName = testName;
		this.viewportSize = viewportSize;

	}

	public CompareScreens(String apiKey, String appName, String testName, RectangleSize viewportSize) {
		this(apiKey, "Compare Screens - Baselines", "Compare Screens - comparisons", appName, testName, viewportSize);
	}

	// Public Methods
	public void setScreenshotAsBaseline(WebDriver driver) {

		eyes.setSaveFailedTests(true);
		eyes.setBatch(this.baselinesBatch);

		if (validatePage(driver) != null)
			this.isBaselineSet = true;
	}

	public void compareScreenshotAgainstBaseline(WebDriver driver) throws UnexpectedException {

		if (!this.isBaselineSet)
			throw new UnexpectedException(
					"A baseline was not set for comparison. Please call the setBaseline method first.");
		
		eyes.setSaveFailedTests(false);
		eyes.setBatch(this.comparisonsBatch);

		TestResults testResults = validatePage(driver);

		this.numberOfMisMatches += testResults.getMismatches();
		this.numberOfMatches += testResults.getMatches();
	}

	// Private Methods
	private TestResults validatePage(WebDriver driver) {

		TestResults testResults = null;

		try {
			eyes.open(driver, this.appName, this.testName, this.viewportSize);
			eyes.checkWindow();
			testResults = eyes.close(false);

		} finally {
			eyes.abortIfNotClosed();
		}

		return testResults;
	}
}
