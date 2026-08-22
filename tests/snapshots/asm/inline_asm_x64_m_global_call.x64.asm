
inline_asm_x64_m_global_call.x64:	file format elf64-x86-64

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

<forty>:
               	movl	$0x28, %eax
               	retq

<two>:
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rdx
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	callq	*<rip>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movslq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	leaq	-<rip>, %rsi       # <addr>
               	movq	%rsi, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movq	%rax, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rbx
               	callq	*<rip>
               	movq	-0x20(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rbx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
