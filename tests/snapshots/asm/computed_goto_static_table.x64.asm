
computed_goto_static_table.x64:	file format elf64-x86-64

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

<interp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, -0x10(%rbp)
               	movzbq	(%rdi), %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movslq	-0x8(%rbp), %rsi
               	movq	-0x20(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	movzbq	(%rax,%rcx), %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, -0x8(%rbp)
               	leaq	<rip>, %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	movzbq	(%rax,%rcx), %rax
               	movq	(%rsi,%rax,8), %rax
               	jmpq	*%rax
               	movslq	-0x8(%rbp), %rsi
               	movq	-0x20(%rbp), %rax
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	movzbq	(%rax,%rcx), %rcx
               	subq	%rcx, %rsi
               	movl	%esi, -0x8(%rbp)
               	leaq	<rip>, %rsi
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	movzbq	(%rax,%rcx), %rax
               	movq	(%rsi,%rax,8), %rax
               	jmpq	*%rax
               	movslq	-0x8(%rbp), %rax
               	addq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rax
               	leaq	0x1(%rax), %rsi
               	movl	%esi, -0x10(%rbp)
               	movzbq	(%rdx,%rax), %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
