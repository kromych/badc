
ptr_diff_plus_ptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %rdi
               	movq	%rdi, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %rdi
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rdi, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %r14
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %r14
               	movq	(%rax), %r12
               	movq	%r12, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %r12
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x30(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movq	0x8(%r9), %rax
               	movq	%rax, 0x8(%r11)
               	movq	0x10(%r9), %rax
               	movq	%rax, 0x10(%r11)
               	movq	0x18(%r9), %rax
               	movq	%rax, 0x18(%r11)
               	movq	0x20(%r9), %rax
               	movq	%rax, 0x20(%r11)
               	movq	0x28(%r9), %rax
               	movq	%rax, 0x28(%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x30(%rbp), %r8
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x30(%rbp), %r11
               	addq	$0x20, %r11
               	movq	%r11, %rdi
               	subq	%r8, %rdi
               	movl	$0x10, %esi
               	movq	%rsi, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rdi
               	popq	%rdx
               	popq	%rax
               	shlq	$0x4, %rdi
               	addq	%r9, %rdi
               	leaq	-0x30(%rbp), %rsi
               	addq	$0x20, %rsi
               	cmpq	%rsi, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	subq	%r8, %r11
               	movl	$0x10, %r8d
               	movq	%r8, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r11
               	popq	%rdx
               	popq	%rax
               	shlq	$0x4, %r11
               	movq	%r9, %r8
               	addq	$0x10, %r8
               	addq	%r8, %r11
               	leaq	-0x30(%rbp), %r8
               	addq	$0x30, %r8
               	cmpq	%r8, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addq	$0x20, %r9
               	leaq	-0x30(%rbp), %r11
               	addq	$0x20, %r11
               	cmpq	%r11, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
