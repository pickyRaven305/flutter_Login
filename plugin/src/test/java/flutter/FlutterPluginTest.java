/*
 * This Java source file was generated by the Gradle 'init' task.
 */
package flutter;

import org.gradle.testfixtures.ProjectBuilder;
import org.gradle.api.Project;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 * A simple unit test for the 'flutter.greeting' plugin.
 */
class FlutterPluginTest {
    @Test void pluginRegistersATask() {
        // Create a test project and apply the plugin
        Project project = ProjectBuilder.builder().build();
        project.getPlugins().apply("flutter.greeting");

        // Verify the result
        assertNotNull(project.getTasks().findByName("greeting"));
    }
}
