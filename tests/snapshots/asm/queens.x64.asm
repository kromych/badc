
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
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r11
               	cmpq	%rsi, %r11
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	movq	%rsi, %r11
               	subq	%r9, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x10(%rbp)
               	shlq	$0x2, %r9
               	addq	%rdi, %r9
               	movslq	(%r9), %r9
               	movq	%rdx, %r8
               	subq	%r9, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0x0, %r9
               	jge	<addr>
               	jmp	<addr>
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x18(%rbp), %r8
               	movabsq	$-0x1, %r11
               	imulq	%r11, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	shlq	$0x2, %r8
               	addq	%rdi, %r8
               	movslq	(%r8), %r8
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x10(%rbp), %r8
               	movslq	-0x18(%rbp), %rax
               	cmpq	%rax, %r8
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
               	movq	%rdi, %rbx
               	movslq	%esi, %r12
               	cmpq	$0x8, %r12
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
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
               	movslq	-0x10(%rbp), %rdx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movq	%r12, %rdx
               	shlq	$0x2, %rdx
               	addq	%rbx, %rdx
               	movslq	-0x10(%rbp), %rax
               	movl	%eax, (%rdx)
               	movslq	-0x8(%rbp), %r14
               	movq	%r12, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rax, %r14
               	movslq	%r14d, %r14
               	movl	%r14d, -0x8(%rbp)
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x5c, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
