# Production config for deploying to AWS Auto Scaling Group via role-based syntax (for auto-scaling group)

autoscale 'your-auto-scaling-group', user: 'ubuntu', roles: %w{web}
role :worker, %w{123.45.678.910}, user: "ubuntu"
role :db,  %w{123.45.678.910}, user: "ubuntu"
