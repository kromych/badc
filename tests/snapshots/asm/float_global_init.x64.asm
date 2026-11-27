
float_global_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
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

<main>:
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	vsubsd	<rip>, %xmm0, %xmm1
               	movsd	<rip>, %xmm0
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	vsubsd	<rip>, %xmm1, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	vsubsd	<rip>, %xmm1, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x3, %eax
               	retq
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	vsubsd	<rip>, %xmm1, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x4, %eax
               	retq
               	movss	<rip>, %xmm0 # <addr>
               	cvtss2sd	%xmm0, %xmm0
               	vsubsd	<rip>, %xmm0, %xmm1
               	movsd	<rip>, %xmm0
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x5, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	vsubsd	<rip>, %xmm1, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x6, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	vsubsd	<rip>, %xmm1, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x7, %eax
               	retq
               	movsd	<rip>, %xmm1 # <addr>
               	vsubsd	<rip>, %xmm1, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	comisd	<rip>, %xmm1
               	ja	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
