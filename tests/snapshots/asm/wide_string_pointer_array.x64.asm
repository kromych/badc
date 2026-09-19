
wide_string_pointer_array.x64:	file format elf64-x86-64

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
               	cmpl	$0x4c, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movslq	0x1c(%rcx), %rcx
               	cmpl	$0x42, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rcx
               	movslq	0x1c(%rcx), %rcx
               	cmpl	$0x46, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movslq	0x20(%rcx), %rcx
               	cmpl	$0x6c, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movslq	0x30(%rcx), %rcx
               	cmpl	$0x79, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x43, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0x44, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	cmpl	$0x0, 0x8(%rcx)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movq	0x8(%rax), %rcx
               	movq	0x10(%rax), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x62, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x78, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x79, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x68, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x69, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpb	$0x0, 0x2(%rax)
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorl	%eax, %eax
               	retq
