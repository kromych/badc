
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
               	movq	%r8, %r9
               	addq	$0x4, %r9
               	movl	$0x2, %r8d
               	movl	%r8d, (%r9)
               	leaq	-0x10(%rbp), %r11
               	movl	$0x63, %r8d
               	movl	%r8d, (%r11)
               	leaq	-0x10(%rbp), %r9
               	movq	%r9, %r11
               	addq	$0x4, %r11
               	movl	%r8d, (%r11)
               	leaq	-0x10(%rbp), %r9
               	leaq	-0x8(%rbp), %r11
               	pushq	%rax
               	movq	(%r11), %rax
               	movq	%rax, (%r9)
               	popq	%rax
               	movq	%r9, %r8
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %r11
               	cmpq	$0x1, %r11
               	je	0x4002b9 <.text+0x99>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x2, %r8
               	je	0x4002e9 <.text+0xc9>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x3e8, %r8d            # imm = 0x3E8
               	movl	%r8d, (%rax)
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movl	$0x7d0, %r9d            # imm = 0x7D0
               	movl	%r9d, (%r8)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x1, %r9
               	je	0x400333 <.text+0x113>
               	movl	$0x3, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x2, %rax
               	je	0x40035f <.text+0x13f>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r9
               	movl	$0x7, %eax
               	movl	%eax, (%r9)
               	leaq	-0x20(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movl	$0xe, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x20(%rbp), %r9
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	movl	$0x15, %r9d
               	movl	%r9d, (%r8)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x20(%rbp), %r9
               	pushq	%r11
               	movq	(%r9), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%r9), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%r9), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%r9), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%r9), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	movq	%rax, %r8
               	leaq	-0x30(%rbp), %r8
               	movslq	(%r8), %r9
               	cmpq	$0x7, %r9
               	je	0x4003f4 <.text+0x1d4>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r8
               	cmpq	$0xe, %r8
               	je	0x400424 <.text+0x204>
               	movl	$0x6, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, %r8
               	addq	$0x8, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x15, %rax
               	je	0x400450 <.text+0x230>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movl	$0x32, %eax
               	movl	%eax, (%r8)
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, %rax
               	addq	$0x4, %rax
               	movl	$0x3c, %r9d
               	movl	%r9d, (%rax)
               	leaq	-0x8(%rbp), %r8
               	leaq	-0x8(%rbp), %r9
               	pushq	%rax
               	movq	(%r9), %rax
               	movq	%rax, (%r8)
               	popq	%rax
               	movq	%r8, %rax
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %r9
               	cmpq	$0x32, %r9
               	je	0x4004ac <.text+0x28c>
               	movl	$0x8, %r9d
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r9
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x3c, %rax
               	je	0x4004d8 <.text+0x2b8>
               	movl	$0x9, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
