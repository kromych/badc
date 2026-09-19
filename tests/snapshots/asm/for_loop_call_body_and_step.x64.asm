
for_loop_call_body_and_step.x64:	file format elf64-x86-64

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

<driver>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x7, %eax
               	jge	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	imulq	$0x6, %rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x7, %eax
               	jge	<addr>
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	imulq	$0x6, %rcx, %rax
               	movslq	%eax, %rax
               	retq
