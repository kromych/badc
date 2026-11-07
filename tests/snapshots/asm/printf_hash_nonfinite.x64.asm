
printf_hash_nonfinite.x64:     file format elf64-x86-64


Disassembly of section .text:

<__c5_exit-0x20>:
	xor    %ebp,%ebp
	mov    %rsp,%rdi
	mov    $0x560,%esi
	call   <__c5_entry>
	ud2
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3
	int3

printf_hash_nonfinite.x64:     file format elf64-x86-64


Disassembly of section .text:

<__c5_lazy_stream>:
	push   %rbp
	mov    %rsp,%rbp
	cmpq   $0x0,<rip> # <__c5_stream_cache.0+0x10>
	je     <__c5_lazy_stream+0x17>
	mov    <rip>,%rax # <__c5_stream_cache.0+0x10>
	pop    %rbp
	ret
	xor    %edi,%edi
	lea    <rip>,%rsi # <wcslen+0xf34>
	xor    %eax,%eax
	call   <dlsym>
	test   %rax,%rax
	je     <__c5_lazy_stream+0x36>
	mov    (%rax),%rax
	mov    %rax,<rip> # <__c5_stream_cache.0+0x10>
	mov    <rip>,%rax # <__c5_stream_cache.0+0x10>
	pop    %rbp
	ret

<narrow>:
	push   %rbp
	mov    %rsp,%rbp
	sub    $0x48,%rsp
	push   %r13
	push   %r12
	push   %rbx
	mov    %rdi,%r12
	mov    %rsi,%rbx
	lea    -0x40(%rbp),%rdi
	mov    $0x40,%esi
	mov    %r12,%rdx
	mov    $0x1,%al
	call   <snprintf>
	mov    %rax,%r13
	lea    -0x40(%rbp),%rdi
	mov    %rbx,%rsi
	xor    %eax,%eax
	call   <strcmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <narrow+0x4e>
	mov    %rbx,%rdi
	xor    %eax,%eax
	call   <strlen>
	cmp    %eax,%r13d
	je     <narrow+0x85>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0xf3c>
	lea    -0x40(%rbp),%rcx
	mov    %r12,%rdx
	mov    %rbx,%r9
	mov    %r13,%r8
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	pop    %rbx
	pop    %r12
	pop    %r13
	leave
	ret

<narrow_nan>:
	push   %rbp
	mov    %rsp,%rbp
	sub    $0x40,%rsp
	push   %r12
	push   %rbx
	mov    %rdi,%r12
	lea    -0x40(%rbp),%rdi
	mov    $0x40,%esi
	mov    %r12,%rdx
	mov    $0x1,%al
	call   <snprintf>
	movsbq -0x40(%rbp),%rax
	cmp    $0x2d,%eax
	jne    <narrow_nan+0x97>
	lea    -0x40(%rbp),%rax
	lea    0x1(%rax),%rbx
	lea    <rip>,%rsi # <wcslen+0xf5a>
	mov    $0x3,%edx
	mov    %rbx,%rdi
	xor    %eax,%eax
	call   <strncmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <narrow_nan+0x61>
	cmpb   $0x0,0x3(%rbx)
	je     <narrow_nan+0x92>
	movsbq 0x3(%rbx),%rax
	cmp    $0x28,%eax
	je     <narrow_nan+0x92>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0xf5e>
	lea    -0x40(%rbp),%rcx
	mov    %r12,%rdx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	pop    %rbx
	pop    %r12
	leave
	ret
	lea    -0x40(%rbp),%rbx
	jmp    <narrow_nan+0x33>

<wide>:
	push   %rbp
	mov    %rsp,%rbp
	sub    $0x108,%rsp
	push   %r13
	push   %r12
	push   %rbx
	mov    %rdi,%r12
	mov    %rsi,%rbx
	lea    -0x100(%rbp),%rdi
	mov    $0x40,%esi
	mov    %r12,%rdx
	mov    $0x1,%al
	call   <swprintf>
	mov    %rax,%r13
	lea    -0x100(%rbp),%rdi
	mov    %rbx,%rsi
	xor    %eax,%eax
	call   <wcscmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <wide+0x57>
	mov    %rbx,%rdi
	xor    %eax,%eax
	call   <wcslen>
	cmp    %eax,%r13d
	je     <wide+0x91>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0xf8c>
	lea    -0x100(%rbp),%rcx
	mov    %r12,%rdx
	mov    %rbx,%r9
	mov    %r13,%r8
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	pop    %rbx
	pop    %r12
	pop    %r13
	leave
	ret

<main>:
	push   %rbp
	mov    %rsp,%rbp
	sub    $0x148,%rsp
	push   %rbx
	lea    <rip>,%rdi # <wcslen+0xfb2>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xfb8>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xfbc>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xfc2>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xfc7>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xfcd>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xfd1>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xfd7>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xfdc>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xfe2>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xfe6>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xfec>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xff1>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0xff7>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0xffc>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1002>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1006>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x100c>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1011>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1017>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x101b>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1021>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1026>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x102d>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1031>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1038>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x103d>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1043>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1047>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x104d>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1052>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x105b>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1067>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1071>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x107d>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1084>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1089>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1090>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x1095>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x109f>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x10ab>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x10b5>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x10c1>
	mov    $0x7fc00000,%eax
	movq   %rax,%xmm14
	cvtss2sd %xmm14,%xmm0
	call   <narrow_nan>
	lea    <rip>,%rdi # <wcslen+0x10c7>
	mov    $0x7fc00000,%eax
	movq   %rax,%xmm14
	cvtss2sd %xmm14,%xmm0
	movabs $0x8000000000000000,%r10
	movq   %r10,%xmm15
	xorpd  %xmm15,%xmm0
	call   <narrow_nan>
	lea    <rip>,%rdi # <wcslen+0x10cd>
	mov    $0x7fc00000,%eax
	movq   %rax,%xmm14
	cvtss2sd %xmm14,%xmm0
	call   <narrow_nan>
	lea    <rip>,%rdi # <wcslen+0x10d3>
	mov    $0x7fc00000,%eax
	movq   %rax,%xmm14
	cvtss2sd %xmm14,%xmm0
	movabs $0x8000000000000000,%r10
	movq   %r10,%xmm15
	xorpd  %xmm15,%xmm0
	call   <narrow_nan>
	lea    -0x140(%rbp),%rdi
	mov    $0x40,%esi
	lea    <rip>,%rdx # <wcslen+0x10d9>
	lea    <rip>,%rcx # <wcslen+0x10dc>
	mov    $0x0,%al
	call   <snprintf>
	mov    %rax,%rbx
	lea    -0x140(%rbp),%rdi
	lea    <rip>,%rsi # <wcslen+0x10f6>
	xor    %eax,%eax
	call   <strcmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <main+0x3b0>
	cmp    $0x19,%ebx
	je     <main+0x3e4>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x1110>
	lea    -0x140(%rbp),%rdx
	mov    %rbx,%rcx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	lea    -0x140(%rbp),%rdi
	mov    $0x40,%esi
	lea    <rip>,%rdx # <wcslen+0x1126>
	lea    <rip>,%rcx # <wcslen+0x112c>
	lea    <rip>,%r8 # <wcslen+0x1135>
	mov    $0x0,%al
	call   <snprintf>
	mov    %rax,%rbx
	lea    -0x140(%rbp),%rdi
	lea    <rip>,%rsi # <wcslen+0x113a>
	xor    %eax,%eax
	call   <strcmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <main+0x431>
	cmp    $0xd,%ebx
	je     <main+0x465>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x1148>
	lea    -0x140(%rbp),%rdx
	mov    %rbx,%rcx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	lea    -0x140(%rbp),%rdi
	mov    $0x40,%esi
	lea    <rip>,%rdx # <wcslen+0x115f>
	mov    $0x7,%ecx
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%r8 # <wcslen+0x116e>
	movabs $0xfff0000000000000,%r9
	movq   %rax,%xmm0
	movq   %r9,%xmm1
	mov    $0x2,%al
	call   <snprintf>
	mov    %rax,%rbx
	lea    -0x140(%rbp),%rdi
	lea    <rip>,%rsi # <wcslen+0x1170>
	xor    %eax,%eax
	call   <strcmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <main+0x4ce>
	cmp    $0x9,%ebx
	je     <main+0x502>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x117a>
	lea    -0x140(%rbp),%rdx
	mov    %rbx,%rcx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	xor    %edi,%edi
	lea    <rip>,%rdx # <wcslen+0x118c>
	movabs $0x7ff0000000000000,%rax
	movq   %rax,%xmm0
	mov    %rdi,%rsi
	mov    $0x1,%al
	call   <snprintf>
	mov    %rax,%rbx
	cmp    $0x3,%ebx
	je     <main+0x559>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x1192>
	mov    %rbx,%rdx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	movl   $0x0,-0x8(%rbp)
	lea    -0x140(%rbp),%rdi
	mov    $0x40,%esi
	lea    <rip>,%rdx # <wcslen+0x11a8>
	movabs $0x7ff0000000000000,%rax
	lea    -0x8(%rbp),%rcx
	movq   %rax,%xmm0
	mov    $0x1,%al
	call   <snprintf>
	mov    %rax,%rbx
	lea    -0x140(%rbp),%rdi
	lea    <rip>,%rsi # <wcslen+0x11b1>
	xor    %eax,%eax
	call   <strcmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <main+0x5ba>
	cmp    $0x5,%ebx
	jne    <main+0x5ba>
	mov    -0x8(%rbp),%eax
	cmp    $0x5,%eax
	je     <main+0x5f2>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x11b7>
	lea    -0x140(%rbp),%rdx
	mov    -0x8(%rbp),%r8d
	mov    %rbx,%rcx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	lea    <rip>,%rdi # <wcslen+0x11d6>
	movabs $0x3ff8000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x11dc>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x11e3>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x11e9>
	movq   %rax,%xmm0
	call   <narrow>
	lea    <rip>,%rdi # <wcslen+0x11f0>
	movabs $0x7ff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1208>
	movq   %rax,%xmm0
	call   <wide>
	lea    <rip>,%rdi # <wcslen+0x1218>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1230>
	movq   %rax,%xmm0
	call   <wide>
	lea    <rip>,%rdi # <wcslen+0x1244>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x125c>
	movq   %rax,%xmm0
	call   <wide>
	lea    <rip>,%rdi # <wcslen+0x1270>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x1294>
	movq   %rax,%xmm0
	call   <wide>
	lea    <rip>,%rdi # <wcslen+0x12c4>
	movabs $0xfff0000000000000,%rax
	lea    <rip>,%rsi # <wcslen+0x12ec>
	movq   %rax,%xmm0
	call   <wide>
	lea    -0x100(%rbp),%rdi
	mov    $0x40,%esi
	lea    <rip>,%rdx # <wcslen+0x131c>
	lea    <rip>,%rcx # <wcslen+0x1340>
	movabs $0x7ff0000000000000,%rax
	movq   %rax,%xmm0
	mov    $0x1,%al
	call   <swprintf>
	mov    %rax,%rbx
	lea    -0x100(%rbp),%rdi
	lea    <rip>,%rsi # <wcslen+0x1354>
	xor    %eax,%eax
	call   <wcscmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <main+0x735>
	cmp    $0x7,%ebx
	je     <main+0x769>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x1374>
	lea    -0x100(%rbp),%rdx
	mov    %rbx,%rcx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	lea    -0x100(%rbp),%rdi
	mov    $0x40,%esi
	lea    <rip>,%rdx # <wcslen+0x138c>
	movabs $0x7ff0000000000000,%rax
	mov    $0x1,%ecx
	movq   %rax,%xmm0
	mov    $0x1,%al
	call   <swprintf>
	mov    %rax,%rbx
	lea    -0x100(%rbp),%rdi
	lea    <rip>,%rsi # <wcslen+0x13bc>
	xor    %eax,%eax
	call   <wcscmp>
	movslq %eax,%rax
	test   %rax,%rax
	jne    <main+0x7bc>
	cmp    $0x5,%ebx
	je     <main+0x7f0>
	mov    $0x2,%edi
	call   <__c5_lazy_stream>
	mov    %rax,%rdi
	lea    <rip>,%rsi # <wcslen+0x13d4>
	lea    -0x100(%rbp),%rdx
	mov    %rbx,%rcx
	mov    $0x0,%al
	call   <fprintf>
	mov    <rip>,%eax # <bad>
	inc    %rax
	mov    %eax,<rip> # <bad>
	mov    <rip>,%eax # <bad>
	pop    %rbx
	leave
	ret
