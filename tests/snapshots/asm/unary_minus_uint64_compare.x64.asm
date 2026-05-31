
unary_minus_uint64_compare.x64:	file format elf64-x86-64

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
               	movl	$0xa8, %r11d
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	$0x1000, %r11           # imm = 0x1000
               	jae	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %r11
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r11)
               	popq	%rcx
               	leaq	-0x10(%rbp), %r11
               	movq	(%r11), %r11
               	movslq	%r11d, %r11
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	$0x1000, %r11           # imm = 0x1000
               	jae	<addr>
               	movl	$0xc, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa8, %r11d
               	movabsq	$-0x1, %r10
               	imulq	%r10, %r11
               	cmpq	$0x1000, %r11           # imm = 0x1000
               	jae	<addr>
               	movl	$0x1, %eax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	movl	$0x2, %eax
               	movq	%rax, -0x38(%rbp)
               	jmp	<addr>
               	movq	-0x38(%rbp), %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xd, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	movabsq	$-0x1, %r11
               	imulq	%r11, %rax
               	cmpq	$0x1000, %rax           # imm = 0x1000
               	jae	<addr>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
