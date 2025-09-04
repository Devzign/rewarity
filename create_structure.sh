#!/bin/bash

# Root directory (inside lib/)
BASE_DIR="lib"

# Define directories
DIRS=(
  "$BASE_DIR/app"
  "$BASE_DIR/core/config"
  "$BASE_DIR/core/di"
  "$BASE_DIR/core/error"
  "$BASE_DIR/core/logging"
  "$BASE_DIR/core/network"
  "$BASE_DIR/core/platform"
  "$BASE_DIR/core/storage"
  "$BASE_DIR/core/utils"
  "$BASE_DIR/domain/entities"
  "$BASE_DIR/domain/repositories"
  "$BASE_DIR/domain/usecases"
  "$BASE_DIR/data/datasources/remote"
  "$BASE_DIR/data/datasources/local"
  "$BASE_DIR/data/mappers"
  "$BASE_DIR/data/models"
  "$BASE_DIR/data/repositories"
  "$BASE_DIR/features/loyalty/presentation/pages"
  "$BASE_DIR/features/loyalty/presentation/controllers"
  "$BASE_DIR/features/loyalty/presentation/widgets"
  "$BASE_DIR/features/loyalty/application/viewmodels"
  "$BASE_DIR/l10n"
)

# Create directories
for dir in "${DIRS[@]}"; do
  mkdir -p "$dir"
done

# Create placeholder files
touch $BASE_DIR/app/app.dart
touch $BASE_DIR/app/router.dart
touch $BASE_DIR/app/theme.dart
touch $BASE_DIR/bootstrap.dart
touch $BASE_DIR/core/config/env.dart
touch $BASE_DIR/core/config/feature_flags.dart
touch $BASE_DIR/core/di/locator.dart
touch $BASE_DIR/core/error/failures.dart
touch $BASE_DIR/core/logging/logger.dart
touch $BASE_DIR/core/network/api_client.dart
touch $BASE_DIR/core/platform/secure_store_stub.dart
touch $BASE_DIR/core/platform/secure_store_io.dart
touch $BASE_DIR/core/platform/secure_store_web.dart
touch $BASE_DIR/core/storage/kv_store.dart
touch $BASE_DIR/core/utils/result.dart
touch $BASE_DIR/domain/entities/member.dart
touch $BASE_DIR/domain/entities/reward.dart
touch $BASE_DIR/domain/repositories/loyalty_repository.dart
touch $BASE_DIR/domain/usecases/earn_points.dart
touch $BASE_DIR/domain/usecases/redeem_reward.dart
touch $BASE_DIR/data/datasources/remote/loyalty_remote_ds.dart
touch $BASE_DIR/data/datasources/local/loyalty_local_ds.dart
touch $BASE_DIR/data/mappers/member_mapper.dart
touch $BASE_DIR/data/models/member_dto.dart
touch $BASE_DIR/data/models/reward_dto.dart
touch $BASE_DIR/data/repositories/loyalty_repository_impl.dart
touch $BASE_DIR/features/loyalty/presentation/pages/dashboard_page.dart
touch $BASE_DIR/features/loyalty/presentation/pages/rewards_page.dart
touch $BASE_DIR/features/loyalty/presentation/controllers/rewards_controller.dart
touch $BASE_DIR/features/loyalty/presentation/widgets/reward_tile.dart
touch $BASE_DIR/features/loyalty/application/viewmodels/reward_vm.dart
touch $BASE_DIR/main.dart

echo "✅ Project structure created successfully!"
