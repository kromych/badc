
struct_2d_array_field.x64:	file format elf64-x86-64

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
               	xorq	%r11, %r11
               	movl	%r11d, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x38(%rbp), %r11
               	cmpq	$0x3, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x38(%rbp), %r9
               	movslq	(%r9), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r9)
               	jmp	<addr>
               	xorq	%r11, %r11
               	movl	%r11d, -0x40(%rbp)
               	jmp	<addr>
               	leaq	-0x30(%rbp), %r9
               	xorq	%r8, %r8
               	movl	%r8d, -0x50(%rbp)
               	movl	%r8d, -0x38(%rbp)
               	jmp	<addr>
               	movslq	-0x40(%rbp), %r11
               	cmpq	$0x4, %r11
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x40(%rbp), %r8
               	movslq	(%r8), %r11
               	addq	$0x1, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	leaq	-0x30(%rbp), %r11
               	movslq	-0x38(%rbp), %r9
               	movq	%r9, %r8
               	shlq	$0x4, %r8
               	addq	%r8, %r11
               	movslq	-0x40(%rbp), %r8
               	movq	%r8, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %r11
               	movl	$0xa, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	-0x38(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x38(%rbp), %r11
               	movslq	(%r11), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%r11)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x40(%rbp)
               	jmp	<addr>
               	movslq	-0x50(%rbp), %r11
               	subq	$0x6f, %r11
               	movslq	%r11d, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x40(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movslq	(%rdi), %r8
               	addq	$0x1, %r8
               	movl	%r8d, (%rdi)
               	jmp	<addr>
               	leaq	-0x50(%rbp), %r8
               	movslq	(%r8), %r11
               	movslq	-0x38(%rbp), %rdi
               	shlq	$0x4, %rdi
               	movq	%r9, %rsi
               	addq	%rdi, %rsi
               	movslq	-0x40(%rbp), %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	movslq	(%rsi), %rdi
               	addq	%rdi, %r11
               	movl	%r11d, (%r8)
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
