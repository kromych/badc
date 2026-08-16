
anon_bitfield_reserves_bits.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x8(%rbp), %rbx
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x4, %r12d
               	movq	%r12, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movl	$0x1, %ecx
               	movzbq	0x2(%rax), %rdx
               	andq	$-0x5, %rdx
               	orq	%r12, %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x1(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rbx), %rax
               	xorq	$0x4, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rcx
               	andq	$-0xf9, %rcx
               	orq	$0xf8, %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x1(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rbx), %rax
               	xorq	$0xf8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x3(%rax), %rcx
               	andq	$-0x80, %rcx
               	orq	$0x7f, %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x1(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rbx), %rax
               	xorq	$0x7f, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x4, %ebx
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movl	$0x1, %eax
               	movzbq	0x2(%rcx), %rdx
               	andq	$-0x5, %rdx
               	orq	%rbx, %rdx
               	movb	%dl, 0x2(%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movzbq	0x2(%rcx), %rdx
               	andq	$-0xf9, %rdx
               	orq	$0x48, %rdx
               	movb	%dl, 0x2(%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movzbq	0x3(%rcx), %rdx
               	andq	$-0x80, %rdx
               	orq	$0x64, %rdx
               	movb	%dl, 0x3(%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movzbq	0x2(%rcx), %rcx
               	sarq	$0x2, %rcx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	sarq	$0x3, %rax
               	andq	$0x1f, %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x3(%rax), %rax
               	andq	$0x7f, %rax
               	cmpq	$0x64, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rbx
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movl	$0xff, %ecx
               	movb	%cl, 0x3(%rax)
               	movzbq	(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x1(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movzbq	0x2(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0x3(%rbx), %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x11223344, %ecx       # imm = 0x11223344
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x55667788, %ecx       # imm = 0x55667788
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	0x8(%rax), %eax
               	xorq	$0x11223344, %rax       # imm = 0x11223344
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movl	0xc(%rax), %eax
               	xorq	$0x55667788, %rax       # imm = 0x55667788
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0x30(%rbp), %rcx
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
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
