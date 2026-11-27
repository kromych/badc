
alloca_far_local_base_register.x64:	file format elf64-x86-64

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
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	movb	$0x3, (%rcx)
               	movq	-0x1020(%rbp), %rdx
               	movq	-0x1018(%rbp), %rax
               	movq	-0x1010(%rbp), %rsi
               	addq	%rsi, %rax
               	shlq	%rax
               	addq	%rdx, %rax
               	movq	%rax, -0x1020(%rbp)
               	movq	-0x1018(%rbp), %rax
               	movq	-0x1020(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1018(%rbp)
               	movq	-0x1010(%rbp), %rax
               	movq	-0x1018(%rbp), %rdx
               	addq	%rdx, %rax
               	movq	%rax, -0x1010(%rbp)
               	movsbq	-0x1000(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movsbq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x1020(%rbp), %rax
               	movq	-0x1018(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x1010(%rbp), %rcx
               	addq	%rcx, %rax
               	subq	$0x16, %rax
               	leave
               	retq
