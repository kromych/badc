
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
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r11
               	movq	%r11, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r11
               	movq	(%r11), %rax
               	leaq	0x10(%rax), %rax
               	movq	%rax, (%r11)
               	leaq	-0x10(%rax), %rax
               	movq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	(%r11), %rcx
               	leaq	0x10(%rcx), %rcx
               	movq	%rcx, (%r11)
               	leaq	-0x10(%rcx), %rcx
               	movq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movl	$0x3e8, %r11d           # imm = 0x3E8
               	imulq	%r11, %rcx
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r11
               	movq	%r11, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r11
               	movq	(%r11), %rax
               	leaq	0x10(%rax), %rax
               	movq	%rax, (%r11)
               	leaq	-0x10(%rax), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, %r11
               	movq	(%r11), %rcx
               	leaq	0x10(%rcx), %rcx
               	movq	%rcx, (%r11)
               	leaq	-0x10(%rcx), %rcx
               	movq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x10(%rbp), %rdx
               	movl	$0x11, %r11d
               	imulq	%r11, %rax
               	addq	%rcx, %rax
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
               	movq	%rax, %rsi
               	cmpq	$0x55fb, %rsi           # imm = 0x55FB
               	je	<addr>
               	leaq	<rip>, %rdi
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
               	movq	%rax, %rsi
               	cmpq	$0x7e, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
