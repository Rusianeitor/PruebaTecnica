package bdd;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static util.ReportsUtil.generateCucumberReport;

public class TestRunner {
    @Test
    public void test() {
        Results results =
                Runner.path("classpath:bdd/members").tags("@ObtenerAutor")
                        .outputCucumberJson(true)
                        .parallel(1);
        generateCucumberReport(results.getReportDir());
    }
}
