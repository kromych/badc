
queens.x64:	file format elf64-x86-64

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

<solve>:
               	cmpl	$0x8, %esi
               	je	<addr>
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movslq	%esi, %r13
               	xorl	%ebx, %ebx
               	leaq	0x1(%r13), %r15
               	movq	%rbx, %r14
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	movq	%r13, %rdx
               	subq	%rax, %rdx
               	movslq	(%r12,%rax,4), %rsi
               	movq	%rbx, %rcx
               	subq	%rsi, %rcx
               	movq	%rcx, %rsi
               	negq	%rsi
               	testl	%ecx, %ecx
               	cmovlq	%rsi, %rcx
               	movl	(%r12,%rax,4), %esi
               	cmpl	%ebx, %esi
               	je	<addr>
               	cmpl	%ecx, %edx
               	je	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	%r13d, %eax
               	jl	<addr>
               	movl	%ebx, (%r12,%r13,4)
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	<addr>
               	addq	%rax, %r14
               	jmp	<addr>
               	movq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	retq
               	movl	$0x1, %eax
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x5c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
