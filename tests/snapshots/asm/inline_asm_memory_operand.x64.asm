
inline_asm_memory_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<cas32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	%edx, %ecx
               	movl	%esi, %edx
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	0x10(%rsp), %rbx
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movq	0x18(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movl	-0x8(%rbp), %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<xadd32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%esi, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %r11
               	movl	(%r11), %eax
               	movq	(%rsp), %rbx
               	lock
               	xaddl	%eax, (%rbx)
               	movq	0x8(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%rax
               	movl	-0x8(%rbp), %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<cas64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	0x10(%rsp), %rbx
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rax
               	lock
               	cmpxchgq	%rcx, (%rbx)
               	movq	0x18(%rsp), %r11
               	movq	%rax, (%r11)
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0xa, %esi
               	movl	%esi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x14, %edx
               	callq	<addr>
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x63, %esi
               	movl	$0x1e, %edx
               	callq	<addr>
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %esi
               	movq	%rsi, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0xc8, %edx
               	callq	<addr>
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xc8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
