
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
               	movzbq	(%r8), %r8
               	andq	$0x3, %r8
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	sarq	$0x2, %r8
               	andq	$0x3, %r8
               	cmpq	$0x2, %r8
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	sarq	$0x4, %r8
               	andq	$0x3, %r8
               	cmpq	$0x3, %r8
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movzbq	(%r8), %r8
               	sarq	$0x6, %r8
               	andq	$0x3, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r8)
               	movzbq	0x1(%rax), %r11
               	movb	%r11b, 0x1(%r8)
               	movzbq	0x2(%rax), %r11
               	movb	%r11b, 0x2(%r8)
               	movzbq	0x3(%rax), %r11
               	movb	%r11b, 0x3(%r8)
               	popq	%r11
               	movq	%r8, %r11
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	andq	$0xff, %r11
               	cmpq	$0xab, %r11
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x8, %r11
               	andq	$0x1, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	movl	(%r11), %r11d
               	sarq	$0x9, %r11
               	andq	$0x7fffff, %r11         # imm = 0x7FFFFF
               	cmpq	$0x12345, %r11          # imm = 0x12345
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%r11)
               	popq	%rcx
               	movq	%r11, %r8
               	leaq	-0x18(%rbp), %r8
               	movzbq	(%r8), %r8
               	andq	$0x7, %r8
               	cmpq	$0x7, %r8
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movzbq	(%r8), %r8
               	sarq	$0x3, %r8
               	andq	$0x7, %r8
               	cmpq	$0x7, %r8
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movzbq	(%r8), %r8
               	sarq	$0x6, %r8
               	andq	$0x3, %r8
               	cmpq	$0x3, %r8
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%r11
               	movzbq	(%rax), %r11
               	movb	%r11b, (%r8)
               	popq	%r11
               	movq	%r8, %r11
               	leaq	-0x20(%rbp), %r11
               	movzbq	(%r11), %r11
               	andq	$0x3, %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movzbq	(%r11), %r11
               	sarq	$0x2, %r11
               	andq	$0x3, %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x2a, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movzbq	(%r11), %r11
               	sarq	$0x4, %r11
               	andq	$0x3, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2b, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %r11
               	movzbq	(%r11), %r11
               	sarq	$0x6, %r11
               	andq	$0x3, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x2c, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
