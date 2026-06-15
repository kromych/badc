
stdatomic_c11.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xa, %ecx
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x63, %edx
               	movslq	(%rax), %rsi
               	movslq	(%rcx), %rdi
               	cmpq	%rdi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorq	%r9, %r9
               	subq	%r8, %r9
               	xorq	%rsi, %rdx
               	andq	%r9, %rdx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movq	%rsi, %rax
               	xorq	%rdi, %rax
               	andq	%r9, %rax
               	xorq	%rsi, %rax
               	movl	%eax, (%rcx)
               	testq	%r8, %r8
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	popq	%r11
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ecx
               	movzbq	(%rax), %rdx
               	movb	%cl, (%rax)
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movl	%ecx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x2a, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0x64, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x65, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	movl	$0xffffffff, %ecx       # imm = 0xFFFFFFFF
               	xorq	%rsi, %rsi
               	cmpq	$0x7fff, %rax           # imm = 0x7FFF
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	movq	%rcx, %rax
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
