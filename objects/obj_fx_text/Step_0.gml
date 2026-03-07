
    lifetime--;
    y    += vy;
    vy   *= 0.95;                // decelerate
    scale = lerp(scale, target_scale, 0.25);

    if (lifetime < 25) {
        alpha -= 0.04;
    }
    if (lifetime <= 0 || alpha <= 0) {
        instance_destroy();
    }