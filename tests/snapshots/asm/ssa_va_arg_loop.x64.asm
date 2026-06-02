
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
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movl	$0x4, %r8d
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %ecx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2a, %esi
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
