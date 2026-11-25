
layout_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	incq	%rcx
               	cmpl	%edi, %ecx
               	jge	<addr>
               	leaq	(%rdi,%rcx), %rdx
               	movslq	%edx, %rsi
               	imulq	$0x55555556, %rsi, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %ecx
               	je	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	addq	%rdi, %rax
               	incq	%rdi
               	cmpl	$0x6, %edi
               	jl	<addr>
               	retq
