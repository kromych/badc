
math_constant_types.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x7fc00000, -0x18(%rbp) # imm = 0x7FC00000
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x10(%rbp), %eax
               	movl	$0xffc00000, %r11d      # imm = 0xFFC00000
               	andq	%r11, %rax
               	cmpl	$0x7fc00000, %eax       # imm = 0x7FC00000
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	movss	(%rax), %xmm0
               	ucomiss	%xmm0, %xmm0
               	jp	<addr>
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	movss	(%rax), %xmm0
               	movl	$0x7f61b1e6, %eax       # imm = 0x7F61B1E6
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jbe	<addr>
               	movabsq	$0x7ff0000000000000, %rax # imm = 0x7FF0000000000000
               	movabsq	$0x7fe1ccf385ebc8a0, %rcx # imm = 0x7FE1CCF385EBC8A0
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	ja	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x7fc00000, -0x8(%rbp) # imm = 0x7FC00000
               	movl	-0x8(%rbp), %eax
               	shrq	$0x1f, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffc00000, -0x8(%rbp) # imm = 0xFFC00000
               	movl	-0x8(%rbp), %eax
               	shrq	$0x1f, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
