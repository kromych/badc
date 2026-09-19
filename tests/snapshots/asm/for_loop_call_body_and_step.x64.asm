
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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	imulq	$0x6, %rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	incq	%rcx
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	imulq	$0x6, %rcx, %rax
               	movslq	%eax, %rax
               	retq
