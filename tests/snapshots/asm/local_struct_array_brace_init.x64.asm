
local_struct_array_brace_init.x64:	file format elf64-x86-64

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
               	movq	%rdx, -0x8(%rbp)
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rdx
               	cmpq	%rcx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%rdx)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x4, %rdi
               	addq	%rax, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rcx), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rcx), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rcx), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x98(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movl	$0x10, %eax
               	leaq	-0x98(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x98(%rbp), %rcx
               	addq	$0x10, %rcx
               	movq	%rax, (%rcx)
               	movl	$0x20, %eax
               	leaq	-0x98(%rbp), %rcx
               	addq	$0x18, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x98(%rbp), %rcx
               	addq	$0x20, %rcx
               	movq	%rax, (%rcx)
               	movl	$0x8, %eax
               	leaq	-0x98(%rbp), %rcx
               	addq	$0x28, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x98(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x40(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	leaq	-0x60(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	leaq	-0x68(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
