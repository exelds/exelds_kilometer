-- Genel Not: 1km oyun içerisinde 0.62 mi (mil) denk gelmektedir. Aşağıdaki değerleri bunu göz önünde bulundurarak düzenleyiniz.
-- https://i.hizliresim.com/AKGrMd.png (Yaklaşık 1km gösteren görsel)

Config = {}

-- Not: Aşama 4 etkilerine tabi olan bir araç aşama 1-2-3 etkilerine de tabidir.
Config.asama1km = 1000   -- 1. Aşama etkilerin yaşanacağı km sınırı (3 te 1 oranda araç kirliliği ve max %80 motor canı) 
Config.asama2km = 2000   -- 2. Aşama etkilerin yaşanacağı km sınırı (Yarı oranda araç kirliliği, max %70 motor canı ve anlık benzin seviyesinde düşüş) 
Config.asama3km = 3000   -- 3. Aşama etkilerin yaşanacağı km sınırı (3 te 2 oranda araç kirliliği, max %60 motor canı ve kısa süreliğine araç motorunun stop etmesi)
Config.asama4km = 4000   -- 4. Aşama etkilerin yaşanacağı km sınırı (Full oranda araç kirliliği, max %50 motor canı ve araç tekerlerinden rasgele birinin patlaması)



-- Araç belirlediğiniz kritik hızdan daha yüksek hızda giderken araçta meydana gelebilecek etkilerin olasılığını daha yüksek oranlarda ayarlayabilirsiniz.
Config.kritikHiz = 200  -- (km/h)



-- Örnek: {5, 100} yüzde beş şans (%5 veya 5/100) anlamına gelmektedir.
-- Örnek2: {15, 1000} binde on beş (15/1000) şans anlamına gelmektedir. 
Config.asama2sans = {1, 100}         -- 2. Aşama etkiler (Anlık benzin seviyesinde düşüş yaşanma şansı) 
Config.asama2sansHizli = {3, 100}    -- 2. Aşama etkiler (Araç belirlediğiniz kritik hızdan (Config.kritikHiz) yüksek giderken anlık benzin seviyesinde düşüş yaşanma şansı) 

Config.asama3sans = {1, 100}         -- 3. Aşama etkiler (Kısa süreliğine araç motorunun stop etmesi şansı)
Config.asama3sansHizli = {3, 100}    -- 3. Aşama etkiler (Araç belirlediğiniz kritik hızdan (Config.kritikHiz) yüksek giderken kısa süreliğine araç motorunun stop etmesi şansı)

Config.asama4sans = {3, 1000}        -- 4. Aşama etkiler (Araç tekerlerinden rasgele birinin patlaması şansı)
Config.asama4sansHizli = {1, 100}    -- 4. Aşama etkiler (Araç belirlediğiniz kritik hızdan (Config.kritikHiz) yüksek giderken araç tekerlerinden rasgele birinin patlaması şansı)
