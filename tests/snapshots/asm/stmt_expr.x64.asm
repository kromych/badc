
stmt_expr.x64:	file format elf64-x86-64

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

<bump>:
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	retq

<main>:
               	leaq	<rip>, %rax # <addr>
               	movl	$0x0, (%rax)
               	movl	$0x1, (%rax)
               	movl	$0x2, (%rax)
               	movl	$0x3, (%rax)
               	movl	(%rax), %edx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x0, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	imulq	$0xa, %rdx, %rdx
               	incq	%rax
               	movl	%eax, (%rcx)
               	imulq	$0x64, %rax, %rax
               	cmpl	$0xa, %edx
               	jne	<addr>
               	cmpl	$0xc8, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	movl	$0x1, (%rcx)
               	movl	$0x2, (%rcx)
               	movl	$0x3, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	%eax, (%rcx)
               	movl	$0x1, (%rcx)
               	movl	$0x2, (%rcx)
               	retq
