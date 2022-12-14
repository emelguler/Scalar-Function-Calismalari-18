USE [Okul]


--Ilgili Ogretmenin vermis olduğu dersin, derse ait ortalamalarını toplayan fonksiyon:

ALTER function [dbo].[FN$OgretmeneAitHerbirDersinOrtalamaToplamlari](@Ogretmen_Id int,@Ders_Id int,@Donem_Id int)
returns int
as
begin
     declare 
	         @sonuc int


set  @sonuc = (select sum(b.ortalama)  from
(select  d.Id as ders , (ood.Vize*0.4+ood.Final*0.6) as ortalama,do.Id as güzdönemi from dbo.OgrenciOgretmenDers as ood 
inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
inner join dbo.Ders as d on d.Id=od.Ders_Id and d.Statu=1
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.Donem as do on do.Id=od.Donem_Id and do.Statu=1
where 
ood.Statu=1
and
od.Donem_Id=1
and d.Id = @Ders_Id
and do.Id = @Donem_Id
and od.Ogretmen_Id=@Ogretmen_Id
group by d.Id,ood.Vize*0.4+ood.Final*0.6,do.Id) b
group by b.ders,b.güzdönemi)


return @sonuc
end




--cagiralim:
select dbo.FN$OgretmeneAitHerbirDersinOrtalamaToplamlari(6,8,1)






--where clause kontrolü:
select sum(b.ortalama)  from
(select  d.Id as ders , (ood.Vize*0.4+ood.Final*0.6) as ortalama,do.Id as güzdönemi from dbo.OgrenciOgretmenDers as ood 
inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
inner join dbo.Ders as d on d.Id=od.Ders_Id and d.Statu=1
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.Donem as do on do.Id=od.Donem_Id and do.Statu=1
where 
ood.Statu=1
and
od.Donem_Id=1
and d.Id = 8
and do.Id =1
and od.Ogretmen_Id=6
group by d.Id,ood.Vize*0.4+ood.Final*0.6,do.Id) b
group by b.ders,b.güzdönemi