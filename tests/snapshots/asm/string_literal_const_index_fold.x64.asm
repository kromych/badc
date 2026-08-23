
string_literal_const_index_fold.x64:	file format elf64-x86-64

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
               	xorq	%rsi, %rsi
               	leaq	<rip>, %r8
               	movq	%rsi, %rcx
               	jmp	<addr>
               	leaq	(%r8,%rax), %rdx
               	movsbq	(%rdx), %rdi
               	cmpq	$0x2, %rax
               	jl	<addr>
               	cmpq	$0x3, %rax
               	jl	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movq	%rsi, %rdx
               	movsbq	%dl, %rdx
               	cmpq	%rdx, %rdi
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %edx
               	jmp	<addr>
               	movl	$0x63, %edx
               	jmp	<addr>
               	cmpq	$0x1, %rax
               	jl	<addr>
               	movl	$0x62, %edx
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x61, %edx
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	retq
               	movl	$0x8, %eax
               	retq
