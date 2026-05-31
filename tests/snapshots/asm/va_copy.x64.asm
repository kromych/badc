
va_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d1 <.text+0xb1>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	leaq	0x10(%rbp), %r9
               	leaq	0x10(%r9), %r10
               	movq	%r10, (%r11)
               	leaq	-0x10(%rbp), %r8
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, (%r8)
               	xorq	%r11, %r11
               	movl	%r11d, -0x18(%rbp)
               	movl	%r11d, -0x20(%rbp)
               	jmp	0x40026f <.text+0x4f>
               	movslq	-0x20(%rbp), %r11
               	movslq	0x10(%rbp), %r9
               	cmpq	%r9, %r11
               	jge	0x4002bc <.text+0x9c>
               	movslq	-0x18(%rbp), %r9
               	leaq	-0x10(%rbp), %r8
               	movq	(%r8), %r11
               	leaq	0x10(%r11), %r10
               	movq	%r10, (%r8)
               	movslq	(%r11), %r8
               	movq	%r9, %r11
               	addq	%r8, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x18(%rbp)
               	movslq	-0x20(%rbp), %r8
               	movq	%r8, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x20(%rbp)
               	jmp	0x40026f <.text+0x4f>
               	leaq	-0x10(%rbp), %r11
               	leaq	-0x8(%rbp), %r8
               	movslq	-0x18(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x4, %ebx
               	movl	$0xa, %r12d
               	movl	$0x14, %r14d
               	movl	$0x1e, %r10d
               	movq	%r10, 0x28(%rsp)
               	movl	$0x28, %r15d
               	subq	$0x10, %rsp
               	movq	%r15, (%rsp)
               	movq	0x38(%rsp), %r10
               	subq	$0x10, %rsp
               	movq	%r10, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r12, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	callq	0x400237 <.text+0x17>
               	addq	$0x50, %rsp
               	cmpq	$0x64, %rax
               	je	0x40038d <.text+0x16d>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
