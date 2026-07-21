
inline_asm_memory_operand.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x58(%rbp), %rcx
               	movl	$0x14, %edx
               	movl	$0xa, %esi
               	movq	%rax, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%rbx, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	-0x90(%rbp), %rbx
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movq	-0x98(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	movq	-0xa0(%rbp), %rbx
               	movl	-0x58(%rbp), %eax
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	movl	$0x1e, %edx
               	movl	$0x63, %esi
               	movq	%rax, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%rbx, -0xa0(%rbp)
               	movq	%rcx, -0x98(%rbp)
               	movq	%rax, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	movq	%rsi, -0x80(%rbp)
               	movq	-0x90(%rbp), %rbx
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rax
               	lock
               	cmpxchgl	%ecx, (%rbx)
               	movq	-0x98(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	movq	-0xa0(%rbp), %rbx
               	movl	-0x60(%rbp), %eax
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rcx
               	movq	%rax, -0xb0(%rbp)
               	movq	%rbx, -0xa8(%rbp)
               	movq	%rcx, -0xa0(%rbp)
               	movq	%rax, -0x98(%rbp)
               	movq	-0xa0(%rbp), %r11
               	movl	(%r11), %eax
               	movq	-0x98(%rbp), %rbx
               	lock
               	xaddl	%eax, (%rbx)
               	movq	-0xa0(%rbp), %r11
               	movl	%eax, (%r11)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rbx
               	movl	-0x68(%rbp), %eax
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %eax
               	movq	%rax, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movl	$0xc8, %edx
               	leaq	-0x70(%rbp), %rsi
               	movq	%rax, -0xb0(%rbp)
               	movq	%rcx, -0xa8(%rbp)
               	movq	%rbx, -0xa0(%rbp)
               	movq	%rsi, -0x98(%rbp)
               	movq	%rcx, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	movq	%rax, -0x80(%rbp)
               	movq	-0x90(%rbp), %rbx
               	movq	-0x88(%rbp), %rcx
               	movq	-0x80(%rbp), %rax
               	lock
               	cmpxchgq	%rcx, (%rbx)
               	movq	-0x98(%rbp), %r11
               	movq	%rax, (%r11)
               	movq	-0xb0(%rbp), %rax
               	movq	-0xa8(%rbp), %rcx
               	movq	-0xa0(%rbp), %rbx
               	movq	-0x70(%rbp), %rax
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
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
