
queens.x64:	file format elf64-x86-64

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

<solve>:
               	cmpl	$0x8, %esi
               	je	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movslq	%esi, %r12
               	xorl	%ebx, %ebx
               	movq	%rbx, %r14
               	xorl	%eax, %eax
               	cmpl	%r12d, %eax
               	jge	<addr>
               	movq	%r12, %rdx
               	subq	%rax, %rdx
               	movslq	(%r13,%rax,4), %rsi
               	movq	%rbx, %rcx
               	subq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	negq	%rcx
               	movslq	(%r13,%rax,4), %rsi
               	cmpl	%ebx, %esi
               	je	<addr>
               	cmpl	%ecx, %edx
               	je	<addr>
               	incq	%rax
               	cmpl	%r12d, %eax
               	jl	<addr>
               	movl	%ebx, (%r13,%r12,4)
               	leaq	0x1(%r12), %rsi
               	movq	%r13, %rdi
               	callq	<addr>
               	addq	%rax, %r14
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jl	<addr>
               	movq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpl	$0x5c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
