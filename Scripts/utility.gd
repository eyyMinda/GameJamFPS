class_name util

class SensitivityConverter:
	const MIN_USER_SENS = 0.01
	const MAX_USER_SENS = 5.0
	const MIN_ACTUAL_SENS = 0.00001
	const MAX_ACTUAL_SENS = 0.01

	static func to_actual_sens(user_sensitivity: float) -> float:
		if user_sensitivity == 0: user_sensitivity = MIN_USER_SENS
		var normalized = inverse_lerp(MIN_USER_SENS, MAX_USER_SENS, user_sensitivity)
		return lerp(MIN_ACTUAL_SENS, MAX_ACTUAL_SENS, normalized)

	static func to_user_sens(actual_sensitivity: float) -> float:
		var normalized = inverse_lerp(MIN_ACTUAL_SENS, MAX_ACTUAL_SENS, actual_sensitivity)
		return lerp(MIN_USER_SENS, MAX_USER_SENS, normalized)
