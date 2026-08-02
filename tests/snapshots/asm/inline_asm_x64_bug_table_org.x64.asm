
inline_asm_x64_bug_table_org.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x11, %ecx
               	xorq	%rdx, %rdx
               	movl	$0xc, %esi
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, -0x18(%rbp)
               	movq	%rdx, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	ud2
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
