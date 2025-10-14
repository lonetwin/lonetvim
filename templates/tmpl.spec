Name:		
Version:	
Release:	1%{?dist}
Summary:	

Group:		
License:	
URL:		
Source0:	
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

BuildRequires:	
Requires:	

%description


%prep
%setup -q


%build
%configure
make %{?_smp_mflags}


%install
%make_install


%files
%doc



%changelog
