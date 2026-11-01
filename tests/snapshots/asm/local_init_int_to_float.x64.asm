
local_init_int_to_float.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x42280000, %eax       # imm = 0x42280000
               	movl	$0x4227999a, %ecx       # imm = 0x4227999A
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm14, %xmm15
               	ja	<addr>
               	movl	$0x42286666, %ecx       # imm = 0x42286666
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	movabsq	$0x4045000000000000, %rax # imm = 0x4045000000000000
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x4640e400, %eax       # imm = 0x4640E400
               	movl	$0x4640e200, %ecx       # imm = 0x4640E200
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm14, %xmm15
               	ja	<addr>
               	movl	$0x4640e600, %ecx       # imm = 0x4640E600
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	movabsq	$0x40c81c8000000000, %rax # imm = 0x40C81C8000000000
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x3fe4000000000000, %rax # imm = 0xC01C000000000000
               	movabsq	$-0x3fe2000000000000, %rcx # imm = 0xC01E000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm14, %xmm15
               	ja	<addr>
               	movabsq	$-0x3fe6000000000000, %rcx # imm = 0xC01A000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x4f800000, %eax       # imm = 0x4F800000
               	movl	$0x4f7fb434, %ecx       # imm = 0x4F7FB434
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm14, %xmm15
               	ja	<addr>
               	movl	$0x4f802666, %ecx       # imm = 0x4F802666
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jbe	<addr>
               	leaq	<rip>, %rdi
               	movabsq	$0x41f0000000000000, %rax # imm = 0x41F0000000000000
               	movq	%rax, %xmm0
               	movb	$0x1, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
