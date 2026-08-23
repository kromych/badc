
inline_asm_hint.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pause
               	addq	%rax, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	pause
               	addq	%rax, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x2d, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
