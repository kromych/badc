
nested_designator_string_member.x64:	file format elf64-x86-64

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
               	addq	$0x4, %rax
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
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x7(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xb(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movb	$0x77, 0x4(%rax)
               	movb	$0x78, 0x5(%rax)
               	movb	$0x79, 0x6(%rax)
               	movb	$0x7a, 0x7(%rax)
               	movb	$0x0, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movb	$0x0, 0x9(%rax)
               	movb	$0x0, 0xa(%rax)
               	movb	$0x0, 0xb(%rax)
               	leaq	0x6(%rdi), %rcx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x4(%rdi), %rcx
               	movl	%ecx, (%rax)
               	addq	$0x4, %rax
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
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rdx
               	leaq	0x6(%rdi), %rcx
               	cmpl	%ecx, %edx
               	jne	<addr>
               	movslq	(%rax), %rcx
               	leaq	0x4(%rdi), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
