		function SilentUtility:GetClosestPlayer(TargetPart, TeamCheck, VisCheck, Enabled, FOVRadius)
			if not TargetPart then return end

			local Closest
			local DistanceToMouse

			for _, v in next, game.GetChildren(Players) do
				if v == Player then continue end
				if TeamCheck and v.Team == Player.Team then continue end

				local Character = v.Character
				if not Character then continue end

				if VisCheck and not IsPlayerVisible(v) then continue end

				local HumanoidRootPart = game.FindFirstChild(Character, "HumanoidRootPart")
				local Humanoid = game.FindFirstChild(Character, "Humanoid")

				if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

				local ScreenPosition, OnScreen = GetPositionOnScreen(HumanoidRootPart.Position)

				if not OnScreen then continue end

				local Distance = (GetMousePosition() - ScreenPosition).Magnitude
				if Distance <= (DistanceToMouse or (SilentSettings.Main.Enabled and FOVRadius) or 2000) then
					Closest = ((TargetPart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[TargetPart])
					DistanceToMouse = Distance
				end
			end
			return Closest
		end
