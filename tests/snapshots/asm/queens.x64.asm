
queens.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	movslq	%edx, %r8
               	xorq	%rdi, %rdi
               	movl	%edi, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdi
               	cmpq	%r9, %rdi
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rsi
               	movq	%r9, %rdi
               	subq	%rsi, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	shlq	$0x2, %rsi
               	addq	%r11, %rsi
               	movslq	(%rsi), %rdx
               	movq	%r8, %rsi
               	subq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x18(%rbp)
               	movslq	-0x18(%rbp), %rdx
               	cmpq	$0x0, %rdx
               	jge	<addr>
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %rsi
               	movabsq	$-0x1, %r10
               	imulq	%r10, %rsi
               	movl	%esi, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rsi
               	shlq	$0x2, %rsi
               	addq	%r11, %rsi
               	movslq	(%rsi), %rdx
               	cmpq	%r8, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %rdx
               	movslq	-0x18(%rbp), %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	cmpq	$0x8, %r12
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	$0x8, %r8
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%r12, %r14
               	shlq	$0x2, %r14
               	addq	%rbx, %r14
               	movslq	-0x10(%rbp), %rax
               	movl	%eax, (%r14)
               	movslq	-0x8(%rbp), %r15
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %r14
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	<addr>
               	addq	%rax, %r15
               	movslq	%r15d, %r15
               	movl	%r15d, -0x8(%rbp)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x20(%rbp), %rbx
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
