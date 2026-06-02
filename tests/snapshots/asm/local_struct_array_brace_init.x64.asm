
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
               	movq	%rdi, %r11
               	movslq	%esi, %r9
               	xorq	%r8, %r8
               	movq	%r8, -0x8(%rbp)
               	movl	%r8d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r8
               	cmpq	%r9, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %rsi
               	movslq	-0x10(%rbp), %rdi
               	shlq	$0x4, %rdi
               	addq	%r11, %rdi
               	addq	$0x8, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, (%r8)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
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
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x1, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%r11
               	movq	(%rsi), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rsi), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rsi), %r11
               	movq	%r11, 0x10(%rax)
               	movq	0x18(%rsi), %r11
               	movq	%r11, 0x18(%rax)
               	movq	0x20(%rsi), %r11
               	movq	%r11, 0x20(%rax)
               	movq	0x28(%rsi), %r11
               	movq	%r11, 0x28(%rax)
               	popq	%r11
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x98(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movl	$0x10, %edi
               	leaq	-0x98(%rbp), %rsi
               	addq	$0x8, %rsi
               	movq	%rdi, (%rsi)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x98(%rbp), %rsi
               	addq	$0x10, %rsi
               	movq	%rax, (%rsi)
               	movl	$0x20, %edi
               	leaq	-0x98(%rbp), %rsi
               	addq	$0x18, %rsi
               	movq	%rdi, (%rsi)
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x98(%rbp), %rsi
               	addq	$0x20, %rsi
               	movq	%rax, (%rsi)
               	movl	$0x8, %edi
               	leaq	-0x98(%rbp), %rsi
               	addq	$0x28, %rsi
               	movq	%rdi, (%rsi)
               	leaq	-0x98(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x4, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x40(%rbp), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	leaq	-0x60(%rbp), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x6, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rax
               	leaq	-0x68(%rbp), %rsi
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x7, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	addq	$0x28, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x8, %esi
               	movq	%rsi, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
