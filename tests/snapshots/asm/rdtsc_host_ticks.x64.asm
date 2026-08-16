
rdtsc_host_ticks.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, -0x40(%rbp)
               	movq	%rdx, -0x38(%rbp)
               	movq	%rax, -0x30(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	rdtsc
               	movq	-0x30(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x28(%rbp), %r10
               	movl	%edx, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rdx
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
