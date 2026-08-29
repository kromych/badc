
deferred_array_typedef.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rsi
               	shlq	$0x4, %rsi
               	addq	%rdi, %rsi
               	movslq	0xc(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x18, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	retq
