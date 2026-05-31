
struct_value_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
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
               	movq	%r11, %r9
               	leaq	-0x10(%rbp), %r9
               	movslq	(%r9), %r8
               	cmpq	$0x1, %r8
               	je	0x4002b3 <.text+0x93>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x2, %rax
               	je	0x4002e0 <.text+0xc0>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3e8, %r8d            # imm = 0x3E8
               	movl	%r8d, (%rax)
               	leaq	-0x8(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0x7d0, %r8d            # imm = 0x7D0
               	movl	%r8d, (%r11)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r8
               	cmpq	$0x1, %r8
               	je	0x400323 <.text+0x103>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x2, %rax
               	je	0x400350 <.text+0x130>
               	movl	$0x4, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x7, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x20(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0xe, %r8d
               	movl	%r8d, (%r11)
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movl	$0x15, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x30(%rbp), %r11
               	leaq	-0x20(%rbp), %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%r11)
               	movzbq	0x8(%r8), %rax
               	movb	%al, 0x8(%r11)
               	movzbq	0x9(%r8), %rax
               	movb	%al, 0x9(%r11)
               	movzbq	0xa(%r8), %rax
               	movb	%al, 0xa(%r11)
               	movzbq	0xb(%r8), %rax
               	movb	%al, 0xb(%r11)
               	popq	%rax
               	movq	%r11, %rax
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %r8
               	cmpq	$0x7, %r8
               	je	0x4003de <.text+0x1be>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r8
               	addq	$0x4, %r8
               	movslq	(%r8), %rax
               	cmpq	$0xe, %rax
               	je	0x40040b <.text+0x1eb>
               	movl	$0x6, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x15, %r8
               	je	0x400434 <.text+0x214>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	$0x32, %eax
               	movl	%eax, (%r8)
               	leaq	-0x8(%rbp), %r11
               	addq	$0x4, %r11
               	movl	$0x3c, %eax
               	movl	%eax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	leaq	-0x8(%rbp), %rax
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%r8)
               	popq	%r11
               	movq	%r8, %r11
               	leaq	-0x8(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0x32, %rax
               	je	0x40048e <.text+0x26e>
               	movl	$0x8, %r11d
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x3c, %r11
               	je	0x4004b7 <.text+0x297>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
