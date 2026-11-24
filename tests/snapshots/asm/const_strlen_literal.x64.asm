
const_strlen_literal.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	<rip>, %rsi
               	leaq	-0x48(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x48(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	callq	*%rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movq	%rsp, %rdi
               	movl	$0x8, %eax
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
               	movw	$0x78, (%rax)
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movq	%rdi, %rsp
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	leaq	0x4(%rcx), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	nopl	(%rax,%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x21, %eax
               	leave
               	retq
               	leaq	0x24(%rcx), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
