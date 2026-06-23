
ternary_middle_comma.x64:	file format elf64-x86-64

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
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%r13, 0x20(%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movl	$0x2a, %ebx
               	movl	%ebx, %eax
               	cmpq	$0x80, %rax
               	jae	<addr>
               	leaq	-0x8(%rbp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %r12d
               	jmp	<addr>
               	movl	$0x63, %r12d
               	movslq	%r12d, %rax
               	cmpq	$0x1, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movl	%ebx, %eax
               	cmpq	$0x80, %rax
               	jae	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %r12d
               	jmp	<addr>
               	movl	$0x63, %r12d
               	movslq	%r12d, %rax
               	cmpq	$0x1, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	leaq	-0x20(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movl	%ebx, %eax
               	cmpq	$0x80, %rax
               	jae	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rax)
               	movl	$0x1, %r12d
               	jmp	<addr>
               	movl	$0x63, %r12d
               	movslq	%r12d, %rax
               	cmpq	$0x1, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x2a, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	leaq	-0x30(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	testq	%rbx, %rbx
               	jle	<addr>
               	movl	$0x1, %r15d
               	movl	$0x2, %r14d
               	movl	$0x3, %r12d
               	leaq	(%r15,%r14), %rax
               	addq	%r12, %rax
               	movslq	%eax, %rbx
               	jmp	<addr>
               	movabsq	$-0x1, %rbx
               	movq	%r12, %r14
               	movq	%r12, %r15
               	movslq	%ebx, %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%r15d, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1, %r10d
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movslq	%r14d, %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x30(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	movslq	%r12d, %rax
               	cmpq	$0x3, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x30(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movslq	%r15d, %rdx
               	movslq	%r14d, %rcx
               	movslq	%r12d, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movzbq	(%rcx), %r11
               	movb	%r11b, (%rax)
               	movzbq	0x1(%rcx), %r11
               	movb	%r11b, 0x1(%rax)
               	movzbq	0x2(%rcx), %r11
               	movb	%r11b, 0x2(%rax)
               	movzbq	0x3(%rcx), %r11
               	movb	%r11b, 0x3(%rax)
               	popq	%r11
               	movl	$0xc8, %eax
               	movl	%eax, %ecx
               	cmpq	$0x80, %rcx
               	jae	<addr>
               	leaq	-0x60(%rbp), %rcx
               	andq	$0xff, %rax
               	movb	%al, (%rcx)
               	movl	$0x1, %ebx
               	jmp	<addr>
               	movl	$0x63, %ebx
               	movslq	%ebx, %rax
               	cmpq	$0x63, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	0x20(%rsp), %r13
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
