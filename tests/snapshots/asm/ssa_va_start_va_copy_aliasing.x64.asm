
ssa_va_start_va_copy_aliasing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edi, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r12, %r8
               	movq	(%r8), %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	addq	%r12, %rdi
               	movq	(%rdi), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	addq	$0x8, %rdx
               	leaq	<rip>, %rsi
               	movq	%rsi, (%rdx)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x10, %r8
               	leaq	<rip>, %rsi
               	movq	%rsi, (%r8)
               	leaq	-0x18(%rbp), %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	(%rdx), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%r12, %rsi
               	movq	(%rax), %rax
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	shlq	$0x3, %rbx
               	addq	%rbx, %r12
               	movq	(%r12), %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
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
               	movq	(%r9), %r9
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r11
               	leaq	0x10(%r11), %r10
               	movq	%r10, (%r8)
               	movq	(%r11), %r11
               	leaq	-0x8(%rbp), %r8
               	movl	$0x3e8, %r10d           # imm = 0x3E8
               	imulq	%r10, %r11
               	movq	%r9, %rax
               	addq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x10(%rbp), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	movq	(%r9), %r9
               	leaq	-0x10(%rbp), %r11
               	movq	(%r11), %r8
               	leaq	0x10(%r8), %r10
               	movq	%r10, (%r11)
               	movq	(%r8), %r8
               	leaq	-0x8(%rbp), %r11
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x11, %r11d
               	imulq	%r11, %r9
               	movq	%r9, %rax
               	addq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x2, %edi
               	movl	$0xb, %esi
               	movl	$0x16, %edx
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x30, %rsp
               	movq	%rax, %r11
               	cmpq	$0x55fb, %r11           # imm = 0x55FB
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r11, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x7, %esi
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %r11
               	cmpq	$0x7e, %r11
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%r11, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
