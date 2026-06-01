
ssa_va_arg_loop.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	xorq	%r8, %r8
               	movq	%r8, -0x10(%rbp)
               	movl	%r8d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r8
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %r9
               	movslq	(%r9), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r9)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r8
               	movq	(%r8), %r11
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %rdi
               	leaq	0x10(%rdi), %r10
               	movq	%r10, (%r9)
               	movq	(%rdi), %rdi
               	addq	%rdi, %r11
               	movq	%r11, (%r8)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	0x10(%r9), %r11
               	movq	%r11, (%r8)
               	movq	(%r9), %rax
               	leaq	-0x8(%rbp), %r9
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x3, %ebx
               	movl	$0xa, %r12d
               	movl	$0x14, %r14d
               	movl	$0x1e, %r15d
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ebx
               	movl	$0x1, %r12d
               	movl	$0x2, %r15d
               	movl	$0x3, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x4, %r14d
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	movq	0x48(%rsp), %r10
               	subq	$0x10, %rsp
               	movq	%r10, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movl	$0x2a, %r12d
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
