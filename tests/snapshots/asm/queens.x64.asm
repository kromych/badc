
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movslq	%esi, %r13
               	cmpl	$0x8, %r13d
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%r12d, %r12d
               	movq	%r12, %r14
               	xorl	%eax, %eax
               	cmpl	%r13d, %eax
               	jge	<addr>
               	movq	%r13, %rdx
               	subq	%rax, %rdx
               	movslq	(%rbx,%rax,4), %rsi
               	movq	%r12, %rcx
               	subq	%rsi, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	(%rbx,%rax,4), %rsi
               	cmpl	%r12d, %esi
               	je	<addr>
               	cmpl	%ecx, %edx
               	je	<addr>
               	incq	%rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	movl	%r12d, (%rbx,%r13,4)
               	leaq	0x1(%r13), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rax, %r14
               	incq	%r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	movslq	%r14d, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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
