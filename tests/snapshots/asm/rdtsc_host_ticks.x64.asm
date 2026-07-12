
rdtsc_host_ticks.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<host_ticks>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	rdtsc
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rax
               	movl	-0x10(%rbp), %eax
               	shlq	$0x20, %rax
               	movl	-0x8(%rbp), %ecx
               	orq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
