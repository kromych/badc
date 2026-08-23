
inc_dec_step_one.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x2a, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
