
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
               	subq	$0x70, %rsp
               	movl	$0xa, %eax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x14, %edx
               	movl	$0xa, %esi
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movq	-0x58(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movl	-0x8(%rbp), %eax
               	xorq	$0xa, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x1e, %edx
               	movl	$0x63, %esi
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rsi, -0x40(%rbp)
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movq	-0x58(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movl	-0x8(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	-0x20(%rbp), %eax
               	xorq	$0x14, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, -0x70(%rbp)
               	movq	%rbx, -0x68(%rbp)
               	movq	%rcx, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	movl	(%r10), %eax
               	movq	-0x58(%rbp), %rbx
               	lock
               	xaddl	%eax, (%rbx)
               	movq	-0x60(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rbx
               	movl	-0x8(%rbp), %eax
               	xorq	$0x5, %rax
               	movl	%eax, %ecx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	-0x18(%rbp), %eax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %ecx
               	movl	$0xc8, %edx
               	leaq	-0x8(%rbp), %rsi
               	movq	%rax, -0x70(%rbp)
               	movq	%rcx, -0x68(%rbp)
               	movq	%rbx, -0x60(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	%rax, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	movq	%rcx, -0x40(%rbp)
               	movq	-0x50(%rbp), %rbx
               	movq	-0x48(%rbp), %rcx
               	movq	-0x40(%rbp), %rax
               	lock
               	cmpxchgq	%rcx, (%rbx)
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rbx
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0xc8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
