
file_scope_compound_literal_forms.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	(%rax), %eax
               	xorq	$0x7d, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	0xc(%rax), %eax
               	xorq	$0xfa0, %rax            # imm = 0xFA0
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rcx
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2c, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
