
array_typedef_pointer_casts.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rsi      # <addr>
               	leaq	0xc(%rsi), %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rdi
               	movq	0x8(%rdi), %rdi
               	cmpq	%rax, %rdi
               	jne	<addr>
               	movq	(%rdx), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rcx), %rax
               	movl	0x8(%rax), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movq	(%rdx), %rax
               	movq	(%rax), %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%rcx), %rax
               	leaq	0xc(%rax), %rcx
               	subq	%rax, %rcx
               	cmpq	$0xc, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
