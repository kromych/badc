
static_inline_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movl	$0x3, %r11d
               	imulq	%r11, %rdi
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rax
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	xorq	%r9, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	<addr>
               	movq	0x10(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	-0x8(%rbp), %rdi
               	movq	(%rdi), %r9
               	movq	0x10(%rbp), %r8
               	andq	$0x1, %r8
               	addq	%r8, %r9
               	movq	%r9, (%rdi)
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r9
               	shrq	$0x1, %r9
               	movq	%r9, (%r8)
               	jmp	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %r11d
               	movl	$0x3, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %r11
               	movl	$0x3, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$-0x2, %r11
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	popq	%rbp
               	retq
               	movl	$0xdeadbeef, %edi       # imm = 0xDEADBEEF
               	callq	<addr>
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x3, %edi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	callq	<addr>
               	movq	%rax, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movq	%rdi, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
