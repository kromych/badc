
switch_goto_label_into_case.x64:	file format elf64-x86-64

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

<classify>:
               	cmpl	$0x3, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	jl	<addr>
               	cmpl	$0x4, %edi
               	je	<addr>
               	cmpl	$0x5, %edi
               	setge	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x8, %edi
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	cmpl	$0x2, %edi
               	jl	<addr>
               	movl	$0x14, %eax
               	retq
               	cmpl	$0x1, %edi
               	jne	<addr>
               	movl	$0xa, %eax
               	retq

<main>:
               	movl	$0xa, %eax
               	movl	$0x14, %eax
               	movl	$0x1e, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	movq	%rcx, %rdx
               	movl	$0x1e, %eax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	retq
