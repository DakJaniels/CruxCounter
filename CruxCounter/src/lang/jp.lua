-- -----------------------------------------------------------------------------
-- lang/jp.lua
-- -----------------------------------------------------------------------------

--- @class (partial) CruxCounter
local CC = CruxCounter
local M = {}

--- Setup translation strings
--- @return nil
function M.Setup()
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK", "ロック")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_UNLOCK", "アンロック")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_DESC", "カウンターディスプレイの位置調整のためのロック/アンロックを切り替えます。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_DISPLAY_HEADER", "ディスプレイ")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_WARNING", "この設定を変更するにはレティクルロックを解除してください。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER", "中央に移動")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_MOVE_TO_CENTER_DESC", "画面の中央にディスプレイを配置します。消失した場合に便利です。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE", "レティクルにロック")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_LOCK_TO_RETICLE_DESC", "ターゲットのレティクルクロスヘアの上に画面の中心に配置します。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT", "戦闘中以外は非表示")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_HIDE_OUT_OF_COMBAT_DESC", "戦闘中以外にすべてを非表示にします。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE", "サイズ")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SIZE_DESC", "カウンターの表示サイズ。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_HEADER", "スタイル")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_ROTATE", "回転")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER", "番号")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_DESC", "アクティブなクラックスの数の表示を表示または非表示にします。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR", "色")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR_DESC", "アクティブなクラックスの数の表示色。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR_RESET", "色をリセット")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_NUMBER_COLOR_RESET_DESC", "数字の色をデフォルトにリセット。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES", "クラックスルーン")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_DESC", "クラックスルーンテクスチャの表示を表示または非表示にします。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATE_DESC", "クラックスルーンテクスチャの回転をオンまたはオフにします。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATION_SPEED", "スピード")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_RUNES_ROTATION_SPEED_DESC",
        "魔核ルーンのテクスチャを回転させるスピード。数値が高いほど速く回転します。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR", "色")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR_DESC", "クラックスのテクスチャの色。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR_RESET", "色をリセット")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_CRUX_COLOR_RESET_DESC", "テクスチャの色をデフォルトにリセット。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND", "背景")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_DESC", "カウンターの背景テクスチャの表示を表示または非表示にします。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_ROTATE", "カウンターの背景テクスチャの回転をオンまたはオフにします。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_HIDE_ZERO_CRUX", "ゼロクラックス非表示")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_HIDE_ZERO_CRUX_DESC", "クラックスが存在しない場合に背景を非表示にします。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR", "色")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR_DESC", "カウンター背景テクスチャの色。")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR_RESET", "色をリセット")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_STYLE_BACKGROUND_COLOR_RESET_DESC", "カウンター背景テクスチャの色をデフォルトにリセット。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_HEADER", "サウンド")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_PLAY", "再生")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED", "クラックス取得")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_GAINED_DESC", "クラックス獲得時に音を再生する")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX", "クラックス上限")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_MAXIMUM_CRUX_DESC", "クラックスの上限に達したときにサウンドを再生します。")

    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST", "クラックス喪失")
    ZO_CreateStringId("CRUX_COUNTER_SETTINGS_SOUNDS_CRUX_LOST_DESC", "クラックスを失った時に音を再生します。")
end

CC.Translation = M
