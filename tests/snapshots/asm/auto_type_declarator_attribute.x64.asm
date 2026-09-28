
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
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, -0x8(%rbp)
               	movslq	(%rcx), %rax
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
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	%rcx, -0x8(%rbp)
               	movslq	(%rcx), %rcx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x6, %eax
               	leave
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, -0x8(%rbp)
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movl	$0x15, -0x8(%rbp)
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
