
param_array_qualifier.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x4, %rdx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
