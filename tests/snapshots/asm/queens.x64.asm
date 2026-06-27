
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<conflicts>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	%rsi, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rsi, %r8
               	subq	%rax, %r8
               	movslq	%r8d, %r8
               	movslq	(%rdi,%rax,4), %rax
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %r9
               	testq	%r9, %r9
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %r9, %rax
               	movslq	%eax, %r9
               	movslq	%ecx, %rax
               	movslq	(%rdi,%rax,4), %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	%r9d, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<solve>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movslq	%r12d, %r12
               	cmpq	$0x8, %r12
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r13, %r13
               	movq	%r13, %r14
               	movslq	%r13d, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	0x1(%r13), %rax
               	movslq	%eax, %r13
               	jmp	<addr>
               	movslq	%r13d, %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r14d, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	%r13d, (%rbx,%r12,4)
               	leaq	0x1(%r12), %rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%r14, %rax
               	movslq	%eax, %r14
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
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
