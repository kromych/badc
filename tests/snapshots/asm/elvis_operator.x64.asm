
elvis_operator.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x5, %edx
               	movl	%edx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x64, %eax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movq	%rsi, %rax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x100000000, %r11      # imm = 0x100000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
