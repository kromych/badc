
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
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r13
               	movslq	%r13d, %r13
               	cmpl	$0x8, %r13d
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %r14
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%r13, %rsi
               	subq	%rdx, %rsi
               	movslq	(%rbx,%rdx,4), %rcx
               	movq	%rcx, %r10
               	movq	%r12, %rcx
               	subq	%r10, %rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movslq	(%rbx,%rdx,4), %rdx
               	cmpl	%r12d, %edx
               	je	<addr>
               	cmpl	%ecx, %esi
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	cmpl	%r13d, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	%r12d, (%rbx,%r13,4)
               	leaq	0x1(%r13), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r14, %rax
               	movslq	%eax, %r14
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	cmpl	$0x8, %r12d
               	jl	<addr>
               	movslq	%r14d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpl	$0x5c, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
