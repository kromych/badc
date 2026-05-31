
struct_value_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	addq	$0x4, %r8
               	movl	$0x2, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	movl	$0x63, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%r11)
               	popq	%rax
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movl	$0x7d0, %eax            # imm = 0x7D0
               	movl	%eax, (%r9)
               	leaq	-0x10(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movl	$0x7, %eax
               	movl	%eax, (%r11)
               	leaq	-0x20(%rbp), %r9
               	addq	$0x4, %r9
               	movl	$0xe, %eax
               	movl	%eax, (%r9)
               	leaq	-0x20(%rbp), %r11
               	addq	$0x8, %r11
               	movl	$0x15, %eax
               	movl	%eax, (%r11)
               	leaq	-0x30(%rbp), %r9
               	leaq	-0x20(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%r9)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%r9)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%r9)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%r9)
               	popq	%r11
               	leaq	-0x30(%rbp), %r9
               	movslq	(%r9), %r9
               	cmpq	$0x7, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0xe, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x15, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movl	$0x32, %eax
               	movl	%eax, (%r9)
               	leaq	-0x8(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0x3c, %eax
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r9
               	leaq	-0x8(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r9)
               	popq	%r11
               	leaq	-0x8(%rbp), %r9
               	movslq	(%r9), %r9
               	cmpq	$0x32, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %r9
               	cmpq	$0x3c, %r9
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
