
ssa_va_arg_loop.x64:	file format elf64-x86-64

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
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r11
               	movq	%r11, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, -0x10(%rbp)
               	movl	%eax, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %rax
               	movslq	0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rcx
               	addq	$0x1, %rcx
               	movl	%ecx, (%rax)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x8(%rbp), %rdx
               	movq	%rdx, %r11
               	movq	(%r11), %rdx
               	leaq	0x10(%rdx), %rdx
               	movq	%rdx, (%r11)
               	leaq	-0x10(%rdx), %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	0x10(%rbp), %rcx
               	leaq	0x10(%rcx), %r11
               	movq	%r11, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, %r11
               	movq	(%r11), %rax
               	leaq	0x10(%rax), %rax
               	movq	%rax, (%r11)
               	leaq	-0x10(%rax), %rax
               	movq	(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0x14, %edx
               	movl	$0x1e, %ecx
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movl	$0x4, %r8d
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%r8, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rcx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x60, %rsp
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	movl	$0x2a, %esi
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
