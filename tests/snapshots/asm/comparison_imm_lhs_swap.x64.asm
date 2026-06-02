
comparison_imm_lhs_swap.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x5, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x18(%rbp)
               	cmpq	$0x0, %r11
               	jle	<addr>
               	movslq	-0x18(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0x0, %r11
               	jl	<addr>
               	movslq	-0x18(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0xa, %r11
               	jge	<addr>
               	movslq	-0x18(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0xa, %r11
               	jg	<addr>
               	movslq	-0x18(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0x0, %r11
               	jbe	<addr>
               	movslq	-0x18(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0x0, %r11
               	jb	<addr>
               	movslq	-0x18(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0xa, %r11
               	jae	<addr>
               	movslq	-0x18(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0xa, %r11
               	ja	<addr>
               	movslq	-0x18(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	<addr>
               	cmpq	$0xa, %r11
               	jle	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %r11
               	jge	<addr>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movslq	-0x18(%rbp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	-0x18(%rbp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, -0x30(%rbp)
               	jmp	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, -0x30(%rbp)
               	jmp	<addr>
               	movq	-0x30(%rbp), %rdi
               	movq	%rdi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
