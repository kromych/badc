
unary_plus_init_and_param_shadow.x64:	file format elf64-x86-64

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

<f>:
               	movq	%rdi, %rax
               	retq

<main>:
               	movsd	<rip>, %xmm0 # <addr>
               	movsd	<rip>, %xmm1
               	vsubsd	%xmm1, %xmm0, %xmm2
               	movsd	<rip>, %xmm0
               	comisd	%xmm2, %xmm0
               	jbe	<addr>
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3
               	subsd	%xmm3, %xmm2
               	comisd	%xmm2, %xmm0
               	jbe	<addr>
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm2 # <addr>
               	movsd	<rip>, %xmm3
               	subsd	%xmm3, %xmm2
               	comisd	%xmm2, %xmm0
               	jbe	<addr>
               	comisd	%xmm1, %xmm2
               	ja	<addr>
               	movl	$0x3, %eax
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
               	movl	$0x4, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
