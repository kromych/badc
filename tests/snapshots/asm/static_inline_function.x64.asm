
static_inline_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	movl	$0x3, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	movq	%rax, 0x10(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	movq	0x10(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x10(%rbp), %rdx
               	andq	$0x1, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	leaq	0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	shrq	$0x1, %rcx
               	movq	%rcx, (%rax)
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
               	movl	$0x2, %eax
               	movl	$0x3, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0x3, %r11d
               	imulq	%r11, %rax
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0xdeadbeef, %edi       # imm = 0xDEADBEEF
               	callq	<addr>
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
