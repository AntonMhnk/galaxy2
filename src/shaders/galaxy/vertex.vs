uniform float uSize;
uniform float uTime;

attribute float aScale;
attribute vec3 aRandomness;

varying vec3 vColor;

void main() {
    // Posisiton
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Animation
    float angle = atan(modelPosition.x, modelPosition.z);
    float distanceToCenter = length(modelPosition.xz);
    float angelOffset = (1.0 / distanceToCenter) * uTime * 0.3;
    angle += angelOffset;
    modelPosition.x = cos(angle) * distanceToCenter;
    modelPosition.z = sin(angle) * distanceToCenter;

    // Randomness
    modelPosition.xyz += aRandomness;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectionPosition = projectionMatrix * viewPosition;
    gl_Position = projectionPosition;

    // Size
    gl_PointSize = uSize * aScale;
    // Size ATTENUATION
    gl_PointSize *= (1.0 / - viewPosition.z);
    // Color
    vColor = color;
    
}