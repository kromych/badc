
inline_asm_memory_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %eax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rbx
               	movl	$0x14, %ecx
               	movl	$0xa, %eax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x20(%rbp), %rbx
               	movl	$0x1e, %ecx
               	movl	$0x63, %eax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	$0x3, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leaq	-0x18(%rbp), %rbx
               	lock
               	xaddl	%eax, (%rbx)
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x64, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rbx
               	movl	$0xc8, %ecx
               	movl	$0x64, %eax
               	lock
               	cmpxchgq	%rcx, (%rbx)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x64, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0xc8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
