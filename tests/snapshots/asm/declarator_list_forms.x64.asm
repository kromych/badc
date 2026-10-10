
declarator_list_forms.x64:	file format elf64-x86-64

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

<add>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx      # <addr>
               	leaq	<rip>, %rsi      # <addr>
               	movq	%rsi, (%rdx)
               	movl	%ecx, (%rsi)
               	leaq	<rip>, %rsi      # <addr>
               	movl	(%rsi), %esi
               	cmpl	$0x4, %esi
               	jne	<addr>
               	leaq	<rip>, %rsi      # <addr>
               	movl	(%rsi), %esi
               	cmpl	$0x3, %esi
               	jne	<addr>
               	movq	(%rdx), %rdx
               	movl	(%rdx), %edx
               	cmpl	$0x2, %edx
               	je	<addr>
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	movl	0x8(%rax), %eax
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %edx
               	addq	%rdx, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movq	%rcx, %rax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	movl	0xc(%rax), %eax
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x64, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	xorq	$0x2, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	addq	%rax, %rax
               	incq	%rax
               	addq	$0x2, %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	addq	$0x3, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
