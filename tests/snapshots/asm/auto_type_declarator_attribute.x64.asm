
auto_type_declarator_attribute.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	(%rdx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rdx, -0x8(%rbp)
               	movslq	(%rdx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	%rdx, -0x8(%rbp)
               	movslq	(%rdx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, -0x8(%rbp)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x15, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x8, %eax
               	leave
               	retq
