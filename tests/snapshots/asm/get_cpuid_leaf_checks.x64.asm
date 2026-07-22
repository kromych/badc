
get_cpuid_leaf_checks.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<__get_cpuid>:
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	retq

<__get_cpuid_count>:
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x210, %rsp            # imm = 0x210
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	movl	%eax, -0x18(%rbp)
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x20(%rbp), %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	-0x8(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x10(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x18(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x20(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	movl	%eax, -0x68(%rbp)
               	movl	%eax, -0x70(%rbp)
               	movl	%eax, -0x78(%rbp)
               	movl	%eax, -0x80(%rbp)
               	leaq	-0x68(%rbp), %rax
               	leaq	-0x70(%rbp), %rax
               	leaq	-0x78(%rbp), %rax
               	leaq	-0x80(%rbp), %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	-0x68(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x70(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0x78(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0x80(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	movl	%eax, -0xc8(%rbp)
               	movl	%eax, -0xd0(%rbp)
               	movl	%eax, -0xd8(%rbp)
               	movl	%eax, -0xe0(%rbp)
               	leaq	-0xc8(%rbp), %rax
               	leaq	-0xd0(%rbp), %rax
               	leaq	-0xd8(%rbp), %rax
               	leaq	-0xe0(%rbp), %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	-0xc8(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	movq	%rax, %rcx
               	cmpq	%r11, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0xd0(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0xd8(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0xe0(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	movl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	movl	%eax, -0x128(%rbp)
               	movl	%eax, -0x130(%rbp)
               	movl	%eax, -0x138(%rbp)
               	movl	%eax, -0x140(%rbp)
               	movl	%eax, -0x148(%rbp)
               	movl	%eax, -0x150(%rbp)
               	movl	%eax, -0x158(%rbp)
               	movl	%eax, -0x160(%rbp)
               	leaq	-0x128(%rbp), %rax
               	leaq	-0x130(%rbp), %rax
               	leaq	-0x138(%rbp), %rax
               	leaq	-0x140(%rbp), %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	-0x128(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x130(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	-0x138(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x140(%rbp), %eax
               	movl	$0xa5a5a5a5, %r11d      # imm = 0xA5A5A5A5
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x210, %rsp            # imm = 0x210
               	popq	%rbp
               	retq
               	leaq	-0x148(%rbp), %rax
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x160(%rbp), %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	leaq	-0x148(%rbp), %rax
               	leaq	-0x150(%rbp), %rax
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x160(%rbp), %rax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
