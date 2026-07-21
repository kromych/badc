
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<solve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r14
               	movslq	%r14d, %r14
               	cmpq	$0x8, %r14
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
               	movq	%r12, %r13
               	jmp	<addr>
               	movslq	%r12d, %rax
               	movslq	%r14d, %rdx
               	movslq	%eax, %rsi
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rdx, %rdi
               	subq	%rcx, %rdi
               	movslq	%edi, %r8
               	movslq	(%rbx,%rcx,4), %rcx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	imulq	$-0x1, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rdi
               	movslq	(%rbx,%rdi,4), %rdi
               	cmpq	%rsi, %rdi
               	je	<addr>
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %r8
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	cmpq	%rdx, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	%r12d, (%rbx,%r14,4)
               	leaq	0x1(%r14), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r13, %rax
               	movslq	%eax, %r13
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %r12
               	movslq	%r12d, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	movslq	%r13d, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
