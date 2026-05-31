
static_inline_function.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movl	$0x3, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%r11, 0x10(%rbp)
               	xorq	%r9, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	<addr>
               	movq	0x10(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r9
               	movq	0x10(%rbp), %r8
               	andq	$0x1, %r8
               	addq	%r8, %r9
               	movq	%r9, (%r11)
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x2, %r11d
               	movl	$0x3, %r10d
               	imulq	%r10, %r11
               	movslq	%r11d, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	cmpq	$0x7, %r11
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
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
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xdeadbeef, %ebx       # imm = 0xDEADBEEF
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
