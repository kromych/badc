
array_initializers.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	movzbq	0x4(%rcx), %r11
               	movb	%r11b, 0x4(%rax)
               	movzbq	0x5(%rcx), %r11
               	movb	%r11b, 0x5(%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movzbq	0x10(%rcx), %r11
               	movb	%r11b, 0x10(%rax)
               	movzbq	0x11(%rcx), %r11
               	movb	%r11b, 0x11(%rax)
               	movzbq	0x12(%rcx), %r11
               	movb	%r11b, 0x12(%rax)
               	movzbq	0x13(%rcx), %r11
               	movb	%r11b, 0x13(%rax)
               	popq	%r11
               	leaq	<rip>, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rcx
               	movq	%rdx, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdx, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdx, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	addq	$0x10, %rdx
               	movslq	(%rdx), %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x69, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0xf, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x61, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x62, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x61, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x77, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x5, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x16, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x258, %rax            # imm = 0x258
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x18, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x6b, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	addq	$0x8, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rcx
               	addq	$0x10, %rcx
               	movslq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x7, %rcx
               	movzbq	(%rcx), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
