
branch_relaxation.x64:	file format elf64-x86-64

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
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%r9d, %eax
               	jge	<addr>
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	leaq	(%rdi,%rdi,2), %r8
               	movq	%rax, %rdx
               	subq	%r8, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	%rax, %rcx
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	decq	%rcx
               	jmp	<addr>
               	addq	$0x2, %rcx
               	incq	%rax
               	cmpl	%r9d, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0xa, %eax
               	jge	<addr>
               	imulq	$0x55555556, %rax, %rsi # imm = 0x55555556
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	leaq	(%rdi,%rdi,2), %r8
               	movq	%rax, %rdx
               	subq	%r8, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	addq	%rax, %rcx
               	jmp	<addr>
               	cmpl	$0x1, %edx
               	jne	<addr>
               	decq	%rcx
               	jmp	<addr>
               	addq	$0x2, %rcx
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq
