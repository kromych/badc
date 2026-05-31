
bitfield_brace_init.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %r9
               	pushq	%rax
               	movzbq	(%r9), %rax
               	movb	%al, (%r11)
               	popq	%rax
               	movq	%r11, %r8
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r9
               	andq	$0x3, %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %rax
               	sarq	$0x2, %rax
               	andq	$0x3, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %r9
               	sarq	$0x4, %r9
               	andq	$0x3, %r9
               	cmpq	$0x3, %r9
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movzbq	(%r9), %rax
               	sarq	$0x6, %rax
               	andq	$0x3, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %r9
               	pushq	%r11
               	movzbq	(%r9), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%r9), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%r9), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%r9), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movq	%rax, %r11
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r9d
               	andq	$0xff, %r9
               	cmpq	$0xab, %r9
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r9
               	movl	(%r9), %eax
               	sarq	$0x8, %rax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %r9d
               	sarq	$0x9, %r9
               	andq	$0x7fffff, %r9          # imm = 0x7FFFFF
               	cmpq	$0x12345, %r9           # imm = 0x12345
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r9)
               	popq	%r11
               	movq	%r9, %r11
               	leaq	-0x18(%rbp), %r11
               	movzbq	(%r11), %rax
               	andq	$0x7, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1f, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movzbq	(%rax), %r11
               	sarq	$0x3, %r11
               	andq	$0x7, %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movzbq	(%r11), %rax
               	sarq	$0x6, %rax
               	andq	$0x3, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x21, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %r11
               	pushq	%rcx
               	movzbq	(%r11), %rcx
               	movb	%cl, (%rax)
               	popq	%rcx
               	movq	%rax, %r9
               	leaq	-0x20(%rbp), %r9
               	movzbq	(%r9), %r11
               	andq	$0x3, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movzbq	(%r11), %rax
               	sarq	$0x2, %rax
               	andq	$0x3, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2a, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %r11
               	sarq	$0x4, %r11
               	andq	$0x3, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movzbq	(%r11), %rax
               	sarq	$0x6, %rax
               	andq	$0x3, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2c, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
