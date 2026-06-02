
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

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
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movq	%rdx, %r11
               	shlq	$0x2, %r11
               	addq	%rdi, %r11
               	movslq	(%r11), %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%esi, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rsi
               	cmpq	%rdx, %rsi
               	jg	<addr>
               	jmp	<addr>
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %rsi
               	addq	$0x1, %rsi
               	movl	%esi, (%r8)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	movslq	-0x8(%rbp), %r9
               	shlq	$0x2, %r9
               	addq	%rdi, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	movslq	%r11d, %r11
               	addq	%r11, %rsi
               	movslq	%esi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %r11
               	xorq	%rsi, %rsi
               	movl	$0xc, %r8d
               	movl	%r8d, (%r11)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x4, %edx
               	addq	$0x4, %rdi
               	movl	$0x7, %r11d
               	movl	%r11d, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x8, %r9
               	movl	$0xf, %r11d
               	movl	%r11d, (%r9)
               	leaq	-0x18(%rbp), %rdi
               	addq	$0xc, %rdi
               	movl	$0x5, %r11d
               	movl	%r11d, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	movl	$0xa, %r11d
               	movl	%r11d, (%r9)
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
