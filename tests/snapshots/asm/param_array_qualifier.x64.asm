
param_array_qualifier.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	(%rdi), %r9
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	(%rdi), %r9
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	(%rdi), %r9
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	(%rdi), %r9
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %rdi
               	movslq	(%rdi), %rdi
               	addq	%rdi, %r9
               	movslq	%r9d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %r11
               	leaq	<rip>, %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r11)
               	movzbq	0x8(%r9), %rax
               	movb	%al, 0x8(%r11)
               	movzbq	0x9(%r9), %rax
               	movb	%al, 0x9(%r11)
               	movzbq	0xa(%r9), %rax
               	movb	%al, 0xa(%r11)
               	movzbq	0xb(%r9), %rax
               	movb	%al, 0xb(%r11)
               	popq	%rax
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r9
               	movq	%r11, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x6, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r9
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %r9
               	movslq	%r9d, %r9
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x6, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%r9)
               	movq	0x10(%rax), %r11
               	movq	%r11, 0x10(%r9)
               	popq	%r11
               	leaq	-0x28(%rbp), %r9
               	movslq	(%r9), %rax
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x4, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
