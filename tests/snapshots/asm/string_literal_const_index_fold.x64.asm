
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
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rdi
               	movq	%rdx, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	addq	%rdi, %rcx
               	movsbq	(%rcx), %rsi
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movq	%rdx, %rcx
               	cmpl	%ecx, %esi
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
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	retq
               	movl	$0x8, %eax
               	retq
