
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
               	movq	%rsi, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	leaq	(%r8,%rdx), %rcx
               	movsbq	(%rcx), %rdi
               	cmpq	$0x2, %rax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movq	%rsi, %rcx
               	movsbq	%cl, %rcx
               	cmpq	%rcx, %rdi
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x63, %ecx
               	jmp	<addr>
               	cmpl	$0x1, %eax
               	jl	<addr>
               	movl	$0x62, %ecx
               	jmp	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x61, %ecx
               	jmp	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	retq
               	movl	$0x8, %eax
               	retq
