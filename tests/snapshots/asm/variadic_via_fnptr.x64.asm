
variadic_via_fnptr.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r9
               	leaq	0x10(%r9), %r11
               	movq	%r11, (%r8)
               	movslq	(%r9), %r9
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r11
               	leaq	0x10(%r11), %r10
               	movq	%r10, (%r8)
               	movslq	(%r11), %r11
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %rdi
               	leaq	0x10(%rdi), %r10
               	movq	%r10, (%r8)
               	movslq	(%rdi), %rdi
               	leaq	-0x8(%rbp), %r8
               	movslq	0x10(%rbp), %rsi
               	movl	$0x3e8, %r10d           # imm = 0x3E8
               	imulq	%r10, %rsi
               	movslq	%esi, %rsi
               	movslq	%r9d, %r9
               	movl	$0x64, %r10d
               	imulq	%r10, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %rsi
               	movslq	%esi, %rsi
               	movslq	%r11d, %r11
               	movl	$0xa, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	%r11, %rsi
               	movslq	%esi, %rsi
               	movslq	%edi, %rdi
               	addq	%rdi, %rsi
               	movslq	%esi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
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
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xb, %ecx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax      # <addr>
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%rax, %r11
               	callq	*%r11
               	movq	%rax, %r8
               	cmpq	$0x23a3, %r8            # imm = 0x23A3
               	je	<addr>
               	movl	$0xc, %ecx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %r8       # <addr>
               	movl	$0x9, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%r8, %r11
               	callq	*%r11
               	cmpq	$0x23a3, %rax           # imm = 0x23A3
               	je	<addr>
               	movl	$0xd, %ecx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
