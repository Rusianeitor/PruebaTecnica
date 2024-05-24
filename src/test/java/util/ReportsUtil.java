package util;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class ReportsUtil {
    public static void generateCucumberReport(String karatePath) {
        try {
            Collection<File> jsonFiles = FileUtils.listFiles(new File(karatePath), new String[]{"json"}, true);
            List<String> jsonPaths = jsonFiles.stream().map(File::getAbsolutePath).collect(Collectors.toList());
            Configuration config = new Configuration(new File("target"), "Cucumber Reports");
            File copied = new File("target/builder/cucumber.json");
            FileUtils.copyFile(new File(jsonPaths.get(0)), copied);
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
            reportBuilder.generateReports();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
