
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
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r8
               	movq	%r8, %rsi
               	shlq	$0x1, %rsi
               	addq	%r11, %rsi
               	movl	$0x3, %r10d
               	imulq	%r10, %r8
               	movslq	%r8d, %r8
               	movswq	%r8w, %r8
               	movw	%r8w, (%rsi)
               	jmp	<addr>
               	subq	$0x1, %r9
               	movslq	%r9d, %r9
               	shlq	$0x1, %r9
               	addq	%r9, %r11
               	movswq	(%r11), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x10(%rbp), %rbx
               	movl	$0x8, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movswq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x30(%rbp)
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %r12
               	addq	$0xe, %r12
               	movswq	(%r12), %r12
               	cmpq	$0x15, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r12
               	addq	$0xe, %r12
               	movl	$0x63, %eax
               	movw	%ax, (%r12)
               	leaq	-0x28(%rbp), %rbx
               	addq	$0xe, %rbx
               	movswq	(%rbx), %rbx
               	cmpq	$0x63, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
