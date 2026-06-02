
va_copy.x64:	file format elf64-x86-64

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
               	leaq	-0x10(%rbp), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, (%r8)
               	xorq	%r11, %r11
               	movl	%r11d, -0x18(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %r11
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r11
               	jge	<addr>
               	movslq	-0x18(%rbp), %r9
               	leaq	-0x10(%rbp), %r11
               	movq	(%r11), %r8
               	leaq	0x10(%r8), %r10
               	movq	%r10, (%r11)
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	movslq	-0x20(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x20(%rbp)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %r8
               	leaq	-0x8(%rbp), %r9
               	movslq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	movl	$0x28, %r8d
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
               	addq	$0x50, %rsp
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0xb, %ecx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
