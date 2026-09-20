
compound_literal_file_scope.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x72, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x6f, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	(%rax), %rax
               	cmpq	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpl	$0x0, 0x4(%rcx)
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
