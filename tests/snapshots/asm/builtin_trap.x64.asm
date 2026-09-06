
builtin_trap.x64:	file format elf64-x86-64

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
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	ud2
               	ud2
