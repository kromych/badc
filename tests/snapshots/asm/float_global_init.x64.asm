
float_global_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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
               	movsd	<rip>, %xmm1
               	vsubsd	%xmm1, %xmm0, %xmm3
               	movsd	<rip>, %xmm0
               	comisd	%xmm3, %xmm0
               	jbe	<addr>
               	movsd	<rip>, %xmm2
               	comisd	%xmm2, %xmm3
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	movss	<rip>, %xmm3 # <addr>
               	cvtss2sd	%xmm3, %xmm3
               	subsd	%xmm1, %xmm3
               	comisd	%xmm3, %xmm0
               	jbe	<addr>
               	comisd	%xmm2, %xmm3
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	movss	<rip>, %xmm3 # <addr>
               	vcvtss2sd	%xmm3, %xmm3, %xmm4
               	movsd	<rip>, %xmm3
               	subsd	%xmm3, %xmm4
               	comisd	%xmm4, %xmm0
               	jbe	<addr>
               	comisd	%xmm2, %xmm4
               	ja	<addr>
               	movl	$0x3, %eax
               	retq
               	movss	<rip>, %xmm2 # <addr>
               	cvtss2sd	%xmm2, %xmm2
               	subsd	%xmm1, %xmm2
               	comisd	%xmm2, %xmm0
               	jbe	<addr>
               	movsd	<rip>, %xmm0
               	comisd	%xmm0, %xmm2
               	ja	<addr>
               	movl	$0x4, %eax
               	retq
               	movss	<rip>, %xmm1 # <addr>
               	cvtss2sd	%xmm1, %xmm1
               	movsd	<rip>, %xmm2
               	vsubsd	%xmm2, %xmm1, %xmm4
               	movsd	<rip>, %xmm1
               	comisd	%xmm4, %xmm1
               	jbe	<addr>
               	comisd	%xmm0, %xmm4
               	ja	<addr>
               	movl	$0x5, %eax
               	retq
               	movsd	<rip>, %xmm4 # <addr>
               	subsd	%xmm2, %xmm4
               	comisd	%xmm4, %xmm1
               	jbe	<addr>
               	comisd	%xmm0, %xmm4
               	ja	<addr>
               	movl	$0x6, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	subsd	%xmm3, %xmm2
               	comisd	%xmm2, %xmm1
               	jbe	<addr>
               	comisd	%xmm0, %xmm2
               	ja	<addr>
               	movl	$0x7, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	ja	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
