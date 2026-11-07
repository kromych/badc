
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
               	movabsq	$-0x401999999999999a, %rax # imm = 0xBFE6666666666666
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x40af9db22d0e5604, %rcx # imm = 0xBF50624DD2F1A9FC
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x1, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3fe6666666666666, %rdx # imm = 0x3FE6666666666666
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x2, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movq	%rcx, %xmm15
               	comisd	%xmm15, %xmm0
               	ja	<addr>
               	movl	$0x3, %eax
               	retq
               	movsd	<rip>, %xmm0 # <addr>
               	movabsq	$-0x4000000000000000, %rax # imm = 0xC000000000000000
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3f50624dd2f1a9fc, %rax # imm = 0x3F50624DD2F1A9FC
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x40af9db22d0e5604, %rax # imm = 0xBF50624DD2F1A9FC
               	movq	%rax, %xmm15
               	comisd	%xmm15, %xmm0
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
