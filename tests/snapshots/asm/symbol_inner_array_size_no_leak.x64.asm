
symbol_inner_array_size_no_leak.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	cmpq	%rcx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rdx)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rdx
               	movq	%rdx, %rsi
               	shlq	$0x1, %rsi
               	addq	%rax, %rsi
               	imulq	$0x3, %rdx, %rdx
               	movslq	%edx, %rdx
               	movswq	%dx, %rdx
               	movw	%dx, (%rsi)
               	jmp	<addr>
               	subq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	shlq	$0x1, %rcx
               	addq	%rcx, %rax
               	movswq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movswq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0xe, %rax
               	movswq	(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	addq	$0xe, %rax
               	movl	$0x63, %ecx
               	movw	%cx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	addq	$0xe, %rax
               	movswq	(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
