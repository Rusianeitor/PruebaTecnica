package util;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.fge.jackson.JsonLoader;
import com.github.fge.jsonschema.core.report.ProcessingReport;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;


public class SchemaUtils {
    public static boolean isValid(String json, String schema) throws Exception {
        JsonNode schemaNode = JsonLoader.fromString(schema);
        JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
        JsonSchema jsonSchema = factory.getJsonSchema(schemaNode);
        JsonNode jsonNode = JsonLoader.fromString(json);
        ProcessingReport report = jsonSchema.validate(jsonNode);
        return report.isSuccess();
    }
}
