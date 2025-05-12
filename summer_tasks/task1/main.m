function robotic_arm_circle(a, b, radius, v)
    L1 = 1;
    L2 = 1;
    omega = v/radius;
    figure;
    hold on;
    axis equal;
    grid on;
    title('2-Link Robotic Arm Circle Path Following');
    xlabel('X');
    ylabel('Y');
    

    for t = linspace(0, 1000, 1000)
        x = a + radius*cos(omega*t);
        y = b + radius*sin(omega*t);
        r = sqrt(x^2 + y^2);

        if r > 2
            fprintf("Unreachable: (%f, %f), test = %f\n", radius*cos(omega*t), y, omega*t);
            continue;
        end
        fprintf("Reachable: (%f, %f)\n", x, y);

        cos_theta2 = (r^2 - L1^2 - L2^2) / (2 * L1 * L2);
        theta2 = atan2(-sqrt(1 - cos_theta2^2), cos_theta2);
        beta = atan2(y, x);
        gamma = atan2(L2 * sin(theta2), L1 + L2 * cos(theta2));
        theta1 = beta - gamma;

        x1 = L1 * cos(theta1);
        y1 = L1 * sin(theta1);
        x2 = x1 + L2 * cos(theta1 + theta2);
        y2 = y1 + L2 * sin(theta1 + theta2);
        cla;
        
        theta_circle = linspace(0, 2*pi, 100);
        x_circle = a + radius*cos(theta_circle);
        y_circle = b + radius*sin(theta_circle);
        plot(x_circle, y_circle, 'k--');

        plot(0, 0, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
        plot([0, x1], [0, y1], 'b', 'LineWidth', 6);
        plot([x1, x2], [y1, y2], 'r', 'LineWidth', 8);
        plot(x1, y1, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
        plot(x2, y2, 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g');
        plot(x, y, 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
        xlim([-2, 2]);
        ylim([-2, 2]);
        text(-18, 20, sprintf('θ1: %.1f°, θ2: %.1f°', theta1*180/pi, theta2*180/pi));
        err = sqrt((x2-x)^2 + (y2-y)^2);
        text(-18, 18, sprintf('Error: %.2f units', err));
        pause(0.1);

    end
end
