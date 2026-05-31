
variadic_via_fnptr.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	0x10(%r9), %r11
               	movq	%r11, (%r8)
               	movslq	(%r9), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	leaq	0x10(%r11), %r10
               	movq	%r10, (%r9)
               	movslq	(%r11), %r9
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rdi
               	leaq	0x10(%rdi), %r10
               	movq	%r10, (%r11)
               	movslq	(%rdi), %r11
               	leaq	-0x8(%rbp), %rdi
               	movslq	0x10(%rbp), %rsi
               	movl	$0x3e8, %r10d           # imm = 0x3E8
               	imulq	%r10, %rsi
               	movslq	%esi, %rsi
               	movslq	%r8d, %r8
               	movl	$0x64, %r10d
               	imulq	%r10, %r8
               	movslq	%r8d, %r8
               	addq	%r8, %rsi
               	movslq	%esi, %rsi
               	movslq	%r9d, %r9
               	movl	$0xa, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	movslq	%r11d, %r11
               	addq	%r11, %rsi
               	movslq	%esi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x9, %ebx
               	movl	$0x1, %r12d
               	movl	$0x2, %r14d
               	movl	$0x3, %r15d
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
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xb, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rbx      # <addr>
               	movl	$0x9, %r12d
               	movl	$0x1, %r15d
               	movl	$0x2, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x3, %r14d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r14, %rcx
               	movq	%r15, %rsi
               	movq	0x28(%rsp), %rdx
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xc, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rbx      # <addr>
               	movl	$0x9, %r12d
               	movl	$0x1, %r14d
               	movl	$0x2, %r10d
               	movq	%r10, 0x20(%rsp)
               	movl	$0x3, %r15d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	movq	%r15, %rcx
               	movq	%r14, %rsi
               	movq	0x20(%rsp), %rdx
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xd, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
