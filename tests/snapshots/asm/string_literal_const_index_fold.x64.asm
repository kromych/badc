
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
               	leaq	<rip>, %rsi
               	movq	%rdx, %rax
               	cmpl	$0x5, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movsbq	(%rsi,%rcx), %rdi
               	cmpl	$0x2, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movq	%rdx, %rcx
               	cmpl	%ecx, %edi
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x61, %ecx
               	cmpl	%ecx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x8, %eax
               	retq
