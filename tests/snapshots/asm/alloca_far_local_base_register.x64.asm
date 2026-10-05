
alloca_far_local_base_register.x64:	file format elf64-x86-64

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
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x20, %rsp
               	movb	$0x1, -0x1000(%rbp)
               	movq	$0x0, -0x1020(%rbp)
               	movq	$0x1, -0x1018(%rbp)
               	movq	$0x2, -0x1010(%rbp)
               	movl	$0x40, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movb	$0x3, (%rax)
               	movq	-0x1020(%rbp), %rcx
               	movq	-0x1018(%rbp), %rdx
               	movq	-0x1010(%rbp), %rsi
               	addq	%rsi, %rdx
               	shlq	%rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x1020(%rbp)
               	movq	-0x1018(%rbp), %rcx
               	movq	-0x1020(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x1018(%rbp)
               	movq	-0x1010(%rbp), %rcx
               	movq	-0x1018(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x1010(%rbp)
               	movsbq	-0x1000(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
               	movsbq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1010(%rbp), %rcx
               	addq	%rcx, %rax
               	subq	$0x16, %rax
               	leaq	-0x1020(%rbp), %rsp
               	leave
               	retq
